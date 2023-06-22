import 'package:flutter/cupertino.dart';

screenWidth(context){
  return MediaQuery.of(context).size.width;
}
screenHeight(context){
  return MediaQuery.of(context).size.height;
}
height10(){
  return const SizedBox(height: 10,);
}
height5(){
  return const SizedBox(height: 5,);
}
height15(){
  return const SizedBox(height: 15,);
}
width10(){
  return const SizedBox(width: 10,);
}
width5(){
  return const SizedBox(width: 5,);
}
width15(){
  return const SizedBox(width: 15,);
}
commonPaddingAll10(){
  return const EdgeInsets.all(10);
}
commonPadding1All5(){
  return const EdgeInsets.all(15);
}
commonPaddingAll20(){
  return const EdgeInsets.all(20);
}
commonPaddingAll5(){
  return const EdgeInsets.all(5);
}