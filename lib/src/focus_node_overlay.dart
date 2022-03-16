import 'package:flutter/material.dart';
import 'package:keyboard_overlay/keyboard_overlay.dart';

class FocusNodeOverlay extends FocusNode {
  final Widget? child;
  late TextEditingController controller;
  late Function() callbackListener;

  FocusNodeOverlay(this.child) {
    this.addListener(callbackListener = () {
      /// always remove the active overlay and open a new one
      /// if focus is lost, the keyboard will disappear and the keyboard visibility listener will remove the overlay
      if (this.hasFocus)
        KeyboardOverlayManager()
            .showOverlay(context, child ?? SizedBox.shrink());
      else
        KeyboardOverlayManager().removeOverlay();
    });
  }

  FocusNodeOverlay add(TextEditingController ctrl) => this..controller = ctrl;
}
