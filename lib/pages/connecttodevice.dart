// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vnitproject/pages/homepage.dart';

class Bluetooth {
  static late BluetoothConnection? connection;
  static bool isConnected = false;
  static String deviceAddress = "C8:F0:9E:48:C4:F6";
  static List<int> receivedDataList = [];
  static int area = 0;
  static List<int> value= [];

  static Future<void> connectToDevice(String address) async {
    try {
      Bluetooth.connection = await BluetoothConnection.toAddress(address);
      isConnected = true;
      print('Connected to Arduino');

      // connection!.input!.listen((Uint8List data) {
      //   // Handle received data as needed
      //   String receivedData = String.fromCharCodes(data);
      //   int parsedData = data.first;
      //   area += parsedData;
      //   print('Received Data packet: ${data.join(', ')}');

      //   // receivedDataList.add(int.tryParse(receivedData)?? 0);
      //   receivedDataList.add(parsedData);
      //   print('Received Data: $receivedData');

      //   Future.delayed(Duration(milliseconds: 100), () {
      //     print('receivedDataList Length: ${receivedDataList.length}');
      //     print('receivedDataList Contents: $receivedDataList');
      //   });
      // }, onDone: () {
      //   isConnected = false;
      // });
    } catch (exception, stackTrace) {
      print('Cannot connect, exception occurred: $exception');
      print('StackTrace: $stackTrace');
    }
  }

  void sendData(String data) async {
    data = data.trim();
    if (isConnected) {
      try {
        List<int> list = data.codeUnits;
        Uint8List bytes = Uint8List.fromList(list);
        connection!.output.add(bytes);
        await connection!.output.allSent;
        if (kDebugMode) {
          print('Data sent successfully');
        }
      } catch (e) {
        print('Error sending data: $e');
      }
    } else {
      print('BlConnection not yet initialized');
    }
  }

  static List<int> startListening() {
    String receivedData = '';
    connection!.input!.listen(
      (Uint8List data) {
        receivedData = String.fromCharCodes(data);
        print('Received: $receivedData');
        // Handle your received data here
        List<String> lines = receivedData.split('\n');

        if (lines.length >= 3) {
          value[0] = int.tryParse(lines[0]) ?? 0;
          value[1] = int.tryParse(lines[1]) ?? 0;
          value[2] = int.tryParse(lines[2]) ?? 0;

          print('Value 1: $value[0]');
          print('Value 2: $value[1]');
          print('Value 3: $value[2]');
        }
      },

      // Handle Bluetooth connection closed event
      onDone: () {
        print('Connection closed');
        connection = null;
      },
    );
    return value;
  }

  static void stopBluetooth() {
    if (connection != null) {
      connection!.dispose();
      connection = null;
      print('Bluetooth Blconnection stopped');
    }
  }
}

// ========== WIDGET ========== //

class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({Key? key}) : super(key: key);

  @override
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  Future<void> requestPermissions() async {
    await requestLocationPermission();
    await requestBluetoothPermission();
    await requestBluetoothScanPermission();
    await requestConnectPermission();
  }

  Future<void> requestLocationPermission() async {
    // Request location permission
    var status = await Permission.location.request();

    if (status.isGranted) {
      // Permission granted, you can proceed with location-related tasks
      print("Location permission granted");
    } else if (status.isDenied) {
      // Permission denied, handle accordingly
      print("Location permission denied");
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied, navigate to app settings
      openAppSettings();
    }
  }

  Future<void> requestConnectPermission() async {
    // Request location permission
    var status = await Permission.bluetoothConnect.request();

    if (status.isGranted) {
      // Permission granted, you can proceed with location-related tasks
      print("Location permission granted");
    } else if (status.isDenied) {
      // Permission denied, handle accordingly
      print("Location permission denied");
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied, navigate to app settings
      openAppSettings();
    }
  }

  Future<void> requestBluetoothPermission() async {
    var status = await Permission.bluetooth.request();

    if (status.isGranted) {
      // Permission granted, you can proceed with Bluetooth-related tasks
      print("Bluetooth permission granted");
    } else if (status.isDenied) {
      // Permission denied, handle accordingly
      print("Bluetooth permission denied");
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied, navigate to app settings
      openAppSettings();
    }
  }

  Future<void> requestBluetoothScanPermission() async {
    var status = await Permission.bluetoothScan.request();

    if (status.isGranted) {
      // Permission granted, you can proceed with Bluetooth-related tasks
      print("Bluetooth permission granted");
    } else if (status.isDenied) {
      // Permission denied, handle accordingly
      print("Bluetooth permission denied");
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied, navigate to app settings
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: Text("Connect to Device"),
            onPressed: () async {
              print('Connect Button pressed');
              await Bluetooth.connectToDevice(Bluetooth.deviceAddress);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Homepage();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    Bluetooth.connection!.close();
    super.dispose();
  }
}
