import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/gifts_provider.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:live_app/provider/zego_room_provider.dart';
import 'package:live_app/screens/dashboard/me/levelPriveleges.dart';
import 'package:live_app/utils/common_widgets.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:live_app/utils/zego_config.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
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
  int selectedCount = 1;
  Gift? selectedGift;
  int? selectedGiftCost;
  String? selectedPurchaseOption;
  String? selectedPaymentOption;
  bool animateIcon = false;

  @override
  void initState() {
    Provider.of<GiftsProvider>(context, listen: false).getAll();
    var list = Provider.of<ZegoRoomProvider>(context,listen: false).roomStreamList.where((e) => e.streamId != ZegoConfig.instance.userID).toList();
    selectedCount = 1;
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
        color: Colors.black87,
        child: DefaultTabController(
                length: giftProvider.allGifts.keys.length,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Consumer<UserDataProvider>(
                      builder:(context, up, child) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: Row(
                          children: [
                            const SizedBox(width: 8),
                            userLevelTag(up.userData?.data?.level??0,15*a,viewZero: true),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                children: [
                                  const SizedBox(height: 3),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(3 * a),
                                    child: SliderTheme(
                                        data: SliderTheme.of(context).copyWith(
                                          trackHeight: 5,
                                          overlayShape: SliderComponentShape.noOverlay,
                                          thumbShape: SliderComponentShape.noThumb,
                                          trackShape: const RectangularSliderTrackShape()
                                        ),
                                        child: Slider(
                                          min: 0,
                                          max: 1,
                                          value: setLevelProgressValue(up.userData?.data?.level??0,up.userData?.data?.exp??0),
                                          onChanged: (double value) {},
                                          inactiveColor: Colors.grey.shade400,
                                          activeColor: Theme.of(context).primaryColor,
                                        )),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Need ${(giftProvider.series![up.userData?.data?.level??0]-(up.userData?.data?.exp??0)).toInt()} diamonds to achieve Lv.${(up.userData?.data?.level??0)+1}',
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 10 * a,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              height: 30*a,
                              width: 30*a,
                              child: IconButton(
                                iconSize: 16*a,
                                onPressed: (){
                                  Get.to(()=>const LevelPrivileges());
                                },
                                icon: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.grey.shade400,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Divider(color: Colors.white38,height: 3),
                    const SizedBox(height: 4),
                    SizedBox(
                      height: 30 * a,
                      child: !giftProvider.giftLoading
                          ?Row(
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
                                  padding: EdgeInsets.symmetric(horizontal: 8 * a),
                                  labelPadding: EdgeInsets.symmetric(horizontal: 12 * a),
                                  isScrollable: true,
                                  tabs: List.generate(
                                    giftProvider.allGifts.keys.length,
                                    (index) => Tab(
                                      text: giftProvider.allGifts.keys.elementAt(index),
                                    ),
                                  )
                              ),
                            ),
                          ),
                          Image.asset('assets/icons/ic_diamond.png',
                              height: 11 * a, width: 11 * a),
                          SizedBox(width: 3 * a),
                          Text(
                            Provider.of<UserDataProvider>(context)
                                .userData!
                                .data!
                                .diamonds
                                .toString(),
                            style: SafeGoogleFont(
                              'Roboto',
                              fontSize: 12 * b,
                              fontWeight: FontWeight.w400,
                              height: 1.171875 * b / a,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 18 * a)
                        ],
                      )
                          :null,
                    ),
                    Container(
                      width: Get.width - 24 * a,
                      height: (Get.width - 24 * a) * 0.5,
                      margin: EdgeInsets.symmetric(horizontal: 12 * a,vertical: 8*a),
                      child: !giftProvider.giftLoading
                          ?TabBarView(
                          children: List.generate(
                        giftProvider.allGifts.keys.length,
                        (index) => GridView(
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4, childAspectRatio: 1),
                            children: List.generate(
                                giftProvider
                                    .allGifts[giftProvider.allGifts.keys
                                        .elementAt(index)]!
                                    .length, (i) {
                              final gift = giftProvider.allGifts[giftProvider
                                  .allGifts.keys
                                  .elementAt(index)]![i];
                              return giftContainer(gift);
                            })),
                      ))
                          :const Center(child: CircularProgressIndicator()),
                    ),
                    Consumer<ZegoRoomProvider>(
                      builder: (context, zegoRoomProvider, child) => Padding(
                        padding: EdgeInsets.only(
                            left: 32 * a, right: 32 * a, bottom: 8 * a),
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
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'To :  ',
                                      style: SafeGoogleFont(
                                        'DM Sans',
                                        fontSize: 12 * b,
                                        fontWeight: FontWeight.w400,
                                        height: 1.1666666667 * b / a,
                                        color: const Color(0xffffffff),
                                      )),
                                  Text(
                                      _selectedStream.isEmpty
                                          ? 'select '
                                          :
                                      _selectedStream.length==1
                                          ? '${_selectedStream.first} '
                                          : '${_selectedStream.length} selected ',
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
                                    (selectedGiftCost ?? 0)*(_selectedStream.length)*(selectedCount)) {
                                  showInsufficientDialog(context,((selectedGiftCost??1)*(_selectedStream.length)*(selectedCount))-(user?.data?.diamonds??0));
                                } else {
                                  giftProvider.sendGift(
                                      user!.data!.id!,
                                      zegoRoomProvider.roomUsersList.where((e) => _selectedStream.contains(e.userName)).map((e) => e.userID).toList(),
                                      selectedGift!.id!,
                                      selectedCount,
                                      zegoRoomProvider.room!.id!,
                                      selectedGift?.coin ?? 0);
                                  zegoRoomProvider.sendBroadcastGift(
                                      _selectedStream,
                                      selectedGift!.images![1],
                                      selectedGift!.images![0],
                                      selectedGift!.coin??1,
                                      selectedCount);
                                  setState(() => selectedGift = null);
                                }
                              },
                              child: Container(
                                width: 118 * a,
                                height: 27 * a,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(3 * a),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 54 * a,
                                      margin: EdgeInsets.all(1 * a),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 6 * a),
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        color: const Color(0xff040106),
                                        borderRadius:
                                            BorderRadius.circular(3 * a),
                                      ),
                                      child: DropdownButton<int>(
                                        isDense: true,
                                        padding: EdgeInsets.zero,
                                        alignment: AlignmentDirectional.centerEnd,
                                        // isExpanded: true,
                                        style: SafeGoogleFont(
                                          'DM Sans',
                                          fontSize: 12 * b,
                                          fontWeight: FontWeight.w700,
                                          height: 1.1666666667 * b / a,
                                          color: const Color(0xffffffff),
                                        ),
                                        dropdownColor: Colors.black87,
                                        underline: const SizedBox.shrink(),
                                        icon: Icon(
                                          Icons.arrow_drop_up_rounded,
                                          color: Colors.white70,
                                          size: 16*a,
                                        ),
                                        value: selectedCount,
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedCount = newValue!;
                                          });
                                        },
                                        items: const [
                                          DropdownMenuItem<int>(
                                            value: 1,
                                            child: Text('1'),
                                          ),
                                          DropdownMenuItem<int>(
                                            value: 9,
                                            child: Text('9'),
                                          ),
                                          DropdownMenuItem<int>(
                                            value: 49,
                                            child: Text('49'),
                                          ),
                                          DropdownMenuItem<int>(
                                            value: 99,
                                            child: Text('99'),
                                          ),
                                          DropdownMenuItem<int>(
                                            value: 499,
                                            child: Text('499'),
                                          ),
                                          DropdownMenuItem<int>(
                                            value: 999,
                                            child: Text('999'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: Colors.transparent,
                                        alignment: Alignment.center,
                                        child: Text(
                                          'SEND',
                                          textAlign: TextAlign.center,
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
      );
      },
    );
  }

  giftContainer(Gift gift) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    const duration = Duration(milliseconds: 300);

    return InkWell(
      onTap: () {
        setState(() {
          animateIcon = true;
          selectedGift = gift;
          selectedGiftCost = gift.coin ?? 0;
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
                color: selectedGift == gift
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
                width: 2),
            borderRadius: BorderRadius.circular(3 * a)),
        padding: EdgeInsets.symmetric(vertical: 4 * a, horizontal: 2 * a),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: AnimatedContainer(
                duration: duration,
                curve: Curves.bounceInOut,
                width: double.infinity,
                padding: EdgeInsets.all(selectedGift == gift && animateIcon ? 6 : 0),
                child: Image.network(
                  gift.images![1],
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Shimmer.fromColors(
                        highlightColor: Theme.of(context).primaryColor.withOpacity(0.3),
                        baseColor: Theme.of(context).primaryColor.withOpacity(0.1),
                        child: Container(
                          color: Colors.black,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 3 * a),
            Text(
              '${gift.name}',
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: SafeGoogleFont(
                'Roboto',
                fontSize: 11 * b,
                fontWeight: FontWeight.w400,
                height: 1.1725 * b / a,
                color: const Color(0xffffffff),
              ),
            ),
            SizedBox(height: 2 * a),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/icons/ic_diamond.png',
                    height: 10 * a, width: 10 * a),
                SizedBox(width: 2 * a),
                Text(
                  '${gift.coin ?? 0}',
                  textAlign: TextAlign.center,
                  style: SafeGoogleFont(
                    'Roboto',
                    fontSize: 11 * b,
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
            widthFactor: 0.4,
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
        list.sort((a, b) => a.seat!.compareTo(b.seat!));
        return list.isNotEmpty
            ? ListView(
                shrinkWrap: true,
                children: List.generate(
                  list.length,
                  (index) => CheckboxListTile(
                    activeColor: Theme.of(context).primaryColor,
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 6),
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
                height: 90, child: Center(child: Text('None Seated')));
      },
    );
  }
}
