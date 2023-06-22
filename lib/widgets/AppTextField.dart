import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget appTextField(
    {
      required List<TextInputFormatter> inputFormatters,
      enabled = true,
      controller,
      String labelText="",
      TextInputType keyboardType= TextInputType.name,
      suffixIcon,
    }
    ) {
  return TextFormField(
    toolbarOptions: const ToolbarOptions(
        copy:false,
        paste: false,
        cut: false,
        selectAll: true
    ),
    inputFormatters: inputFormatters,
    enabled: enabled,
    controller: controller,
    decoration: InputDecoration(
      suffixIcon: suffixIcon,
      labelText: labelText,
      fillColor: Colors.white,
      filled:true,
      border: OutlineInputBorder(
        borderRadius:  BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: Colors.lightGreen,
        )
      ),
    ),
    keyboardType: keyboardType,
  );
}