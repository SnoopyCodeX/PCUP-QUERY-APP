import 'package:flutter/material.dart';

class LeadersAndMembersDataSource extends DataTableSource {
  final List<Map<String, dynamic>> data;
  final Function(int selectedIndex)? onLongPress;

  LeadersAndMembersDataSource({required this.data, this.onLongPress});

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(Text(data[index]['leader_id'].toString())),
        DataCell(Text(data[index]['leader_name'].toString())),
        DataCell(Text(data[index]['leader_lname'].toString())),
        DataCell(Text(data[index]['leader_mname'].toString())),
        DataCell(Text(data[index]['leader_position'].toString())),
        DataCell(Text(data[index]['leader_sex'].toString())),
        DataCell(Text(data[index]['leader_age'].toString())),
        DataCell(Text(data[index]['leader_barangay'].toString())),
        DataCell(Text(data[index]['leader_civilstatus'].toString())),
        DataCell(Text(data[index]['leader_num_family_members'].toString())),
        DataCell(Text(data[index]['leader_total_male'].toString())),
        DataCell(Text(data[index]['leader_total_female'].toString())),
        DataCell(Text(data[index]['leader_totalpwd_physical_male'].toString())),
        DataCell(Text(data[index]['leader_totalpwd_physical_female'].toString())),
        DataCell(Text(data[index]['leader_senior_male'].toString())),
        DataCell(Text(data[index]['leader_senior_female'].toString())),
        DataCell(Text(data[index]['leader_below_18_male'].toString())),
        DataCell(Text(data[index]['leader_below_18_female'].toString())),
        DataCell(Text(data[index]['leader_program'].toString())),
        DataCell(Text(data[index]['leader_remarks'].toString())),
        DataCell(Text(data[index]['leader_association'].toString())),
      ],
      onLongPress: () => onLongPress!(index),
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
