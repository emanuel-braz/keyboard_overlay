// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:keyboard_overlay/src/focus_node_overlay.dart';
import 'package:keyboard_overlay/src/keyboard_overlay_manager.dart';

mixin HandleFocusNodesOverlayMixin<T extends StatefulWidget> on State<T> {
  List<FocusNodeOverlay> nodes = <FocusNodeOverlay>[];
  List<TextEditingController> controllers = <TextEditingController>[];
  double get keyboardDy => MediaQuery.of(context).viewInsets.bottom;

  FocusNode GetFocusNodeOverlay<T extends Widget>(
      {required T child, TextEditingController? controller}) {
    FocusNodeOverlay focusNode =
        KeyboardOverlayManager().registerFocusNode(context, child: child);

    /// add reference to be automatically discarded
    this.nodes.add(focusNode);

    if (controller != null) {
      /// Attach node to controller
      focusNode.add(controller);

      /// Stores reference to be discarded automatically
      this.controllers.add(controller);
    }

    return focusNode;
  }

  void disposeAllNodes() {
    disposeNodes(this.nodes);
  }

  void disposeAllControllers() {
    disposeControllers(this.controllers);
  }

  void disposeNodes(List<FocusNodeOverlay> nodeList) {
    nodeList.forEach((focusNode) {
      debugPrint('[FOCUSNODE DISPOSED]: ${focusNode.hashCode}');
      focusNode.removeListener(focusNode.callbackListener);
      focusNode.dispose();
    });
    nodeList.clear();
  }

  void disposeControllers(List<TextEditingController> ctrls) {
    ctrls.forEach((controller) {
      debugPrint('[CONTROLLER DISPOSED]: ${controller.hashCode}');
      controller.dispose();
    });
    ctrls.clear();
  }

  void dismissKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  void dispose() {
    super.dispose();
    disposeAllNodes();
    disposeAllControllers();
  }
}
