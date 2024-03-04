import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:vnitproject/utils/extra.dart';
import 'package:vnitproject/config/approutes.dart';

class BleDeviceManager {
  static late StreamSubscription<BluetoothConnectionState>
      _connectionStateSubscription;
  static late StreamSubscription<int> _mtuSubscription;
  static late StreamSubscription<bool> _isConnectingSubscription;
  static late StreamSubscription<bool> _isDisconnectingSubscription;
  static BluetoothConnectionState _connectionState =
      BluetoothConnectionState.disconnected;
  static List<BluetoothService> _services = [];
  static bool _isDiscoveringServices = false;
  static bool _isConnecting = false;
  static bool _isDisconnecting = false;
  static int? _rssi;
  static int? _mtuSize;
  static List<int> value = [];

  static void initialize(BluetoothDevice device) {
    _connectionStateSubscription = device.connectionState.listen((state) async {
      _connectionState = state;
      if (state == BluetoothConnectionState.connected) {
        _services = []; // must rediscover services
      }
    });

    _mtuSubscription = device.mtu.listen((value) {
      _mtuSize = value;
    });

    _isConnectingSubscription = device.isConnecting.listen((value) {
      _isConnecting = value;
    });

    _isDisconnectingSubscription = device.isDisconnecting.listen((value) {
      _isDisconnecting = value;
    });
  }

  static void dispose() {
    _connectionStateSubscription.cancel();
    _mtuSubscription.cancel();
    _isConnectingSubscription.cancel();
    _isDisconnectingSubscription.cancel();
  }

  static Future<void> onConnectPressed(
      BluetoothDevice device, BuildContext context) async {
    try {
      await device.connectAndUpdateStream();
      Navigator.pushReplacementNamed(context, '/home');
      // Show success message
    } catch (e) {
      if (e is FlutterBluePlusException &&
          e.code == FbpErrorCode.connectionCanceled.index) {
        // Ignore connections canceled by the user
      } else {
        // Show error message
      }
    }
  }

  static Future<void> onCancelPressed(BluetoothDevice device) async {
    try {
      await device.disconnectAndUpdateStream(queue: false);
      // Show success message
    } catch (e) {
      // Show error message
    }
  }

  static Future<void> onDisconnectPressed(BluetoothDevice device) async {
    try {
      await device.disconnectAndUpdateStream();
      // Show success message
    } catch (e) {
      // Show error message
    }
  }

  static Future<void> onDiscoverServicesPressed(BluetoothDevice device) async {
    _isDiscoveringServices = true;
    try {
      _services = await device.discoverServices();
      // Show success message
    } catch (e) {
      // Show error message
    }
    _isDiscoveringServices = false;
  }

  static Future<void> onRequestMtuPressed(BluetoothDevice device) async {
    try {
      await device.requestMtu(223, predelay: 0);
      // Show success message
    } catch (e) {
      // Show error message
    }
  }

  static List<int> parseReceivedData(Uint8List dataBytes) {
    if (dataBytes.length >= 12) {
      String receivedData = String.fromCharCodes(dataBytes);
      print('Received: $receivedData');
      // Handle your received data here
      List<String> lines = receivedData.split('\n');

      if (lines.length >= 3) {
        value[0] = int.tryParse(lines[0]) ?? 0;
        value[1] = int.tryParse(lines[1]) ?? 0;
        value[2] = int.tryParse(lines[2]) ?? 0;

        print('Value 1: ${value[0]}');
        print('Value 2: ${value[1]}');
        print('Value 3: ${value[2]}');
      }
    }
    return value;
  }

  static int bytesToInt(List<int> bytes) {
    Uint8List uint8List = Uint8List.fromList(bytes);
    return uint8List.buffer.asByteData().getInt32(0, Endian.little);
  }
}
