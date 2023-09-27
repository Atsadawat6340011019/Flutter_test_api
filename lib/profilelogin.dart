import 'dart:convert';

import 'package:api_test/edituser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Profilelogin extends StatefulWidget {
  const Profilelogin({super.key});

  @override
  State<Profilelogin> createState() => _ProfileloginState();
}

class _ProfileloginState extends State<Profilelogin> {
  List<dynamic> users = [];

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  Future<void> getUsers() async {
    const urlstr = "http://172.21.124.108/addressbook/select.php";

    final url = Uri.parse(urlstr);
    final response = await http.get(url);
    debugPrint('Response: $response.statusCode');
    if (response.statusCode == 200) {
      //Success
      final json = response.body;
      final data = jsonDecode(json);
      debugPrint('Data: $data');

      setState(() {
        users = data;
      });
    } else {
      //Error
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 30,
          icon: const Icon(Icons.home),
          color: Colors.black,
          onPressed: () {
            // ...
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: 
      ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final fullname = users[index]['fullname'];
            final username = users[index]['username'];
            return ListTile(
              leading: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Edituser(
                          users: users,
                          index: index,
                        ),
                      ));
                },
                child: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 255, 213, 245),
                  child: Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                ),
              ),
              title: Text(
                username,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(fullname),
            );
          }),
      
    );
  }
}
