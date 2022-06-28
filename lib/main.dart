// @dart=2.9

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MaterialApp(
      title: "Weather App",
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var temp;
  var deskripsi;
  var sekarang;
  var kelembapan;
  var kecepatanAngin;

  Future getWeather() async {
    http.Response response = await http.get(
        "http://api.openweathermap.org/data/2.5/weather?q=Palopo&units=metric&lang=id&appid=bff16968b01ed1bf9097370a9f564f4d");
    var result = jsonDecode(response.body);
    setState(() {
      this.temp = result['main']['temp'];
      this.deskripsi = result['weather'][0]['description'];
      this.sekarang = result['weather'][0]['main'];
      this.kelembapan = result['main']['humidity'];
      this.kecepatanAngin = result['wind']['speed'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          color: Colors.pink,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text("Wilayah Makassar",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600)),
              ),
              Text(temp != null ? temp.toString() + "\u00B0" : "Tunggu...",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w600)),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  sekarang != null ? sekarang.toString() : "Tunggu...",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              ListTile(
                  leading: const FaIcon(FontAwesomeIcons.thermometerHalf),
                  title: const Text("Temperatur"),
                  trailing: Text(
                      temp != null ? temp.toString() + "\u00B0" : "Tunggu...")),
              ListTile(
                  leading: const FaIcon(FontAwesomeIcons.cloud),
                  title: const Text("Weather"),
                  trailing: Text(
                      sekarang != null ? sekarang.toString() : "Tunggu...")),
              ListTile(
                  leading: FaIcon(FontAwesomeIcons.sun),
                  title: const Text("Kelembapan"),
                  trailing: Text(kelembapan != null
                      ? kelembapan.toString() + "\u00B0"
                      : "Tunggu...")),
              ListTile(
                  leading: FaIcon(FontAwesomeIcons.wind),
                  title: const Text("Kecepatan Angin"),
                  trailing: Text(kecepatanAngin != null
                      ? kecepatanAngin.toString() + "\u00B0"
                      : "Tunggu...")),
            ],
          ),
        ))
      ],
    ));
  }
}
