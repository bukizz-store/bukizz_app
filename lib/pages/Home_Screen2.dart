
import 'package:bukizz_1/constants/constants.dart';
import 'package:bukizz_1/pages/student_teacher_login.3.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, //no of tabs

      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),

          //tabs defined bottom of appbar
          bottom: const TabBar(
            tabs: [
              Tab(text: "Ecommerce"),
              Tab(text: "My School"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Content for Ecommerce tab
            const Center(
              child: Text("Ecommerce Content"),
            ),
            // Content for My School tab
            Center(
              child: AppConstants.isLogin ? Text(AppConstants.userData.email) :Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle the teacher button click

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StudentLogin()),
                      );
                    },
                    child: Text("Teacher"),
                  ),

                  SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: () {
                      // Handle the student button click
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StudentLogin()),
                      );
                    },

                    child: Text("Student"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}