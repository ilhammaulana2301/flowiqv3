import 'package:flutter/material.dart';

class TambahSensorPageDinas extends StatefulWidget {
  const TambahSensorPageDinas({super.key});

  @override
  State<TambahSensorPageDinas> createState() => _SensorPageDinasState();
}

class _SensorPageDinasState extends State<TambahSensorPageDinas> {
  bool _isDialogVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF33AAAA),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(left: 10.0)),
            Text(
              "Aktifkan pompe",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(top: 10.0)),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        hintText: "id sensor",
                        fillColor: Colors.white,
                        filled: true,
                        labelText: "id sensor",
                        labelStyle: TextStyle(fontWeight: FontWeight.w500),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20.0)),
                  TextField(
                    decoration: InputDecoration(
                        hintText: "lokasi",
                        fillColor: Colors.white,
                        filled: true,
                        labelText: "lokasi sensor",
                        prefixIcon: Icon(
                          Icons.location_pin,
                          size: 30,
                        ),
                        labelStyle: TextStyle(fontWeight: FontWeight.w500),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                  ),
                  Padding(padding: EdgeInsets.only(top: 50)),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isDialogVisible = true;
                        });
                      },
                      child: Text("Tambah Sensor"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF33AAAA),
                          fixedSize: Size(300, 50),
                          textStyle: TextStyle(fontSize: 18),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)))),
                  if (_isDialogVisible)
                    AlertDialog(
                      title: Text('konfirmasi'),
                      content: Text('Apakah Anda yakin ingin melanjutkan?'),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () {
                              setState(() {
                                _isDialogVisible = false;
                              });
                            },
                            child: Text('Batal')),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed('/cekstatus');
                          },
                          child: Text('Ok'),
                        )
                      ],
                    )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildBottomNavigation() {
    return new BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
            activeIcon: new Icon(
              Icons.home,
              color: Color(0xFF33AAAA),
            ),
            icon: new Icon(
              Icons.home,
              color: Color(0xFF33AAAA),
            ),
            label: "Beranda"),
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.assignment,
            color: Color(0xFF33AAAA),
          ),
          icon: new Icon(
            Icons.assignment,
            color: Color(0xFF33AAAA),
          ),
          label: "Grafik",
        ),
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.mail,
            color: Color(0xFF33AAAA),
          ),
          icon: new Icon(
            Icons.mail,
            color: Color(0xFF33AAAA),
          ),
          label: "Info",
        )
      ],
    );
  }
}
