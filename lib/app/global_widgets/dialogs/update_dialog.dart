// Author: drunrapakon sangraung 630510620

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmaster/app/constants/app_colors.dart';

class UpdateDialog extends StatelessWidget {
  const UpdateDialog({
    super.key,
    required this.onTap,
    required this.title,
    required this.contents,
    required this.accept,
    required this.cancel,
    this.alert,
  });

  final Function() onTap;
  final String title;
  final String contents;
  final String accept;
  final String cancel;
  final bool? alert;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          title,
          style: GoogleFonts.kanit(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: alert ?? false ? Colors.red : Colors.black,
          ),
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          contents,
          style: GoogleFonts.kanit(
            fontSize: 16,
          ),
        ),
      ),
      actions: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(12),
            ),
          ),
          child: CupertinoDialogAction(
            child: Text(
              cancel,
              style: GoogleFonts.kanit(
                color: AppColors.taskmasterSecondaryColor,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: alert ?? false
                  ? Colors.transparent
                  : AppColors.taskmasterSecondaryColor,
              width: 1.0,
            ),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(12),
            ),
            color: alert ?? false
                ? Colors.transparent
                : AppColors.taskmasterSecondaryColor,
          ),
          child: CupertinoDialogAction(
            onPressed: () => onTap(),
            child: Text(
              accept,
              style: GoogleFonts.kanit(
                color: alert ?? false ? Colors.red : Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
