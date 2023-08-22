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
  Map<String, dynamic>? dataResponse;
  List listResponse = [];

  Future<void> apiCall() async {
    try {
      final response =
          await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
      if (response.statusCode == 200) {
        setState(() {
          // stringResponse = response.body;
          mapResponse = jsonDecode(response.body) as Map<String, dynamic>;
          listResponse = mapResponse!['data'];
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
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            height: 120,
            padding: EdgeInsets.all(2),
            child: Card(
              child: Row(

                children: [
                  Image.network(listResponse[index]['avatar']),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(listResponse[index]['first_name']),
                          Text(listResponse[index]['last_name']),
                          Text(listResponse[index]['email'])
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
          //   Container(
          //   margin: EdgeInsets.only(top: 30),
          //   // child: Column(
          //   //   children: [
          //   //     // Image.network(listResponse[index]['avatar']),
          //   //     // Text(listResponse[index]['first_name']),
          //   //     // Text(listResponse[index]['last_name']),
          //   //     // Text(listResponse[index]['email'])
          //   //   ],
          //   // ),
          // );
        },
        itemCount: listResponse.length,
      ),
      // Center(
      //   child: Container(
      //     height: 300,
      //     width: 300,
      //     decoration: BoxDecoration(
      //         color: Colors.blue, borderRadius: BorderRadius.circular(20)),
      //     child: Center(
      //       // child:  mapResponse==null? Text("Data is loading"): Text(mapResponse!['data'].toString())
      //       child: listResponse == null
      //           ? Container()
      //           : Text(
      //         listResponse![2].toString(),
      //             ),
      //     ),
      //   ),
      // ),
    );
  }
}
