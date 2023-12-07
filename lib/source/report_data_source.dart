import 'package:flutter/material.dart';

class ReportDataSource extends DataTableSource {
  final List<Map<String, dynamic>> data;
  final Function(int selectedIndex)? onLongPress;

  ReportDataSource({required this.data, this.onLongPress});

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(Text(data[index]['report_id'].toString())),
        DataCell(Text(data[index]['report_name'].toString())),
        DataCell(Text(data[index]['report_facilitator'].toString())),
        DataCell(Text(data[index]['report_date'].toString())),
        DataCell(Text(data[index]['report_objective'].toString())),
        DataCell(Text(data[index]['report_barangay'].toString())),
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
