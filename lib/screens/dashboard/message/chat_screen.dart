import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:live_app/data/model/response/user_data_model.dart';
import 'package:live_app/provider/messages_provider.dart';
import 'package:live_app/utils/common_widgets.dart';
import 'package:provider/provider.dart';
import '../../../data/model/body/firestore_message_model.dart';
import '../../../provider/user_data_provider.dart';
import '../../../utils/helper.dart';

class ChatScreen extends StatefulWidget {
  final UserData user;
  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> _list = [];
  final _textController = TextEditingController();
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollToBottom();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<MessagesNotificationsProvider>(
      builder: (context, value, _) => Scaffold(
        appBar: AppBar(
            title: Row(
              children: [
                CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(widget.user.images!.first),
              ),
                const SizedBox(width: 12),
                Text(widget.user.name!),
              ],
            ),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: value.getChatMessages(widget.user.id!),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                  //if data is loading
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const SizedBox.shrink();

                  //if some or all data is loaded then show it
                    case ConnectionState.active:
                    case ConnectionState.done:
                      final data = snapshot.data?.docs;
                      _list = data?.map((e) => Message.fromJson(e.data()))
                          .toList() ??
                          [];
                      _scrollToBottom();

                      if (_list.isNotEmpty) {
                        return ListView.builder(
                          controller: _controller,
                            itemCount: _list.length,
                            padding: EdgeInsets.only(top: Get.height * .01),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              bool isNewDate = index==0
                                  ? true
                                  : (_list[index].timeStamp.day != _list[index-1].timeStamp.day);
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if(isNewDate) Text( DateFormat('d MMM y').format(_list[index].timeStamp)),
                                  MessageCard(
                                      message: _list[index],
                                      userImage:widget.user.images?.first
                                  ),
                                ],
                              );
                            });
                      } else {
                        return const Center(
                          child: Text('Say Hii! 👋',
                              style: TextStyle(fontSize: 20)),
                        );
                      }
                  }
                }
              )
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              decoration: const BoxDecoration(
                color: Colors.black,
                // border: Border.all(color: Colors.black87),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          showCustomSnackBar('VIP required for attachments', context, isError: false, isToaster: true);
                        },
                        icon: const Icon(Icons.add, color: Colors.white),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          cursorColor: Colors.white,
                          minLines: 1,
                          maxLines: 5,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Type your message',
                            hintStyle: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if(_textController.text.isNotEmpty) {
                            value.sendMessage(widget.user.id!,_textController.text);
                            _textController.text = '';
                          }
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.jumpTo(_controller.position.maxScrollExtent);
    });
  }
}

class MessageCard extends StatelessWidget {
  final Message message;
  final String? userImage;
  const MessageCard({super.key, required this.message, this.userImage});

  @override
  Widget build(BuildContext context) {
    final myId = Provider.of<UserDataProvider>(Get.context!,listen: false).userData!.data!.id!;
    return message.fromId == myId
        ? Container(
          padding: const EdgeInsets.symmetric( horizontal: 10, vertical: 2),
          alignment: Alignment.topRight,
          child: Stack(
            children: [
              Container(
                // padding: EdgeInsets.only(top: 5.w, bottom: 14.w, right: 8.w, left: 13.w),
                constraints: const BoxConstraints(
                  maxWidth: 230,
                  maxHeight: 1500,
                  minWidth: 70
                ),
                padding: const EdgeInsets.only(
                  bottom: 15,
                  top: 5,
                  right: 35,
                  left: 12,
                ),
                decoration: BoxDecoration(
                    color: const Color(0xFF9E26BC),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(2)
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0,2)
                      )
                    ]
                ),
                child:  Text(
                  message.message,
                  maxLines: 10,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Positioned(
                bottom: 1,
                right: 10,
                child: Text(
                  DateFormat('h:mm a').format(message.timeStamp.toLocal()),
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withOpacity(0.9)
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        )
        : Container(
            padding: const EdgeInsets.symmetric( horizontal: 10, vertical: 2),
            alignment: Alignment.topLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(userImage!=null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    child: CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(userImage!)
                    ),
                  ),
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        bottom: 15,
                        top: 5,
                        right: 35,
                        left: 12,
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 3),
                      constraints: const BoxConstraints(
                        maxWidth: 230,
                        maxHeight: 1500,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(2),
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4,
                                offset: const Offset(0,2)
                            )
                          ]
                      ),
                      child: Text(
                        message.message,
                        textAlign: TextAlign.start,
                        maxLines: 10,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Positioned(
                      bottom: 4,
                      right: 10,
                      child: Text(
                        DateFormat('h:mm a').format(message.timeStamp.toLocal()),
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(0.9)
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
  }
}

