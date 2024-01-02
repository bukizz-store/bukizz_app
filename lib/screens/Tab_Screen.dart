import 'package:bukizz_frontend/screens/ecommerce_screens/ecommerce1.dart';
import 'package:flutter/material.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        bottom: TabBar(
          controller: _tabController,
          indicator: const BoxDecoration(
            color: Color(0xFF03045E),
          ),
          tabs: [
            Tab(
              child: Container(
                width: double.infinity,
                height: 40,
                child: const Center(
                  child: Text('BUKIZZ'),
                ),
              ),
            ),
            Tab(
              child: Container(
                width: double.infinity,
                height: 40,
                child: Center(
                  child: Text('MY SCHOOL'),
                ),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          // Home Tab Content
          EcommercePage(),

          // Grocery Tab Content
          Center(
            child: Text('Grocery Tab Content'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}