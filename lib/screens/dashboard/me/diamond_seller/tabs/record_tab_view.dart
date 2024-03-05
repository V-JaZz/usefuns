import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/seller_agency_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../data/model/response/seller_record_model.dart';

class SellerRecordTabView extends StatefulWidget {
  const SellerRecordTabView({super.key});

  @override
  State<SellerRecordTabView> createState() => _SellerRecordTabViewState();
}

class _SellerRecordTabViewState extends State<SellerRecordTabView> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    return FutureBuilder(
      future: Provider.of<SellerAgencyProvider>(context).getSellerRecord(),
      builder:
          (BuildContext context, AsyncSnapshot<SellerRecordModel> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Text('none...');
          case ConnectionState.active:
            return const Text('active...');
          case ConnectionState.waiting:
            return const Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 18),
                Text('Loading'),
              ],
            ));
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if ((snapshot.data?.data?.length ?? 0) == 0) {
              return const Center(child: Text('No Recent Rooms!'));
            } else {
              return ListView.separated(
                itemCount: snapshot.data?.data?.length??0,
                separatorBuilder: (context, index) => const Divider(color: Colors.black12),
                itemBuilder: (context, i) {
                  int index = snapshot.data!.data!.length-i-1;
                  final report = snapshot.data!.data![index];
                  return ListTile(
                    title: Text('User ID: ${report.userId}'),
                    subtitle: Text('Date Time : ${report.createdAt}'),
                    trailing: Text(
                      '- ₹${report.amount}',
                      style: TextStyle(
                        fontSize: 16*a,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor
                      ),
                    ),
                  );
                });
            }
        }
      },
    );
  }
}
