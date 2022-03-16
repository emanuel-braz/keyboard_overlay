import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_overlay/src/focus_node_overlay.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:keyboard_visibility/keyboard_visibility.dart';

class KeyboardOverlayManager {
  late KeyboardVisibilityNotification visibility;
  bool get isVisible => visibility.isKeyboardVisible;

  KeyboardOverlayManager._privateConstructor() {
    visibility = KeyboardVisibilityNotification();
    visibility.addNewListener(onHide: removeOverlay);

    setDebugMode(kDebugMode); // set debug mode if not is realease
  }
  static final KeyboardOverlayManager _instance =
      KeyboardOverlayManager._privateConstructor();
  factory KeyboardOverlayManager() => _instance;

  FocusNodeOverlay registerFocusNode(BuildContext context,
      {required Widget child}) {
    FocusNodeOverlay focusNode = FocusNodeOverlay(child);
    return focusNode;
  }

  OverlayEntry? overlayEntry;

  showOverlay(BuildContext? context, Widget child) {
    if (overlayEntry != null) removeOverlay();

    if (context != null) {
      Future.delayed(Duration.zero, () {
        OverlayState? overlayState = Overlay.of(context);
        overlayEntry = OverlayEntry(builder: (context) {
          return Stack(
            children: <Widget>[
              child,
            ],
          );
        });

        overlayState?.insert(overlayEntry!);
      });
    }
  }

  removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry?.remove();
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
      debugPrint = debugPrintSynchronously;
    } else {
      debugPrint = (String? text, {int? wrapWidth}) {};
    }
  }
}
