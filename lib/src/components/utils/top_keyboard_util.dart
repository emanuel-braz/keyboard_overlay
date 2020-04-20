import 'package:flutter/material.dart';

class TopKeyboardUtil extends StatefulWidget {
  final Widget child;
  TopKeyboardUtil(this.child);

  @override
  _TopKeyboardUtilState createState() => _TopKeyboardUtilState();
}

class _TopKeyboardUtilState extends State<TopKeyboardUtil> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        right: 0.0,
        left: 0.0,
        child: widget.child);
  }
}
