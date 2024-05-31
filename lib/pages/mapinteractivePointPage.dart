import 'package:flutter/material.dart';

// H82M+CPF, Lamseupeung, Lueng Bata, Banda Aceh City, Aceh 23127, Indonesia

class MapInteractivePoint extends StatefulWidget {
  const MapInteractivePoint({super.key});

  @override
  State<MapInteractivePoint> createState() => _MapInteractivePointState();
}

class _MapInteractivePointState extends State<MapInteractivePoint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF33AAAA),
        iconTheme: IconThemeData(color: Colors.white),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(left: 10.0)),
            Text(
              "Zona wilayah Banda Aceh",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      body: InteractiveViewer(
        scaleEnabled: true,
        panEnabled: true,
        constrained: false,
        minScale: 0.5,
        maxScale: 2.0,
        child: Image.asset(
          'assets/image/interactifmap1.png',
          fit: BoxFit.contain, // Mengisi layar
        ),
      ),
    );
  }
}
