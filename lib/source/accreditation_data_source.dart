import 'package:flutter/material.dart';

class AccreditationDataSource extends DataTableSource {
  final List<Map<String, dynamic>> data;
  final Function(int selectedIndex)? onLongPress;

  AccreditationDataSource({required this.data, this.onLongPress}) : super();

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(Text(data[index]['accreditation_id'].toString())),
        DataCell(Text(data[index]['accreditation_name'].toString())),
        DataCell(Text(data[index]['accreditation_barangay'].toString())),
        DataCell(Text(data[index]['BarangayID'].toString())),
        DataCell(Text(data[index]['accreditation_address'].toString())),
        DataCell(Text(data[index]['accreditation_contactperson'].toString())),
        DataCell(Text(data[index]['accreditation_phone'].toString())),
        DataCell(Text(data[index]['accreditation_number'].toString())),
        DataCell(Text(data[index]['accreditation_issued'].toString())),
        DataCell(Text(data[index]['accreditation_expired'].toString())),
        DataCell(Text(data[index]['accreditation_president'].toString())),
        DataCell(Text(data[index]['accreditation_type'].toString())),
        DataCell(Text(data[index]['accreditation_ddress'].toString())),
        DataCell(Text(data[index]['accreditation_members'].toString())),
        DataCell(Text(data[index]['accreditation_population'].toString())),
        DataCell(Text(data[index]['accreditation_belowm'].toString())),
        DataCell(Text(data[index]['accreditation_belowf'].toString())),
        DataCell(Text(data[index]['accreditation_belowo'].toString())),
        DataCell(Text(data[index]['accreditation_abovem'].toString())),
        DataCell(Text(data[index]['accreditation_abovef'].toString())),
        DataCell(Text(data[index]['accreditation_aboveo'].toString())),
        DataCell(Text(data[index]['accreditation_area'].toString())),
        DataCell(Text(data[index]['accreditation_class'].toString())),
        DataCell(Text(data[index]['accreditation_programs'].toString())),
        DataCell(Text(data[index]['accreditation_problems'].toString())),
        DataCell(Text(data[index]['accreditation_coordinator'].toString())),
        DataCell(Text(data[index]['accreditation_created'].toString())),
        DataCell(Text(data[index]['accreditation_remarks'].toString())),
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
