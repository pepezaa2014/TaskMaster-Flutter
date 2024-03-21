// Author: drunrapakon sangraung 630510620

import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:taskmaster/app/data/models/app_error_model.dart';

class AlertAction {
  String title;
  bool isDefaultAction;
  bool isDestructiveAction;
  bool closePopupAndAction;
  VoidCallback? onAction;

  AlertAction({
    required this.title,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
    this.closePopupAndAction = true,
    this.onAction,
  });
}

void showAlert({
  String? title,
  String? message,
  VoidCallback? onAction,
}) {
  showAlertAction(
    title: title,
    message: message,
    alertActions: [
      AlertAction(
        title: 'Ok',
        onAction: onAction,
      ),
    ],
  );
}

void showAlertError({
  required Object? error,
  VoidCallback? onAction,
}) {
  showAlert(
    message: (error is AppError) ? error.message : error.toString(),
    onAction: onAction,
  );
}

void showAlertAction({
  String? title,
  String? message,
  required List<AlertAction> alertActions,
}) {
  HapticFeedback.lightImpact();
  if (Platform.isAndroid) {
    Get.dialog(
      AlertDialog(
        title: (title != null)
            ? Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            : null,
        content: (message != null)
            ? Text(
                message,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              )
            : null,
        actions: alertActions.map((e) {
          return TextButton(
            onPressed: () {
              if (e.closePopupAndAction) {
                Get.back();
              }
              if (e.onAction != null) {
                e.onAction!();
              }
            },
            child: Text(
              e.title,
              style: TextStyle(
                color: e.isDestructiveAction
                    ? Colors.redAccent
                    : Colors.blueAccent,
                fontSize: 16,
                fontWeight:
                    e.isDefaultAction ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        }).toList(),
      ),
      barrierColor: Colors.black38,
      barrierDismissible: false,
    );
  } else {
    Get.dialog(
      CupertinoAlertDialog(
        title: (title != null) ? Text(title) : null,
        content: (message != null) ? Text(message) : null,
        actions: alertActions.map((e) {
          return TextButton(
            onPressed: () {
              if (e.closePopupAndAction) {
                Get.back();
              }
              if (e.onAction != null) {
                e.onAction!();
              }
            },
            style: TextButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              splashFactory: NoSplash.splashFactory,
              foregroundColor: Colors.grey,
              minimumSize: const Size.fromHeight(48),
            ),
            child: Text(
              e.title,
              style: TextStyle(
                color: e.isDestructiveAction
                    ? Colors.redAccent
                    : Colors.blueAccent,
                fontSize: 16,
                fontWeight:
                    e.isDefaultAction ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        }).toList(),
      ),
      barrierColor: Colors.black38,
      barrierDismissible: false,
    );
  }
}
