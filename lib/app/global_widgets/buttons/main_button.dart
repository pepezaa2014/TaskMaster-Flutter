// Author: drunrapakon sangraung 630510620

import 'package:flutter/material.dart';
import 'package:taskmaster/app/constants/main_type_button.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.mainTypeButton,
    required this.function,
  });

  final MainTypeButton mainTypeButton;
  final Function() function;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          function();
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: mainTypeButton.mainTypeButtonColor,
        ),
        child: Center(
          child: Text(
            mainTypeButton.mainTypeButtonName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
