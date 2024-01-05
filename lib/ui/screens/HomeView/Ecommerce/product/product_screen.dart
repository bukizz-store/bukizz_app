import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../data/providers/school_repository.dart';

class ProductScreen extends StatefulWidget {
  static const route = '/product_screen';
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var schoolData = context.read<SchoolDataProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(schoolData.schoolName),
      ),
      body: Expanded(
        child: ListView.builder(
          itemCount: schoolData.selectedSchool.products.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(schoolData.selectedSchool.products[index].name),
              subtitle: Text(schoolData.selectedSchool.products[index].price.toString()),
            );
          },
        ),
      ),
      );
  }
}
