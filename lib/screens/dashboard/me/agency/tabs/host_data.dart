import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/rooms_provider.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../data/model/response/agency_host_model.dart';
import '../../../../../provider/seller_agency_provider.dart';

class HostDataTabView extends StatefulWidget {
  const HostDataTabView({super.key});

  @override
  State<HostDataTabView> createState() => _HostDataTabViewState();
}

class _HostDataTabViewState extends State<HostDataTabView> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;

    return Scaffold(
      body: Consumer<SellerAgencyProvider>(
        builder: (context, value, _) => SingleChildScrollView(
          child: Column(children: [
            // SizedBox(
            //   height: 30 * b,
            // ),
            // Container(
            //   width: 158 * a,
            //   height: 30 * a,
            //   color: const Color(0xffFF0000),
            //   child: const Center(
            //       child: Text(
            //     'Monthly data',
            //     style: TextStyle(color: Colors.white),
            //   )),
            // ),
            SizedBox(
              height: 30 * a,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Agency: ${value.agent?.data?.name}'),
                  SizedBox(
                    width: 30 * a,
                  ),
                  Text('Agency Code: ${value.agent?.data?.code}'),
                ],
              ),
            ),
            SizedBox(
              height: 20 * a,
            ),
            const Text(
              'Monthly Data',
              style: TextStyle(color: Colors.black),
            ),
            const HostDataTable(),
          ]),
        ),
      ),
    );
  }
}

class HostDataTable extends StatefulWidget {
  const HostDataTable({
    super.key,
  });

  @override
  State<HostDataTable> createState() => _HostDataTableState();
}

class _HostDataTableState extends State<HostDataTable> {
  @override
  void initState() {
    Provider.of<SellerAgencyProvider>(context,listen: false).getHostList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<SellerAgencyProvider>(
      builder: (context, value, _) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.deepOrange),
              borderRadius: BorderRadius.circular(4)),
          child: Column(
            children: [
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(1.5),
                },
                border: TableBorder.all(color: Colors.black12),
                children: [
                  TableRow(
                    children: [
                      Container(
                        height: 42,
                        decoration: const BoxDecoration(color: Colors.deepOrange),
                        alignment: Alignment.center,
                        child: const Text(
                          "Usefuns ID",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12.0, color: Colors.white),
                        ),
                      ),
                      Container(
                        height: 42,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(color: Colors.deepOrange),
                        child: const Text(
                          "Status",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12.0, color: Colors.white),
                        ),
                      ),
                      Container(
                        height: 42,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(color: Colors.deepOrange),
                        child: const Text(
                          "Room Gifts\n(15.12.23)",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12.0, color: Colors.white),
                        ),
                      ),
                      Container(
                        height: 42,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(color: Colors.deepOrange),
                        child: const Text(
                          "Valid Days\n(31.12.23)",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12.0, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  if(value.isHostListLoaded)
                    for(HostData host in value.hostList?.data??[])
                      tableRow('${host.userId}','${host.status}')
                ],
              ),
              if(!value.isHostListLoaded) const LinearProgressIndicator(color: Colors.black12)
            ],
          ),
        ),
      ),
    );
  }

  TableRow tableRow(String id, String status) {
    return TableRow(children: [
      Text(
        id,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15.0),
      ),
      Text(
        status,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 14.0),
      ),
      FutureBuilder(
        future: Provider.of<RoomsProvider>(context,listen: false).getRoomByRoomId(id),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const SizedBox(
              height: 21,
              child: LinearProgressIndicator(
                color: Colors.deepOrangeAccent
              ),
            );
          }else{
            return Text(
              '${snapshot.data?.totalDiamonds}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14.0),
            );
          }
        },
      ),
      const Text(
        "0",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14.0),
      ),
    ]);
  }
}
