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

  static void parseReceivedData(Uint8List dataBytes) {
    if (dataBytes.length >= 12) {
      int firstInteger = bytesToInt(dataBytes.sublist(0, 4));
      int secondInteger = bytesToInt(dataBytes.sublist(4, 8));
      int thirdInteger = bytesToInt(dataBytes.sublist(8, 12));
      print('First Integer: $firstInteger');
      print('Second Integer: $secondInteger');
      print('Third Integer: $thirdInteger');
    } else {
      print('Incomplete data received');
    }
  }

  static int bytesToInt(List<int> bytes) {
    Uint8List uint8List = Uint8List.fromList(bytes);
    return uint8List.buffer.asByteData().getInt32(0, Endian.little);
  }
}
