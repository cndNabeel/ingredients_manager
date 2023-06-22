import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ingredients_manager/screens/add_ingredient_page/ingredient_add_page%20.dart';
import 'package:ingredients_manager/utils/AppColor.dart';
import 'package:ingredients_manager/utils/constants.dart';
import 'package:ingredients_manager/widgets/AppTextField.dart';
import 'package:ingredients_manager/widgets/AppTextView.dart';
import 'package:ingredients_manager/widgets/backAppbar.dart';

class IngredientsViewPAge extends StatefulWidget {
  final String productName;
  final String productWeight;

  const IngredientsViewPAge(this.productName, this.productWeight, {super.key});

  @override
  State<IngredientsViewPAge> createState() => _IngredientsViewPAgeState();
}

class _IngredientsViewPAgeState extends State<IngredientsViewPAge> {
  List<IngredientsModel> ingredients = [];

  TextEditingController quantityController = TextEditingController();
  int selectedQTY = 1;

  fetchData() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('Products').child(widget.productName).child('Ingredients').get();
    setState(() {
      for (int i = 0; i < snapshot.children.length; i++) {
        ingredients.add(IngredientsModel("${snapshot.child('$i').child('IngredientName').value}", "${snapshot.child('$i').child('IngredientWeight').value}"));
      }
    });
  }
  qtyPopup(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:AppColor.showDialogBoxColor,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              appTextView(name: "QTY",size: 40,color: AppColor.textGreen,fontWeight: FontWeight.bold),
              appTextView(name: "Choose the quantity you want",size: 20,color: AppColor.textGreen,fontWeight: FontWeight.bold),
              height5(),
              SizedBox(
                height: 45,
                child: Row(
                  children: [
                    Expanded(child: appTextField(
                        labelText: widget.productWeight,
                      enabled: false, inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"),),]
                    )),
                    width5(),
                    Expanded(
                      child: appTextField(
                        controller: quantityController,
                        labelText: "Quantity",
                        keyboardType: TextInputType.phone, inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"),),]
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            MaterialButton(
              child: const Text("OK"),
              onPressed: () {
                if(quantityController.text.isEmpty || int.parse(quantityController.text)<=0){
                  return Navigator.of(context).pop();
                }else{
                  setState(() {
                    selectedQTY=int.parse(quantityController.text);
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
  @override
  void initState() {
    fetchData();
    super.initState();
  }
  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: backAppBar(context),
      body: SafeArea(
        child: productDetails(),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))
        ),
          backgroundColor: AppColor.buttonGreen,
          child: const Icon(Icons.calculate,color: AppColor.white,),
          onPressed: () {
        qtyPopup();
      }),
    );
  }

  ListView productDetails() {
    return ListView(
        padding: commonPaddingAll10(),
        children: [
          appTextView(
              name: widget.productName,
              color: AppColor.textGreen,
              size: 40,
              fontWeight: FontWeight.bold),
          appTextView(
              name: "${int.parse(widget.productWeight)*selectedQTY}",
              color: AppColor.textGreen,
              size: 25,
              fontWeight: FontWeight.bold),
          height10(),
          DataTable(
            border: TableBorder.symmetric(
              outside: const BorderSide(width: 1, color: Colors.grey, style: BorderStyle.solid),
              inside: const BorderSide(width: 1, color: Colors.grey, style: BorderStyle.solid),
            ),
            columns: [
              DataColumn(label: appTextView(name: "Ingredient Name",color: AppColor.textGreen,)),
              DataColumn(label: appTextView(name: "Ingredient Weight",color: AppColor.textGreen,),),
            ],

            rows: List.generate(ingredients.length, (index) {
              return
              DataRow(
                  cells: [
                DataCell(appTextView(
                    name:
                    ingredients[index].name,
                    color: AppColor.textGreen,
                    size: 18,
                    fontWeight: FontWeight.bold)),
                DataCell(appTextView(
                    name:
                    "${(int.parse(ingredients[index].weight))*selectedQTY}",
                    color: AppColor.textGreen,
                    size: 18,
                    fontWeight: FontWeight.bold)),
              ]);
            }),
          ),
        ],
      );
  }
}


