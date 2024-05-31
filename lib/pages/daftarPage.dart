import 'package:flutter/material.dart';

class DaftarPageDinas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(25),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Membuat Akun Baru",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "FlowIQ v2",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[500]),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    child: TextFormField(
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.phone,
                            size: 30,
                          ),
                          labelText: "Nomor Telepon",
                          labelStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w800)),
                    ),
                  ),
                  Container(
                    child: TextFormField(
                      obscureText: true,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.lock,
                            size: 30,
                          ),
                          labelText: "Kata Sandi",
                          labelStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w800)),
                    ),
                  ),
                  Container(
                    child: TextFormField(
                      obscureText: true,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.repeat,
                            size: 30,
                          ),
                          labelText: "Ulangi Kata Sandi",
                          labelStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w800)),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                      height: 55,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/login');
                        },
                        child: Text(
                          "Daftar",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF33AAAA),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/login');
                          },
                          child: Text(
                            "Sudah ada akun? Masuk",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Colors.green),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
