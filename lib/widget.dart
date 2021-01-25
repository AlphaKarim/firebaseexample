
import 'package:flutter/material.dart';

InputDecoration textInputDecoration(String text){
  return InputDecoration(
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlue)
      ),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white54)
      ),
      hintStyle: TextStyle(
          fontSize: 20,
          color: Colors.white54
      ),
      hintText: text
  );
}