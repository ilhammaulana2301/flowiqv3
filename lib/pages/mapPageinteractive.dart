import 'package:flutter/material.dart';

// H82M+CPF, Lamseupeung, Lueng Bata, Banda Aceh City, Aceh 23127, Indonesia

class MapInteractive extends StatefulWidget {
  const MapInteractive({super.key});

  @override
  State<MapInteractive> createState() => _MapInteractiveState();
}

class _MapInteractiveState extends State<MapInteractive> {
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
              "Zona Wilayah Banda Aceh",
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
          'assets/image/interactivemap2.png',
          fit: BoxFit.contain, // Mengisi layar
        ),
      ),
    );
  }
}
