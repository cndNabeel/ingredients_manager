import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ingredients_manager/utils/AppColor.dart';
import 'package:ingredients_manager/utils/constants.dart';

import '../../widgets/AppTextView.dart';
import '../add_ingredient_page/ingredient_add_page .dart';
import '../ingredient_view_page/ingredient_view_page.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map> productNameList = [];
  getProducts()async{
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('Products').get();
    setState(() {
      for (var element in snapshot.children) {
        productNameList.add({'name':'${element.child("ProductName").value}','weight':'${element.child("ProductWeight").value}'});
      }
    });
  }
  @override
  void initState() {
    getProducts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.buttonGreen,
        centerTitle: true,
        title: appTextView(name: "Welcome",size: 40,color:AppColor.white ),
      ),
      body: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
        children: [
          productList()
        ],
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.buttonGreen,
          child: const Icon(Icons.add), onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddIngredientPage())).then((value) {
            getProducts();
            productNameList.clear();
          });
      }),
    );
  }
  Widget productList() {
    return ListView.builder(
          padding: commonPaddingAll10(),
          primary: false,
          shrinkWrap: true,
          itemCount: productNameList.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> IngredientsViewPAge(productNameList[index]['name'],productNameList[index]['weight'],)));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5) ,
                  color: AppColor.white,
                ),

                height: 50,
                margin: const EdgeInsets.only(bottom: 10),
                child:  Center(
                  child: appTextView(
                      name: productNameList[index]['name'],
                      size: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            );
          },);
  }

}



