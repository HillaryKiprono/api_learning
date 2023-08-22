import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Learning',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String stringResponse = ""; // Initialize with an empty string
  Map<String, dynamic>? mapResponse; // Use nullable type

  Future<void> apiCall() async {
    try {
      final response = await http.get(Uri.parse("https://reqres.in/api/users/2"));
      if (response.statusCode == 200) {
        setState(() {
          stringResponse = response.body;
          mapResponse = jsonDecode(response.body) as Map<String, dynamic>;
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void initState() {
    apiCall();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API Learning"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(20)),
          child: Center(
            child:  mapResponse==null? Text("Data is loading"): Text(mapResponse!['data'].toString())



            ),
          ),
        ),

    );
  }
}
