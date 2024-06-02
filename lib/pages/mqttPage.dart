import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';


class MqttPage extends StatefulWidget {
  @override
  _MqttPageState createState() => _MqttPageState();
}

class _MqttPageState extends State<MqttPage> {
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

  Future<void> _publishMessage() async {
    if (isConnected) {
      var topic = 'nops/esp32/sub';

      final Map<String, dynamic> messagePayload = {"pesan": "Pesan dari hp"};
      final String message = jsonEncode(messagePayload);
      final builder = MqttClientPayloadBuilder();
      builder.addString(message);
      client?.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
      print('Message published to $topic');
    } else {
      print('Not connected to AWS IoT');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter AWS IoT Core'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                _publishMessage();
              },
              child: Text('hidupkan Pompa'),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
