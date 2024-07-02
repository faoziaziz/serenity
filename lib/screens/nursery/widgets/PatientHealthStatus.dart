import 'package:flutter/material.dart';


class PatientHealtStatus extends StatefulWidget {
  const PatientHealtStatus({super.key});

  @override
  State<PatientHealtStatus> createState() => _PatientHealtStatusState();
}

class _PatientHealtStatusState extends State<PatientHealtStatus> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("Patient Health"),
          Text("Memberl"),
          Table(
            border: TableBorder.all(),
            children: <TableRow>[
              TableRow(
                children: <Widget>[
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.top,
                    child: Container(
                      height: 32,
                      width: 32,
                      color: Colors.amberAccent,
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.top,
                    child: Container(
                      height: 32,
                      width: 32,
                      color: Colors.amberAccent,
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.top,
                    child: Container(
                      height: 32,
                      width: 32,
                      color: Colors.amberAccent,
                    ),
                  ),

                ]
              ),
              TableRow(
                  children: <Widget>[
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.top,
                      child: Container(
                        height: 32,
                        width: 32,
                        color: Colors.amberAccent,
                        child: Text("sa"),
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.top,
                      child: Container(
                        height: 32,
                        width: 32,
                        color: Colors.amberAccent,
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.top,
                      child: Container(
                        height: 32,
                        width: 32,
                        color: Colors.amberAccent,
                      ),
                    ),
                  ]
              ),

            ],
          ),
        ],
      ),
    );
  }
}
