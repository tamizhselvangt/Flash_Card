
import 'package:flutter/material.dart';



class CustomButton extends StatelessWidget {

  final dynamic onPressed;
  final String text;
  const CustomButton({super.key,required this.onPressed,required this.text});

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20)
      ),
      child: Text(text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white
      ),),
    );
  }
}
