import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_overlay/keyboard_overlay.dart';

class DoneButtonIos extends StatelessWidget {
  final Color? backgroundColor;
  final Color? textColor;
  final Function()? onSubmitted;
  final String label;
  final bool autoDismiss;
  final List<String> platforms;

  DoneButtonIos(
      {Key? key,
      this.backgroundColor,
      this.textColor,
      this.onSubmitted,
      this.label = 'Done',
      this.autoDismiss = true,
      this.platforms = const ['android', 'ios']})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS && platforms.contains('ios') ||
        Platform.isAndroid && platforms.contains('android'))
      return Container(
        height: 45,
        width: double.infinity,
        color: backgroundColor ?? Colors.grey,
        child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
            child: CupertinoButton(
              padding: EdgeInsets.only(right: 24.0, top: 8.0, bottom: 8.0),
              onPressed: () {
                if (autoDismiss)
                  KeyboardOverlayManager().dismissKeyboardAndOverlay(context);
                if (this.onSubmitted != null) this.onSubmitted?.call();
              },
              child: Text(label,
                  style: TextStyle(
                      color: textColor ?? Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      );
    return SizedBox.shrink();
  }
}
