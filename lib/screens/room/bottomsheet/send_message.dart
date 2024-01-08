import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/utils/common_widgets.dart';
import 'package:provider/provider.dart';
import '../../../provider/zego_room_provider.dart';
import '../../../utils/zego_config.dart';

class SendMessageBottomSheet extends StatefulWidget {
  final String? mention;
  const SendMessageBottomSheet({super.key, this.mention});

  @override
  State<SendMessageBottomSheet> createState() => _SendMessageBottomSheetState();
}

class _SendMessageBottomSheetState extends State<SendMessageBottomSheet> {
  late TextEditingController controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.mention!=null?'@${widget.mention} ':'');
    _focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }
  @override
  void dispose() {
    _focusNode.unfocus();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return GestureDetector(
      onTap: () => Get.back(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            width: double.infinity,
            height: 60 * a,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20 * a),
                    child: SizedBox(
                      height: 40 * a,
                      width: 220 * a,
                      child: Center(
                        child: TextField(
                          focusNode: _focusNode,
                          controller: controller,
                          maxLength: 333,
                          maxLines: 1,
                          textInputAction: TextInputAction.send,
                          decoration: const InputDecoration(
                              hintText: 'Type a message',
                              counterText: ''
                          ),
                          onSubmitted: (value) {
                            submit();
                          },

                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showCustomSnackBar('Required SVIP to share images!', context,isError: true,isToaster: true);
                  },
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.image_rounded,
                        color: Colors.black,
                      ),
                      Text('SVIP',style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
                SizedBox(
                  width: 16 * a,
                ),
                InkWell(
                  onTap: submit,
                  child: Container(
                    height: 29,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: const Center(
                      child: Text(
                        'SEND',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10 * a,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submit() {
    final value = Provider.of<ZegoRoomProvider>(context,listen: false);
    if(value.roomStreamList.firstWhereOrNull((e) => e.streamId == ZegoConfig.instance.userID)?.chatBan == true){
      showCustomSnackBar('your chat is banned!', context,isToaster: true);
      return;
    }
    if(controller.text.trim() != '') value.sendBroadcastMessage(controller.text.trim());
    Get.back();
  }
}
