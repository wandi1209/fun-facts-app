import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:funfacts/screens/setting_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<dynamic> facts = [];
  bool isLoading = true;

  void getFacts() async {
    try {
      Response response = await Dio().get(
          "https://raw.githubusercontent.com/wandi1209/flutter_api_funfacts/refs/heads/main/facts.json");
      facts = jsonDecode(response.data);
      isLoading = false;
      setState(() {});
    } catch (e) {
      AlertDialog(
        title: Text("Error Conecting"),
        actions: [Text("Cannot get the funfacts data")],
      );
    }
  }

  @override
  void initState() {
    getFacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fun Facts"),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SettingScreen();
              }));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.settings),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : PageView.builder(
                    itemCount: facts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          padding: EdgeInsets.all(15),
                          child: Center(
                            child: Text(
                              facts[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 26),
                            ),
                          ));
                    },
                  ),
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Swipe left for more -->"),
            ),
          )
        ],
      ),
    );
  }
}
