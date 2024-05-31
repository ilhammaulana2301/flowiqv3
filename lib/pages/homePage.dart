import 'package:aplikasibaru/pages/detail.dart';
import 'package:aplikasibaru/prosesData/get_data.dart';
import 'package:flutter/material.dart';

class HomePageDinas extends StatefulWidget {
  const HomePageDinas({super.key});

  @override
  State<HomePageDinas> createState() => _HomePageDinasState();
}

class _HomePageDinasState extends State<HomePageDinas> {
  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/gaje');
                      },
                      child: Icon(Icons.menu, color: Colors.black, size: 50.0),
                    ),
                    Image.asset("assets/image/man.png", width: 50.0)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                  child: Text(
                    "Menu",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Center(
                  child: Wrap(
                    spacing: 20.0,
                    runSpacing: 20.0,
                    children: [
                      buildMenuButton(
                        context,
                        iconPath: "assets/image/location.png",
                        title: "Zona",
                        subtitle: "Peta",
                        routeName: '/zona',
                      ),
                      buildMenuButton(
                        context,
                        iconPath: "assets/image/statistics.png",
                        title: "Grafik",
                        subtitle: "Data pengamatan",
                        routeName: '/grafik',
                      ),
                      buildMenuButton(
                        context,
                        iconPath: "assets/pompe.png",
                        title: "Pompa",
                        subtitle: "Aktifkan",
                        routeName: '/cekstatus',
                      ),
                      buildMenuButton(
                        context,
                        iconPath: "assets/image/megaphone.png",
                        title: "Notifikasi",
                        subtitle: "Info",
                        routeName: '/notif',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _pencarianBuild(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Pencarian'),
  //       actions: [
  //         IconButton(
  //           icon: Icon(Icons.search),
  //           onPressed: () {
  //             // Implement search functionality
  //           },
  //         ),
  //       ],
  //     ),
  //     body: Column(
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: TextField(
  //             decoration: InputDecoration(
  //               hintText: 'Cari...',
  //               prefixIcon: Icon(Icons.search),
  //               border: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(25.0),
  //               ),
  //             ),
  //             onChanged: (value) {
  //               // Implement search filter logic
  //             },
  //           ),
  //         ),
  //         Expanded(
  //           child: ListView(
  //             children: [
  //               ListTile(
  //                 title: Text('Limpok'),
  //                 onTap: () {
  //                   Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                         builder: (context) => StatusPage(place: 'Limpok')),
  //                   );
  //                 },
  //               ),
  //               ListTile(
  //                 title: Text('Lambaro'),
  //                 onTap: () {
  //                   Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                         builder: (context) => StatusPage(place: 'Lambaro')),
  //                   );
  //                 },
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget buildMenuButton(
    BuildContext context, {
    required String iconPath,
    required String title,
    required String subtitle,
    required String routeName,
  }) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushNamed(routeName);
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: SizedBox(
        width: 160.0,
        height: 160.0,
        child: Card(
          color: Color(0xFF33AAAA),
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    iconPath,
                    width: 64.0,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
