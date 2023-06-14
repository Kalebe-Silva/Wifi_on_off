import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WifiToggleScreen(),
    );
  }
}

class WifiToggleScreen extends StatefulWidget {
  const WifiToggleScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WifiToggleScreenState createState() => _WifiToggleScreenState();
}

class _WifiToggleScreenState extends State<WifiToggleScreen> {
  bool _wifiEnabled = false;

  @override
  void initState() {
    super.initState();
    _checkWifiStatus();
  }

  void _checkWifiStatus() async {
    bool wifiEnabled = await WiFiForIoTPlugin.isEnabled();
    setState(() {
      _wifiEnabled = wifiEnabled;
    });
  }

  void _toggleWifi() async {
    if (_wifiEnabled) {
      await WiFiForIoTPlugin.setEnabled(false);
    } else {
      await WiFiForIoTPlugin.setEnabled(true);
    }
    _checkWifiStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Text(
                    'Clique no ícone para ativar ou desativar o Wifi',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(29, 17, 99, 1),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(child: Container()),
                Image.asset(
                  'assets/logo_tecadilabs.png',
                  width: 200,
                  height: 200,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 300,
            child: ClipOval(
              child: Material(
                color: Color.fromRGBO(19, 58, 104, 0),
                child: InkWell(
                  onTap: _toggleWifi,
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: Icon(
                      _wifiEnabled ? Icons.wifi : Icons.wifi_off,
                      size: 200,
                      color: Color.fromRGBO(29, 17, 99, 1),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
