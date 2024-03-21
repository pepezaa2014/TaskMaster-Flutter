// Author: drunrapakon sangraung 630510620

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:taskmaster/app/constants/app_colors.dart';
import 'package:taskmaster/resources/resources.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
    required this.isLoading,
    required this.current,
    required this.all,
  });

  final bool isLoading;
  final int current;
  final int all;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !isLoading,
      child: Positioned.fill(
        child: Container(
          color: AppColors.taskmasterPrimaryColor,
          child: Center(
            child: Platform.isAndroid
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageName.logo,
                        width: 200,
                        height: 200,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Now Loading Pokemon Data: $current/$all',
                        style: const TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const SpinKitCircle(
                        color: AppColors.taskmasterSecondaryColor,
                        size: 50,
                      ),
                    ],
                  )
                : const CupertinoActivityIndicator(radius: 16),
          ),
        ),
      ),
    );
  }
}
