import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert'; // Perlu untuk jsonEncode

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF33AAAA),
          iconTheme: IconThemeData(color: Colors.white),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: DetailStatus(),
      ),
    );
  }
}

class DetailStatus extends StatefulWidget {
  @override
  _DetailStatusState createState() => _DetailStatusState();
}

class _DetailStatusState extends State<DetailStatus> {
  final String _awsRegion = 'ap-southeast-2'; // Ubah ke region AWS Anda
  final String _iotEndpoint =
      'a2myxdlmwu3fx-ats.iot.ap-southeast-2.amazonaws.com'; // Ubah ke endpoint AWS IoT Anda
  final String _clientId = 'app-flows'; // Ubah ke client ID Anda

  MqttServerClient? client;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    _connectToAwsIot();
  }

  Future<void> _connectToAwsIot() async {
    client = MqttServerClient.withPort(_iotEndpoint, _clientId, 8883);
    client?.logging(on: true);

    // Set security context
    final context = SecurityContext.defaultContext;
    final ByteData certificateData = await rootBundle.load(
        'assets/certs/eae88779545ec2044558813b1304b86d69916e6845b9bfe2e6cf92adf8f7450f-certificate.pem.crt');
    final ByteData privateKeyData = await rootBundle.load(
        'assets/certs/eae88779545ec2044558813b1304b86d69916e6845b9bfe2e6cf92adf8f7450f-private.pem.key');
    final ByteData rootCaData =
        await rootBundle.load('assets/certs/AmazonRootCA1.pem');

    context.useCertificateChainBytes(certificateData.buffer.asUint8List());
    context.usePrivateKeyBytes(privateKeyData.buffer.asUint8List());
    context.setTrustedCertificatesBytes(rootCaData.buffer.asUint8List());

    client?.secure = true;
    client?.securityContext = context;

    client?.onConnected = onConnected;
    client?.onDisconnected = onDisconnected;
    client?.onSubscribed = onSubscribed;
    client?.onSubscribeFail = onSubscribeFail;
    client?.pongCallback = pong;

    final connMess = MqttConnectMessage()
        .withClientIdentifier(_clientId)
        .withProtocolVersion(4)
        .startClean()
        .keepAliveFor(20)
        .withWillTopic('willtopic')
        .withWillMessage('Will message')
        .withWillQos(MqttQos.atMostOnce);

    print('Connecting to AWS IoT...');
    try {
      await client?.connect();
    } catch (e) {
      print('Exception: $e');
      client?.disconnect();
    }
  }

  void onConnected() {
    setState(() {
      isConnected = true;
    });
    print('Connected to AWS IoT');
    client?.subscribe('nops/esp32/pub', MqttQos.atMostOnce);
  }

  void onDisconnected() {
    setState(() {
      isConnected = false;
    });
    print('Disconnected from AWS IoT');
  }

  void onSubscribed(String topic) {
    print('Subscribed to $topic');
  }

  void onSubscribeFail(String topic) {
    print('Failed to subscribe $topic');
  }

  void onUnsubscribed(String topic) {
    print('Unsubscribed from $topic');
  }

  void pong() {
    print('Ping response client callback invoked');
  }

  void onMessage(List<MqttReceivedMessage<MqttMessage>> event) {
    final MqttPublishMessage recMess = event[0].payload as MqttPublishMessage;
    final String message =
        MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

    print('Received message: $message from topic: ${event[0].topic}>');
  }

  Future<void> _publishMessage(pesan) async {
    if (isConnected) {
      if (pesan == "aktifkan") {
        var topic = 'nops/esp32/sub';

        final Map<String, dynamic> messagePayload = {"pesan": "1"};
        final String message = jsonEncode(messagePayload);
        final builder = MqttClientPayloadBuilder();
        builder.addString(message);
        client?.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
        print('Message published to $topic');
      } else if (pesan == "matikan") {
        var topic = 'nops/esp32/sub';

        final Map<String, dynamic> messagePayload = {"pesan": "0"};
        final String message = jsonEncode(messagePayload);
        final builder = MqttClientPayloadBuilder();
        builder.addString(message);
        client?.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
        print('Message published to $topic');
      }
    } else {
      print('Not connected to AWS IoT');
    }
  }

  bool isPumpActive = false;

  void activatePump() {
    _publishMessage("aktifkan");
    setState(() {
      isPumpActive = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Pompa berhasil diaktifkan'),
      ),
    );
  }

  void showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            title: Text(
              'Konfirmasi',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            content: Text(
              'Apakah ingin mengaktifkan pompa?',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Batal',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: Text(
                  'Ya',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF33AAAA),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  activatePump();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void deactivatePump() {
    _publishMessage("matikan");

    setState(() {
      isPumpActive = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Pompa berhasil dimatikan'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF33AAAA),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Halaman Status",
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),

      // appBar: AppBar(
      //   backgroundColor: Color(0xFF33AAAA),
      //   iconTheme: IconThemeData(color: Colors.white),
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      // ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Icon(
                              Icons.info,
                              color: Colors.blue,
                              size: 30,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Status Pompa',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: <Widget>[
                            Icon(
                              isPumpActive ? Icons.check_circle : Icons.cancel,
                              color: isPumpActive ? Colors.green : Colors.red,
                              size: 30,
                            ),
                            SizedBox(width: 10),
                            Text(
                              isPumpActive ? "AKTIF" : "NON-AKTIF",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isPumpActive ? Colors.green : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (!isPumpActive) {
                      showConfirmationDialog();
                    } else {
                      deactivatePump();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isPumpActive ? Colors.red : Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    textStyle: TextStyle(fontSize: 20),
                  ),
                  child: Text(
                    isPumpActive ? 'Matikan Pompa' : 'Aktifkan Pompa',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
