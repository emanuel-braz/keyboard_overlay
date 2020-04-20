import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_overlay/src/focus_node_overlay.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class KeyboardOverlayManager {
  KeyboardVisibilityNotification visibility;
  bool get isVisible => visibility.isKeyboardVisible;
  bool removeKeyboardOnScreenTouch = false;

  KeyboardOverlayManager._privateConstructor() {
    visibility = new KeyboardVisibilityNotification();
    visibility.addNewListener(onHide: removeOverlay);

    setDebugMode(kDebugMode); // set debug mode if not is realease
  }
  static final KeyboardOverlayManager _instance =
      KeyboardOverlayManager._privateConstructor();
  factory KeyboardOverlayManager() => _instance;

  FocusNode registerFocusNode(BuildContext context, {@required Widget child}) {
    FocusNodeOverlay focusNode = FocusNodeOverlay(child);
    return focusNode;
  }

  OverlayEntry overlayEntry;

  showOverlay(BuildContext context, Widget child) {
    if (overlayEntry != null) removeOverlay();
    Future.delayed(Duration.zero, () {
      OverlayState overlayState = Overlay.of(context);
      overlayEntry = OverlayEntry(builder: (context) {
        return Stack(
          children: <Widget>[
            // removeKeyboardOnScreenTouch == true
            // ?GestureDetector(
            //   onTap: () => dismissKeyboard(context),
            // ):Container(),
            child,
          ],
        );
      });

      overlayState.insert(overlayEntry);
    });
  }

  removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry.remove();
      overlayEntry = null;
    }
  }

  dismissKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  dismissKeyboardAndOverlay(BuildContext context) {
    removeOverlay();
    dismissKeyboard(context);
  }

  static setDebugMode(bool value) {
    if (value) {
      debugPrint =
          debugPrintSynchronously; //(String text, {int wrapWidth}) => print(value);
    } else {
      debugPrint = (String text, {int wrapWidth}) {};
    }
  }
}
