import 'package:flutter/material.dart';

class CrimeDataSource extends DataTableSource {
  final List<Map<String, dynamic>> data;
  final Function(int index)? onLongPress;

  CrimeDataSource({required this.data, this.onLongPress});

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(Text(data[index]['crime_id'].toString())),
        DataCell(Text(data[index]['crime_violation'].toString())),
        DataCell(Text(data[index]['crime_date'].toString())),
        DataCell(Text(data[index]['crime_victim'].toString())),
        DataCell(Text(data[index]['crime_perpetrator'].toString())),
        DataCell(Text(data[index]['crime_barangay'].toString())),
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
