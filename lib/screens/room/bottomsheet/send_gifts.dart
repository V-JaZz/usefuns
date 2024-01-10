import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/gifts_provider.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:live_app/provider/zego_room_provider.dart';
import 'package:live_app/utils/common_widgets.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:live_app/utils/zego_config.dart';
import 'package:provider/provider.dart';
import '../../../data/model/body/zego_stream_model.dart';
import '../../../data/model/response/gifts_model.dart';

class SendGiftsBottomSheet extends StatefulWidget {
  final String? selection;
  const SendGiftsBottomSheet({Key? key, this.selection}) : super(key: key);

  @override
  State<SendGiftsBottomSheet> createState() => _SendGiftsBottomSheetState();
}

class _SendGiftsBottomSheetState extends State<SendGiftsBottomSheet> {
  List<String> _selectedStream = [];
  TextEditingController countController = TextEditingController();
  Gift? selectedGift;
  int? selectedGiftCost;
  String? selectedPurchaseOption;
  String? selectedPaymentOption;
  bool animateIcon = false;

  @override
  void initState() {
    Provider.of<GiftsProvider>(context, listen: false).getAll();
    var list = Provider.of<ZegoRoomProvider>(context,listen: false).roomStreamList.where((e) => e.streamId != ZegoConfig.instance.userID).toList();
    countController.text = '1';
    if (widget.selection != null) {
      _selectedStream.add(widget.selection!);
    }else if(list.isNotEmpty){
      list.sort((a, b) => a.seat!.compareTo(b.seat!));
      _selectedStream.add(list.first.userName!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Consumer<GiftsProvider>(
      builder: (context, giftProvider, _) {

        double setLevelProgressValue(int level, double xp) {
          if(level==0) return xp/giftProvider.series![level].toInt();
          return (xp-giftProvider.series![level-1])/(giftProvider.series![level]-giftProvider.series![level-1]).toInt();
        }

        return Container(
        color: Colors.black.withOpacity(0.7),
        child: !giftProvider.giftLoading
            ? DefaultTabController(
                length: giftProvider.allGifts!.keys.length,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Consumer<UserDataProvider>(
                      builder:(context, up, child) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 5 * a,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  height: 5 * a,
                                ),
                                Text(
                                  'Lvl.${up.userData?.data?.level??0}',
                                  textAlign: TextAlign.left,
                                  style: SafeGoogleFont(
                                      color: const Color.fromRGBO(255, 255, 255, 1),
                                      'Poppins',
                                      fontSize: 12 * a,
                                      letterSpacing: 0 ,
                                      fontWeight: FontWeight.normal,
                                      height: 1 * b / a),
                                ),
                                const Spacer(),
                                Text(
                                  'Need ${(giftProvider.series![up.userData?.data?.level??0]-(up.userData?.data?.exp??0)).toInt()} EXP to upgrade',
                                  textAlign: TextAlign.left,
                                  style: SafeGoogleFont(
                                      color: const Color.fromRGBO(255, 255, 255, 1),
                                      'Poppins',
                                      fontSize: 12 * a,
                                      letterSpacing: 0 ,
                                      fontWeight: FontWeight.normal,
                                      height: 1 * b / a),
                                ),
                                const Spacer(),
                              ],
                            ),
                            SizedBox(
                              height: 10 * a,
                            ),
                            SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  trackHeight: 6,
                                  overlayShape: SliderComponentShape.noOverlay,
                                  thumbShape: SliderComponentShape.noThumb,
                                ),
                                child: Slider(
                                  min: 0,
                                  max: 1,
                                  value: setLevelProgressValue(up.userData?.data?.level??0,up.userData?.data?.exp??0),
                                  onChanged: (double value) {},
                                  inactiveColor: Colors.white,
                                  activeColor: const Color(0xff884EFF),
                                )),
                          ],
                        ),
                      ),
                    ),
                    const Divider(color: Colors.white54),
                    Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: TabBar(
                                indicatorColor: const Color(0xCC352D2D),
                                indicatorSize: TabBarIndicatorSize.label,
                                labelColor: Colors.white,
                                dividerColor: Colors.transparent,
                                unselectedLabelColor: const Color(0xCCFFFFFF),
                                labelStyle: SafeGoogleFont(
                                  'Poppins',
                                  fontSize: 12 * b,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5 * b / a,
                                  letterSpacing: 0.96 * a,
                                ),
                                unselectedLabelStyle: SafeGoogleFont(
                                  'Poppins',
                                  fontSize: 12 * b,
                                  fontWeight: FontWeight.w300,
                                  height: 1.5 * b / a,
                                  letterSpacing: 0.96 * a,
                                ),
                                padding:
                                    EdgeInsets.symmetric(horizontal: 8 * a),
                                labelPadding:
                                    EdgeInsets.symmetric(horizontal: 12 * a),
                                isScrollable: true,
                                tabs: List.generate(
                                  giftProvider.allGifts!.keys.length,
                                  (index) => Tab(
                                    text: giftProvider.allGifts!.keys
                                        .elementAt(index),
                                  ),
                                )),
                          ),
                        ),
                        Image.asset('assets/icons/ic_diamond.png',
                            height: 12 * a, width: 12 * a),
                        SizedBox(width: 6 * a),
                        Text(
                          Provider.of<UserDataProvider>(context)
                              .userData!
                              .data!
                              .diamonds
                              .toString(),
                          style: SafeGoogleFont(
                            'Roboto',
                            fontSize: 16 * b,
                            fontWeight: FontWeight.w400,
                            height: 1.171875 * b / a,
                            color: const Color(0xffffffff),
                          ),
                        ),
                        SizedBox(width: 18 * a)
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                          children: List.generate(
                        giftProvider.allGifts!.keys.length,
                        (index) => Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 18 * a, vertical: 8 * a),
                          child: GridView(
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3, childAspectRatio: 1),
                              children: List.generate(
                                  giftProvider
                                      .allGifts![giftProvider.allGifts!.keys
                                          .elementAt(index)]!
                                      .length, (i) {
                                final gift = giftProvider.allGifts![giftProvider
                                    .allGifts!.keys
                                    .elementAt(index)]![i];
                                return iconTextRow(
                                    gift.name ?? '', gift, '${gift.coin ?? 0}');
                              })),
                        ),
                      )),
                    ),
                    Consumer<ZegoRoomProvider>(
                      builder: (context, zegoRoomProvider, child) => Padding(
                        padding: EdgeInsets.only(
                            left: 36 * a, right: 36 * a, bottom: 10 * a),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                _showBottomLeftDialog((List<String> ss) {
                                  setState(() {
                                    _selectedStream = ss;
                                  });
                                }, _selectedStream);
                              },
                              child: Row(
                                children: [
                                  Text(
                                      _selectedStream.isEmpty
                                          ? 'To : pick user to see '
                                          : '${_selectedStream.length} selected',
                                      style: SafeGoogleFont(
                                        'DM Sans',
                                        fontSize: 12 * b,
                                        fontWeight: FontWeight.w400,
                                        height: 1.1666666667 * b / a,
                                        color: const Color(0xffffffff),
                                      )),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.white,
                                    size: 12 * a,
                                  )
                                ],
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                final user = Provider.of<UserDataProvider>(context, listen: false).userData;
                                if (_selectedStream.isEmpty) {
                                  showCustomSnackBar(
                                      "no user selected!", context,
                                      isToaster: true);
                                } else if (selectedGift == null) {
                                  showCustomSnackBar(
                                      "no gift selected!", context,
                                      isToaster: true);
                                } else
                                if ((user?.data?.diamonds ?? 0) <
                                    (selectedGiftCost ?? 0)*(_selectedStream.length)*(int.tryParse(countController.text)??1)) {
                                  showInsufficientDialog(context,(selectedGiftCost ?? 0)*(_selectedStream.length)*(int.tryParse(countController.text)??1)-(user?.data?.diamonds ?? 0));
                                } else if (countController.text.trim() ==
                                    '' ||
                                    countController.text.trim() == '0' ||
                                    int.tryParse(countController.text
                                        .trim()) ==
                                        null) {
                                  showCustomSnackBar(
                                      "Invalid count selected!", context,
                                      isToaster: true);
                                } else {
                                  giftProvider.sendGift(
                                      user!.data!.id!,
                                      zegoRoomProvider.roomUsersList.where((e) => _selectedStream.contains(e.userName)).map((e) => e.userID).toList(),
                                      selectedGift!.id!,
                                      int.parse(countController.text.trim()),
                                      zegoRoomProvider.room!.id!,
                                      selectedGift?.coin ?? 0);
                                  zegoRoomProvider.sendBroadcastGift(
                                      _selectedStream,
                                      selectedGift!.images![1],
                                      selectedGift!.images![0],
                                      selectedGift!.coin??1,
                                      int.parse(countController.text.trim()));
                                  setState(() => selectedGift = null);
                                }
                              },
                              child: Container(
                                width: 118 * a,
                                height: 27 * a,
                                decoration: BoxDecoration(
                                  color: const Color(0xff1877f2),
                                  borderRadius: BorderRadius.circular(3 * a),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 52 * a,
                                      margin: EdgeInsets.all(1 * a),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 6 * a),
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        color: const Color(0xff040106),
                                        borderRadius:
                                            BorderRadius.circular(3 * a),
                                      ),
                                      child: Center(
                                        child: TextField(
                                          controller: countController,
                                          decoration: textFieldDecoration(),
                                          maxLength: 5,
                                          keyboardType: TextInputType.number,
                                          style: SafeGoogleFont(
                                            'DM Sans',
                                            fontSize: 12 * b,
                                            fontWeight: FontWeight.w700,
                                            height: 1.1666666667 * b / a,
                                            color: const Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.transparent,
                                      padding: EdgeInsets.fromLTRB(
                                          15 * a, 0 * a, 15 * a, 0 * a),
                                      child: Text(
                                        'SEND',
                                        style: SafeGoogleFont(
                                          'DM Sans',
                                          fontSize: 12 * b,
                                          fontWeight: FontWeight.w700,
                                          height: 1.1666666667 * b / a,
                                          color: const Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [CircularProgressIndicator()],
                ),
              ),
      );
      },
    );
  }

  iconTextRow(String t, Gift p, String d) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    const duration = Duration(milliseconds: 300);

    return InkWell(
      onTap: () {
        setState(() {
          animateIcon = true;
          selectedGift = p;
          selectedGiftCost = int.parse(d);
        });
        Future.delayed(
            duration,
            () => setState(() {
                  animateIcon = false;
                }));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: selectedGift == p
                    ? const Color(0xff1877f2)
                    : Colors.transparent,
                width: 2),
            borderRadius: BorderRadius.circular(3 * a)),
        padding: EdgeInsets.symmetric(vertical: 4 * a, horizontal: 2 * a),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: duration,
              curve: Curves.bounceInOut,
              height: 54 * a,
              width: double.infinity,
              padding: EdgeInsets.all(selectedGift == p && animateIcon ? 6 : 0),
              child: Image.network(
                p.images![1],
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 3 * a),
            Text(
              t,
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: SafeGoogleFont(
                'Roboto',
                fontSize: 14 * b,
                fontWeight: FontWeight.w400,
                height: 1.1725 * b / a,
                color: const Color(0xffffffff),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/icons/ic_diamond.png',
                    height: 12 * a, width: 12 * a),
                SizedBox(width: 3 * a),
                Text(
                  d,
                  textAlign: TextAlign.center,
                  style: SafeGoogleFont(
                    'Roboto',
                    fontSize: 13 * b,
                    fontWeight: FontWeight.w400,
                    height: 1.1725 * b / a,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  textFieldDecoration() {
    return const InputDecoration(
      isDense: true,
      counterText: "",
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
    );
  }

  void _showBottomLeftDialog(Function callBack, List<String> ss) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.bottomLeft,
          child: FractionallySizedBox(
            widthFactor: 0.5,
            child: Card(
              child: CheckboxListTileWidget(
                  callBack: callBack, selectedStream: ss),
            ),
          ),
        );
      },
    );
  }
}

class CheckboxListTileWidget extends StatefulWidget {
  final Function callBack;
  final List<String> selectedStream;
  const CheckboxListTileWidget(
      {super.key, required this.callBack, required this.selectedStream});

  @override
  CheckboxListTileWidgetState createState() => CheckboxListTileWidgetState();
}

class CheckboxListTileWidgetState extends State<CheckboxListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ZegoRoomProvider>(
      builder: (context, p, child) {
        List<ZegoStreamExtended> list = p.roomStreamList
            .where(
                (element) => element.streamId != ZegoConfig.instance.userID)
            .toList();
        return list.isNotEmpty
            ? ListView(
                shrinkWrap: true,
                children: List.generate(
                  list.length,
                  (index) => CheckboxListTile(
                    title: Text(list[index].userName ?? ''),
                    value: widget.selectedStream.contains(list[index].userName),
                    onChanged: (bool? value) {
                      if (value == true) {
                        widget.selectedStream.add(list[index].userName ?? '');
                        setState(() {});
                      } else {
                        widget.selectedStream.removeWhere(
                            (element) => element == list[index].userName);
                        setState(() {});
                      }
                      widget.callBack(widget.selectedStream);
                    },
                  ),
                ))
            : const SizedBox(
                height: 90, child: Center(child: Text('Empty Seats!')));
      },
    );
  }
}
