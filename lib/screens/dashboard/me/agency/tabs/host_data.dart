import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/rooms_provider.dart';
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

    return Scaffold(
      body: Consumer<SellerAgencyProvider>(
        builder: (context, value, _) => SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 30 * a,
            ),
            Text('Agency :  ${value.agent?.data?.name}'),
            SizedBox(
              height: 5 * a,
            ),
            Text('Agency Code :  ${value.agent?.data?.code}'),
            SizedBox(
              height: 20 * a,
            ),
            const Text(
              'Active Season Data',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: 10 * a,
            ),
            const HostDataTable(active: true),
            SizedBox(
              height: 20 * a,
            ),
            const Text(
              'Last Season Data',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: 10 * a,
            ),
            const HostDataTable(active: false),
          ]),
        ),
      ),
    );
  }
}

class HostDataTable extends StatefulWidget {
  final bool active;
  const HostDataTable({
    super.key, required this.active,
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: widget.active?Colors.deepOrange:Colors.grey),
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
                        decoration: BoxDecoration(color: widget.active?Colors.deepOrange:Colors.grey),
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
                        decoration: BoxDecoration(color: widget.active?Colors.deepOrange:Colors.grey),
                        child: const Text(
                          "Status",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12.0, color: Colors.white),
                        ),
                      ),
                      Container(
                        height: 42,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: widget.active?Colors.deepOrange:Colors.grey),
                        child: const Text(
                          "Room Gifts",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12.0, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  if(value.isHostListLoaded)
                    for(HostData host in value.hostList?.data??[])
                      tableRow('${host.userId}','${host.status}',widget.active)
                ],
              ),
              if(!value.isHostListLoaded) const LinearProgressIndicator(color: Colors.black12)
            ],
          ),
        ),
      ),
    );
  }

  TableRow tableRow(String id, String status, bool active) {
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
            return SizedBox(
              height: 21,
              child: LinearProgressIndicator(
                  color: active?Colors.deepOrange:Colors.grey
              ),
            );
          }else{
            return Text(
              '${active?snapshot.data?.halfMonthlyDiamonds:snapshot.data?.monthlyDiamonds}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14.0),
            );
          }
        },
      ),
    ]);
  }
}
