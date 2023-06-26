import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WifiToggleScreen(),
    );
  }
}

class WifiToggleScreen extends StatefulWidget {
  const WifiToggleScreen({Key? key}) : super(key: key);

  @override
  _WifiToggleScreenState createState() => _WifiToggleScreenState();
}

class _WifiToggleScreenState extends State<WifiToggleScreen> {
  bool _wifiEnabled = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkWifiStatus();
  }

  Future<void> _checkWifiStatus() async {
    bool wifiEnabled = await WiFiForIoTPlugin.isEnabled();
    setState(() {
      _wifiEnabled = wifiEnabled;
    });
  }

  Future<void> _toggleWifi() async {
    setState(() {
      _isLoading = true;
    });

    if (_wifiEnabled) {
      await WiFiForIoTPlugin.setEnabled(false, shouldOpenSettings: false);
      // Aguarda alguns segundos para verificar novamente o status do Wi-Fi
      await Future.delayed(const Duration(seconds: 2));
    } else {
      await WiFiForIoTPlugin.setEnabled(true);
    }
    await _checkWifiStatus();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Text(
                    'Clique no ícone para ativar ou desativar o Wi-Fi',
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
                color: const Color.fromRGBO(19, 58, 104, 0),
                child: InkWell(
                  onTap: _isLoading ? null : _toggleWifi,
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox(
                          width: 200,
                          height: 200,
                          child: Icon(
                            _wifiEnabled ? Icons.wifi : Icons.wifi_off,
                            size: 200,
                            color: const Color.fromRGBO(29, 17, 99, 1),
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
