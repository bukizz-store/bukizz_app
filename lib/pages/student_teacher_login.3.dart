import 'package:flutter/material.dart';

class StudentLogin extends StatefulWidget {
  const StudentLogin({super.key});

  @override
  State<StudentLogin> createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _uniqueIdController = TextEditingController();
  final TextEditingController _schoolCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,



        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).size.height * 0.2,
              20,
              0,
            ),


            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),

                // Email text field
                TextField(
                  controller: _uniqueIdController,
                  decoration: const InputDecoration(
                    labelText: "Enter Unique ID",
                    icon: Icon(Icons.person_outline),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  style: TextStyle(color: Colors.black),
                ),

                const SizedBox(
                  height: 30,
                ),

                // Password text field
                TextField(
                  controller: _passwordTextController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Enter Password",
                    icon: Icon(Icons.lock_outline),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  style: TextStyle(color: Colors.black),
                ),

                const SizedBox(
                  height: 30,
                ),

                TextField(
                  controller: _schoolCodeController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Enter School Code",
                    icon: Icon(Icons.lock_outline),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  style: TextStyle(color: Colors.black),
                ),

                const SizedBox(
                  height: 30,
                ),


                // Sign In button


                ElevatedButton(
                  onPressed: (){
                     // school login using unique id
                  },
                  child: Text("Sign In With School"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
