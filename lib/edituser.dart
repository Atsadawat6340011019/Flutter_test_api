import 'package:api_test/profilelogin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Edituser extends StatefulWidget {
  final List users;
  final int index;

  const Edituser({Key? key, required this.users, required this.index})
      : super(key: key);

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<Edituser> {
  TextEditingController user = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController fullname = new TextEditingController();

  bool editMode = false;

  Future editUser() async {
    if (editMode) {
      // var url = 'https://pattyteacher.000webhostapp.com/edit.php';
      var urlstr = "http://172.21.124.108/addressbook/edit.php";
      var url = Uri.parse(urlstr);
      await http.post(url, body: {
        //'id' : widget.list[widget.index]['id'],
        'fullname': fullname.text,
        'username': user.text,
        'password': password.text,
      });
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Profilelogin(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    editMode = true;
    fullname.text = widget.users[widget.index]['fullname'];
    user.text = widget.users[widget.index]['username'];
    password.text = widget.users[widget.index]['password'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 30,
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Profilelogin()),
            );
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Edit User',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: fullname,
                decoration: InputDecoration(
                  hintText: "Fullname",
                  labelText: "Fullname",
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              TextField(
                controller: user,
                enabled: false,
                decoration: InputDecoration(
                  hintText: "Username",
                  labelText: "Username",
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  labelText: "Password",
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 255, 213, 245),
                ),
                child: const Text("EDIT DATA"),
                onPressed: () {
                  setState(() {
                    editUser();
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
