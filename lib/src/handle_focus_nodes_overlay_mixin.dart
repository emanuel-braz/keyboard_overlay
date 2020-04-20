import 'package:flutter/material.dart';
import 'package:keyboard_overlay/src/focus_node_overlay.dart';
import 'package:keyboard_overlay/src/keyboard_overlay_manager.dart';

mixin HandleFocusNodesOverlayMixin<T extends StatefulWidget> on State<T> {
  List<FocusNodeOverlay> nodes = <FocusNodeOverlay>[];
  List<TextEditingController> controllers = <TextEditingController>[];
  double get keyboardDy => MediaQuery.of(context).viewInsets.bottom;

  FocusNode GetFocusNodeOverlay<T extends Widget>(
      {T child, TextEditingController controller}) {
    FocusNodeOverlay focusNode =
        KeyboardOverlayManager().registerFocusNode(context, child: child);

    // adiciona referencia para ser descartada automaticamente
    /// add reference to be automatically discarded
    this.nodes.add(focusNode);

    if (controller != null) {
      // Vincula controller ao node
      /// Attach node to controller
      focusNode.add(controller);
      // Armazena referencia para ser descartada automaticamente
      /// Stores reference to be discarded automatically
      this.controllers.add(controller);
    }

    return focusNode;
  }

  void disposeAllNodes() {
    disposeNodes(this.nodes);
    this.nodes = null;
  }

  void disposeAllControllers() {
    disposeControllers(this.controllers);
    this.controllers = null;
  }

  void disposeNodes(List<FocusNodeOverlay> nodeList) {
    nodeList.forEach((focusNode) {
      debugPrint('[FOCUSNODE DISPOSED]: ${focusNode.hashCode}');
      focusNode.removeListener(focusNode.callbackListener);
      focusNode.dispose();
    });
  }

  void disposeControllers(List<TextEditingController> ctrls) {
    ctrls.forEach((controller) {
      debugPrint('[CONTROLLER DISPOSED]: ${controller.hashCode}');
      controller.dispose();
    });
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
