import 'package:flutter/material.dart';

class HouseholdDataSource extends DataTableSource {
  final List<Map<String, dynamic>> data;
  final Function(int selectedIndex)? onLongPress;

  HouseholdDataSource({required this.data, this.onLongPress});

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(Text(data[index]['household_id'].toString())),
        DataCell(Text(data[index]['household_lastname'].toString())),
        DataCell(Text(data[index]['household_firstname'].toString())),
        DataCell(Text(data[index]['household_middlename'].toString())),
        DataCell(Text(data[index]['household_suffix'].toString())),
        DataCell(Text(data[index]['household_birthdate'].toString())),
        DataCell(Text(data[index]['household_age'].toString())),
        DataCell(Text(data[index]['household_sex'].toString())),
        DataCell(Text(data[index]['household_student'].toString())),
        DataCell(Text(data[index]['household_education'].toString())),
        DataCell(Text(data[index]['employment'].toString())),
        DataCell(Text(data[index]['source'].toString())),
        DataCell(Text(data[index]['pregnant'].toString())),
        DataCell(Text(data[index]['last_preg'].toString())),
        DataCell(Text(data[index]['children'].toString())),
        DataCell(Text(data[index]['household_type'].toString())),
        DataCell(Text(data[index]['household_leader'].toString())),
        DataCell(Text(data[index]['household_relation'].toString())),
        DataCell(Text(data[index]['household_association'].toString())),
        DataCell(Text(data[index]['household_remarks'].toString())),
        DataCell(Text(data[index]['household_barangay'].toString())),
        DataCell(Text(data[index]['household_school'].toString())),
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
