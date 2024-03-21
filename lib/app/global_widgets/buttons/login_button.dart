// Author: drunrapakon sangraung 630510620

import 'package:flutter/material.dart';
import 'package:taskmaster/app/constants/login_button_with_icon.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.loginType,
    required this.goWhere,
  });

  final LoginButtonWithIcon loginType;
  final Function() goWhere;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          goWhere();
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: loginType.loginButtonColor,
        ),
        child: Row(
          children: [
            Image.asset(
              loginType.loginButtonImage,
              width: 32,
              height: 32,
            ),
            const SizedBox(
              width: 32,
            ),
            Text(
              loginType.loginButtonName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
