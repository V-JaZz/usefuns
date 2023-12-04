import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/rooms_provider.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../data/datasource/local/sharedpreferences/storage_service.dart';
import '../../../data/model/response/room_search_model.dart';
import '../../../data/model/response/user_search_model.dart';
import '../../../provider/user_data_provider.dart';
import '../../../utils/constants.dart';
import '../me/profile/user_profile.dart';

class SearchRoomUser extends StatefulWidget {
  const SearchRoomUser({Key? key}) : super(key: key);

  @override
  State<SearchRoomUser> createState() => _SearchRoomUserState();
}

class _SearchRoomUserState extends State<SearchRoomUser> {
  final Dio _dio = Dio();
  String myId =StorageService().getString(Constants.userId);
  final TextEditingController textEditingController = TextEditingController();
  CancelToken? currentCancelToken;
  UserSearchModel? userModel;
  RoomSearchModel? roomModel;
  bool searching = false;
  int currentTab = 0 ;

  void _performSearch() {
    setState(() {
      searching = true;
    });
    String query = textEditingController.text;
    String path = currentTab==0?'room/search':'user/search';
    currentCancelToken?.cancel();
    final CancelToken newCancelToken = CancelToken();
    currentCancelToken = newCancelToken;

    _dio.get(
      '${Constants.baseUrl}$path/$query',
      cancelToken: newCancelToken,
    ).then((response) {
      if (response.statusCode == 200) {
        if(currentTab==0){
          log(roomModel?.toJson().toString()??'');
          roomModel = RoomSearchModel.fromJson(response.data);
        }else{
          log(userModel?.toJson().toString()??'');
          userModel = UserSearchModel.fromJson(response.data);
        }
      } else {
        throw Exception('Failed to load data');
      }
      searching = false;
      setState(() {});
    }).catchError((error) {
      log(error.toString());
    }).whenComplete(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: const Color(0x339E26BC),
          automaticallyImplyLeading: true,
          centerTitle: true,
          elevation: 1,
          title: Container(
            height: 40,
            margin: EdgeInsets.only(bottom: 5 * a, right: 18 * a),
            decoration: BoxDecoration(
              color: const Color(0xffffffff),
              borderRadius: BorderRadius.circular(50 * a),
            ),
            child: TextFormField(
              controller: textEditingController,
              style: SafeGoogleFont(
                'Poppins',
                fontSize: 15 * b,
                fontWeight: FontWeight.w300,
                letterSpacing: 0.6 * a,
                color: const Color(0x99000000),
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(50 * a),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(50 * a),
                  ),
                  hintText: 'Search ${currentTab==0?'Room':'User'} ID',
                  alignLabelWithHint: false,
                  prefixIcon: Padding(
                    padding: EdgeInsets.fromLTRB(15 * a, 10 * a, 10 * a, 8 * a),
                    child: Image.asset(
                      "assets/icons/ic_search.png",
                      fit: BoxFit.contain,
                    ),
                  )),
              onChanged: (query) {
                if(query.trim() != ''){
                  _performSearch();
                }else{
                  setState(() {
                    userModel = null;
                    roomModel = null;
                  });
                }
              },
            ),
          ),
        ),
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(
                indicatorColor: Colors.black,
                indicatorWeight: 1.3,
                labelColor: const Color(0xff000000),
                dividerColor: Colors.transparent,
                unselectedLabelColor: const Color(0x99000000),
                labelStyle: SafeGoogleFont(
                  'Poppins',
                  fontSize: 16 * b,
                  fontWeight: FontWeight.w400,
                  height: 1.5 * b / a,
                  letterSpacing: 0.96 * a,
                  color: const Color(0xff000000),
                ),
                unselectedLabelStyle: SafeGoogleFont(
                  'Poppins',
                  fontSize: 16 * b,
                  fontWeight: FontWeight.w400,
                  height: 1.5 * b / a,
                  letterSpacing: 0.96 * a,
                  color: const Color(0x99000000),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30 * a),
                labelPadding: EdgeInsets.zero,
                tabs: const [
                  Tab(
                    text: "Room",
                  ),
                  Tab(
                    text: "User",
                  )
                ],
                onTap: (value) {
                  currentTab = value;
                  if(textEditingController.text!=''){
                    _performSearch();
                  }else{
                    setState(() {
                      userModel = null;
                      roomModel = null;
                    });
                  }
                },
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                    children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 18 * a, vertical: 8 * a),
                    child: searching
                        ? ListView(
                        children: List.generate(5, (index) => Card(
                      child: ListTile(
                        leading: Shimmer.fromColors(
                            baseColor: const Color.fromARGB(248, 188, 187, 187),
                            highlightColor: Colors.white,
                            period: const Duration(seconds: 1),
                            child: Image.asset('assets/logo_greystyle.png')),
                        title: Shimmer.fromColors(
                            baseColor: const Color.fromARGB(248, 188, 187, 187),
                            highlightColor: Colors.white,
                            period: const Duration(seconds: 1),
                            child: Container(color: Colors.black,child: const Text(''),)),
                        subtitle: const Text(''),
                      ),
                    )))
                        : ((roomModel?.data?.length??0)==0
                        ? Column(
                      children: [
                        Image.asset(
                          "assets/icons/ic_empty.png",
                          width: Get.width / 2,
                          height: Get.width / 2,
                        ),
                        Text(
                          'No Data',
                          style: SafeGoogleFont(
                            'Poppins',
                            fontSize: 16 * b,
                            fontWeight: FontWeight.w400,
                            height: 1.5 * b / a,
                            letterSpacing: 0.64 * a,
                            color: const Color(0xff000000),
                          ),
                        ),
                      ],
                    )
                        : ListView(
                      children: List.generate(roomModel?.data?.length??0, (index) =>
                          Card(
                        child: ListTile(
                          onTap: (){Provider.of<RoomsProvider>(context,listen: false).joinRoom(roomModel!.data![index]);},
                          leading: roomModel!.data![index].images!.isNotEmpty ? Image.network(roomModel!.data![index].images!.first):Image.asset('assets/logo_greystyle.png'),
                          title: Text(roomModel!.data![index].name!),
                          subtitle: Text((roomModel!.data![index].announcement??'') != ''?roomModel!.data![index].announcement!:'Welcome to my room!'),
                        ),
                      )),
                    )
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 18 * a, vertical: 8 * a),
                    child: searching
                        ? ListView(
                        children: List.generate(5, (index) => Card(
                          child: ListTile(
                            leading: Shimmer.fromColors(
                                baseColor: const Color.fromARGB(248, 188, 187, 187),
                                highlightColor: Colors.white,
                                period: const Duration(seconds: 1),
                                child: Image.asset('assets/logo_greystyle.png')),
                            title: Shimmer.fromColors(
                                baseColor: const Color.fromARGB(248, 188, 187, 187),
                                highlightColor: Colors.white,
                                period: const Duration(seconds: 1),
                                child: Container(color: Colors.black,child: const Text(''),)),
                            subtitle: const Text(''),
                          ),
                        )))
                        : ((userModel?.data?.length??0)==0
                        ? Column(
                      children: [
                        Image.asset(
                          "assets/icons/ic_empty.png",
                          width: Get.width / 2,
                          height: Get.width / 2,
                        ),
                        Text(
                          'No Data',
                          style: SafeGoogleFont(
                            'Poppins',
                            fontSize: 16 * b,
                            fontWeight: FontWeight.w400,
                            height: 1.5 * b / a,
                            letterSpacing: 0.64 * a,
                            color: const Color(0xff000000),
                          ),
                        ),
                      ],
                    )
                        : ListView(
                      children: List.generate(userModel?.data?.length??0, (index) =>
                          Card(
                            child: ListTile(
                              onTap: (){
                                if(userModel!.data![index].userId == myId){
                                  Get.to(()=>const UserProfile());
                                  return;
                                }
                                Provider.of<UserDataProvider>(context,listen: false).addVisitor(userModel!.data![index].id!);
                                Get.to(()=>UserProfile(userData: userModel!.data![index]));
                              },
                              leading: userModel!.data![index].images!.isNotEmpty ? Image.network(userModel!.data![index].images!.first):Image.asset('assets/logo_greystyle.png'),
                              title: Text(userModel!.data![index].name!),
                              subtitle: Text((userModel!.data![index].bio??'') != ''?userModel!.data![index].bio!:''),
                            ),
                          )),
                    )
                    ),
                  ),
                ]),
              )
            ],
          ),
        ));
  }
}
