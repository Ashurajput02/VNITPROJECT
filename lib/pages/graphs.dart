import 'package:flutter/material.dart';
import 'package:vnitproject/chart.dart';
import 'package:vnitproject/db/database.dart';
import 'package:vnitproject/pages/connecttodevice.dart';
import 'package:vnitproject/pages/generatereport.dart';

class ChartScreen extends StatefulWidget {
  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  DatabaseHelper db = DatabaseHelper();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _name = TextEditingController();
  TextEditingController _id = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _sex = TextEditingController();
  TextEditingController _visitno = TextEditingController();
  TextEditingController _weight = TextEditingController();

  List<int> chartData1 = [];
  List<int> chartData2 = [];
  List<int> chartData3 = [];

  bool receiving = false;
  int area = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(219, 227, 9, 0.992),
        title: Text('Chart Screen'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 80),
              Divider(
                height: 40,
                thickness: 2,
                color: Colors.black,
              ),
              Visibility(
                visible: true,
                child: Column(
                  children: [
                    Chart(
                      chartData: chartData1,
                    ),
                    Chart(
                      chartData: chartData2,
                    ),
                    Chart(
                      chartData: chartData3,
                    ),
                  ],
                ),
              ),
              Divider(
                height: 40,
                thickness: 2,
                color: Colors.black,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 320,
                height: 76,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size.fromHeight(60.0),
                    shape: const StadiumBorder(),
                    backgroundColor: Colors.red,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: const Text('STOP'),
                  ),
                  onPressed: () async {
                    print("Stop Button Pressed");

                    Navigator.of(context)
                        .pushReplacementNamed('/generatereport');
                    Bluetooth.stopBluetooth();
                    setState(() {
                      receiving = false;
                      chartData1.clear();
                      chartData2.clear();
                      chartData3.clear();
                      Bluetooth.receivedDataList.clear();
                      Bluetooth.receivedDataList.add(0);
                    });

                    if (_formKey.currentState?.validate() ?? false) {
                      await DatabaseHelper().insertUserData(
                        value1: chartData1[chartData1.length - 1],
                        value2: chartData2[chartData1.length - 1],
                        value3: chartData3[chartData1.length - 1],
                      );

                      Bluetooth.stopBluetooth();
                      print("Data saved successfully");
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void startListeningAndUpdateChart() {
    Future<void> updateChart() async {
      while (receiving) {
        int parsedData = Bluetooth.receivedDataList
            .elementAt(Bluetooth.receivedDataList.length - 1);
        area = Bluetooth.area;

        setState(() {
          chartData1.add(parsedData);
          chartData2.add(parsedData); // Update this data as needed
          chartData3.add(parsedData); // Update this data as needed
          print("Chart data updated: $chartData1");
          print('area: $area');
        });
        await Future.delayed(Duration(milliseconds: 1000));
      }
    }

    updateChart();
  }
}
