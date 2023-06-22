import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ingredients_manager/utils/AppColor.dart';
import 'package:ingredients_manager/utils/constants.dart';
import 'package:ingredients_manager/widgets/AppTextView.dart';

import '../../widgets/AppTextField.dart';
import '../../widgets/backAppbar.dart';
class AddIngredientPage extends StatefulWidget {
  const AddIngredientPage({super.key});

  @override
  State<AddIngredientPage> createState() => _AddIngredientPageState();
}

class _AddIngredientPageState extends State<AddIngredientPage> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController ingredientNameController = TextEditingController();
  TextEditingController ingredientWeightController = TextEditingController();
  String selectedWeight = "";
  List<IngredientsModel> ingredientsList = [];
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref("Products");

  void insertData(
      String productName, String weight, List<IngredientsModel> ingredients ) {
    var productRef =
    ref.child(productName);
    productRef.set({
      'ProductName': productName,
      'ProductWeight': weight,
      'Ingredients':List.generate(ingredients.length, (index) => {
        'IngredientName': ingredients[index].name,
        'IngredientWeight': ingredients[index].weight,
      })
    });
    Navigator.pop(context);
  }
@override
  void dispose() {
  productNameController.dispose();
  ingredientNameController.dispose();
  ingredientWeightController.dispose();
    super.dispose();
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: backAppBar(context),
      body: SafeArea(
        child: ListView(
          padding: commonPaddingAll10(),
          children: [
            SizedBox(
              width: screenWidth(context),
              height: 45,
              child: Row(
                children: [
                  Expanded(
                    flex:2,
                    child: appTextField(
                      controller: productNameController,
                      labelText: "Product Name", inputFormatters: [],
                    ),
                  ),
                  width5(),
                  Expanded(child: appTextField(
                    suffixIcon: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                         isExpanded: true,
                        hint: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: appTextView(name: selectedWeight==""?"Choose":selectedWeight),
                        ),
                        items: <String>['100', '150', '250', '500'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedWeight = val!;
                          });
                        },
                      ),
                    ), inputFormatters: []
                  ))
                ],
              ),
            ),
            height5(),
            ingredientListAdd(),
            height5(),
            appTextView(name: ingredientsList.isEmpty?"":"Ingredients",color: AppColor.white,size: 20),
            height5(),
            ingredientListView(),
            submitButton(context)
          ],
        ),
      ),
    );
  }

    Widget ingredientListAdd() {
      return SizedBox(
            height: 45,
            child: Row(
              children: [
                Expanded(child: appTextField(controller: ingredientNameController,labelText: "Name", inputFormatters: [])),
                width5(),
                Expanded(child: appTextField(controller: ingredientWeightController,labelText: "Weight",keyboardType: TextInputType.phone, inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"),),])),
                width5(),
                InkWell(
                  onTap: () {
                    if (productNameController.text.isEmpty || selectedWeight == "" || ingredientNameController.text.isEmpty || ingredientWeightController.text.isEmpty) {
                      return;
                    } else {
                      setState(() {
                        ingredientsList.add(IngredientsModel(
                            ingredientNameController.text,
                            ingredientWeightController.text));
                        ingredientNameController.text = "";
                        ingredientWeightController.text = "";
                      });
                    }
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(color: AppColor.white,borderRadius: BorderRadius.circular(5)),
                    child: const Icon(Icons.done,color: AppColor.buttonGreen,),
                  ),
                )
              ],
            ),
          );
    }

    Widget ingredientListView() {
      return ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: ingredientsList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.only(bottom: 5),
                height: 45,
                child: Row(
                  children: [
                    Expanded(child: appTextField(enabled: false,labelText: ingredientsList[index].name, inputFormatters: [])),
                    width5(),
                    Expanded(child: appTextField(enabled: false,labelText: ingredientsList[index].weight, inputFormatters: [])),
                    width5(),
                    InkWell(
                      onTap:(){
                        setState(() {
                          ingredientsList.removeAt(index);
                        });
                      },
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(color: AppColor.white,borderRadius: BorderRadius.circular(5)),
                        child: const Icon(Icons.delete,color: AppColor.red,),
                      ),
                    )
                  ],
                ),
              );
            },);
    }

    Widget submitButton(BuildContext context) {
      return Visibility(
            visible: ingredientsList.isEmpty?false:true,
            child: InkWell(onTap: (){
              if(productNameController.text.isEmpty||selectedWeight==""){
                return ;
              }else{
                insertData(productNameController.text, selectedWeight, ingredientsList);
              }
            },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColor.buttonGreen
                ),
                height: 45,
                width: screenWidth(context),
                child: Center(
                  child: appTextView(name: "Submit",color: AppColor.white),
                ),
              ),
            ),
          );
    }
}

class IngredientsModel{
  String name;
  String weight;
  IngredientsModel(this.name, this.weight);
}



