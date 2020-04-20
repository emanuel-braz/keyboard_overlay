import 'package:flutter/material.dart';
import 'package:keyboard_overlay/keyboard_overlay.dart';

class FocusNodeOverlay extends FocusNode {
  final Widget child;
  TextEditingController controller;
  Function() callbackListener;

  FocusNodeOverlay(this.child) {
    this.addListener(callbackListener = () {
      // sempre remove o overlay ativo e abre um novo
      // se perder o focus, o teclado some e o listener de visibilidade de teclado removerá esse overlay
      /// always remove the active overlay and open a new one
      /// if focus is lost, the keyboard will disappear and the keyboard visibility listener will remove the overlay
      if (this.hasFocus)
        KeyboardOverlayManager().showOverlay(context, child ?? Container());
      else
        KeyboardOverlayManager().removeOverlay();
    });
  }

  FocusNodeOverlay add(TextEditingController ctrl) => this..controller = ctrl;
}
