import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:api_test/profilelogin.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  void clearText() {
    user.clear();
    pwd.clear();
  }

  final _formkey = GlobalKey<FormState>();
  TextEditingController user = TextEditingController();
  TextEditingController pwd = TextEditingController();

  int check = 0;

  Future<void> checkLogin() async {
    final urlstr = 'http://172.21.124.108/addressbook/checklogin.php';
    final url = Uri.parse(urlstr);
    final response = await http.post(url, body: {
      'username': user.text,
      'password': pwd.text,
    });

    print(response.statusCode);
    if (response.statusCode == 200) {
      //Success
      final json = response.body;
      final data = jsonDecode(json);
      debugPrint('Data: $data');
      
      if (data == 'Complete') {
        setState(() {
          check = 1; //Login Complete
          
        }
        );
        
        print('Result: $data');
        
      } else {
        Fluttertoast.showToast(
            msg: "Please check username or password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        print('Result: $data');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
            child: Text(
          'Login',
          style: TextStyle(color: Colors.black),
        )),
      ),
      body: Form(
          key: _formkey,
          child: Center(
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Login Form',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    controller: user,
                    decoration: const InputDecoration(
                      labelText: 'username',
                      hintText: 'Please input username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: pwd,
                    decoration: const InputDecoration(
                      labelText: 'password',
                      hintText: 'Please input password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formkey.currentState!.validate()) {
                            checkLogin();
                            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Profilelogin()),
          );
                          }
                        },
                        child: const Text('Login'),
                      ),
                      ElevatedButton(
                          onPressed: clearText, child: const Text('Cancle')),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
