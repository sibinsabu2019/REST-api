import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.black),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<dynamic> user = [];
void fetchuser() async {
  print("fetching user......");
  const url = "https://randomuser.me/api/?results=5000";
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  final body = response.body;
  final jsondata = json.decode(body);
  user = jsondata['results'];
  print("data fetched");
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("REST-api")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            fetchuser();
          });
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: ListView.builder(
          itemCount: user.length,
          itemBuilder: (context, index) {
            dynamic users = user[index];

            final name = users['name']['first'];
            dynamic image = users['picture']['thumbnail'];
            final number = users['phone'];

            return ListTile(
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(image)),
              title: Text(name),
              subtitle: Text(number),
            );
          }),
    );
  }
}
