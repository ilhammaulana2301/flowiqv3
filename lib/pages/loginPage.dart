// ignore: file_names
// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';

class LoginPageDinasUpdate extends StatefulWidget {
  const LoginPageDinasUpdate({super.key});

  @override
  State<LoginPageDinasUpdate> createState() => _LoginPageDinasUpdateState();
}

class _LoginPageDinasUpdateState extends State<LoginPageDinasUpdate> {
  // final _formKey = GlobalKey<FormState>();
  final noHP = TextEditingController();
  final password = TextEditingController();
  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(25),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Hai,",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF33AAAA)),
                      )
                    ],
                  ),
                  Row(
                    children: [Text("Selamat datang")],
                  ),
                  Row(
                    children: [Text("Kami adalah solusi")],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Image.asset(
                    "assets/image/person_login.png",
                    width: 200,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: noHP,
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
                            labelText: "Nomor HP",
                            labelStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[400],
                                fontWeight: FontWeight.w800)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            print('kosong');
                          }
                          bool noHpValid =
                              RegExp(r"^08\d{9,}$").hasMatch(value);
                          if (!noHpValid) {
                            return "Enter noHp valid";
                          }
                        }),
                  ),
                  Container(
                    child: TextFormField(
                      obscureText: passToggle,
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
                              fontWeight: FontWeight.w800),
                          suffix: InkWell(
                            onTap: () {
                              setState(() {
                                passToggle = !passToggle;
                              });
                            },
                            child: Icon(passToggle
                                ? Icons.visibility
                                : Icons.visibility_off),
                          )),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Lupa Kata Sandi?",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Colors.green),
                          ))
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                      height: 55,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/home');
                        },
                        child: Text(
                          "Masuk",
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
                            Navigator.of(context).pushNamed('/');
                          },
                          child: Text(
                            "Belum punya akun? Daftar",
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
