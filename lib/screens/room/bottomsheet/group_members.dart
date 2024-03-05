import 'package:flutter/material.dart';
import '../../../data/model/response/user_data_model.dart';

class GroupMembersBottomSheet extends StatefulWidget {
  final List<UserData>? members;
  final String owner;
  const GroupMembersBottomSheet({Key? key, required this.members, required this.owner}) : super(key: key);

  @override
  State<GroupMembersBottomSheet> createState() => _GroupMembersBottomSheetState();
}

class _GroupMembersBottomSheetState extends State<GroupMembersBottomSheet> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white
    );
  }
}
