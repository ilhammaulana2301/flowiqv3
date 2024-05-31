import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class NotifPageDinas extends StatefulWidget {
  const NotifPageDinas({super.key});

  @override
  State<NotifPageDinas> createState() => _NotifPageDinasState();
}

class _NotifPageDinasState extends State<NotifPageDinas> {
  final List<String> items = [
    'Notifikasi 1',
    'Notifikasi 2',
    'Notifikasi 3',
    'Notifikasi 4'
  ];

  DatabaseReference ref = FirebaseDatabase.instance.ref('/dataSensor/');
  late List<double> waterFlow = [];
  late List<double> waterLevel = [];
  late List<num> dataTime = [];

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
              "Notifikasi",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: FirebaseAnimatedList(
                  shrinkWrap: true,
                  query: ref,
                  itemBuilder: ((context, snapshot, animation, index) {
                    var waterFlowValue =
                        snapshot.child('waterFlow').value as num;
                    var waterLevelValue =
                        snapshot.child('waterLevel').value as num;
                    var timeValue = waterFlow.length;
                    waterFlow.add(waterFlowValue.toDouble());
                    waterFlow.add(waterLevelValue.toDouble());
                    dataTime.add(timeValue);

                    // var nilaiJumlahFlow = waterFlow.reduce(
                    //   (value, element) => value + element,
                    // );
                    // var nilaiRataFlow = nilaiJumlahFlow / waterFlow.length;

                    if (waterFlowValue > 200 && waterLevelValue < 1500) {
                      return Center(
                          child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/grafik');
                        },
                        child: ListTile(
                          title: Text(
                            'Peringatan peningkatan volume air !',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          trailing: Icon(
                            Icons.warning,
                            color: Colors.red,
                          ),
                        ),
                      ));
                    }
                    if (waterFlowValue < 200 && waterLevelValue > 1500) {
                      return Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/grafik');
                          },
                          child: ListTile(
                            title: Text(
                              'Peringatan peningkatan ketinggian air !',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            trailing: Icon(
                              Icons.warning,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      );
                    }
                    if (waterFlowValue > 200 && waterLevelValue > 1500) {
                      return Column(
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/grafik');
                              },
                              child: ListTile(
                                title: Text(
                                  'Peringatan peningkatan volume air !',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                trailing: Icon(
                                  Icons.warning,
                                  color: Colors.red,
                                ),
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/grafik');
                              },
                              child: ListTile(
                                title: Text(
                                  'Peringatan peningkatan ketinggian air !',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                trailing: Icon(
                                  Icons.warning,
                                  color: Colors.red,
                                ),
                              ))
                        ],
                      );
                    } else {
                      return Container();
                    }
                  }))),
        ],
      ),
    );
  }
}
