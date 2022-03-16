import 'package:flutter/material.dart';
import 'package:keyboard_overlay/keyboard_overlay.dart';

class SpecialDismissable extends StatefulWidget {
  final void Function()? onOkButton;
  final String? title;
  SpecialDismissable({this.onOkButton, this.title});

  @override
  _SpecialDismissableState createState() => _SpecialDismissableState();
}

class _SpecialDismissableState extends State<SpecialDismissable>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  double _wHeight = 1;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    ));

    _controller.forward();
  }

  @override
  void didChangeDependencies() {
    _wHeight = MediaQuery.of(context).padding.top + kToolbarHeight;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Material(
        child: Container(
            height: _wHeight,
            color: Colors.grey,
            padding: EdgeInsets.only(top: 45),
            child: Container(
              height: 45,
              padding: EdgeInsets.only(left: 16),
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  Text(widget.title ?? '',
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 22)),
                  Expanded(
                    child: DoneButtonIos(
                        label: 'OK',
                        autoDismiss: false,
                        onSubmitted: () {
                          widget.onOkButton?.call();

                          _controller.reverse().whenCompleteOrCancel(() {
                            KeyboardOverlayManager()
                                .dismissKeyboardAndOverlay(context);
                          });
                        }),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
