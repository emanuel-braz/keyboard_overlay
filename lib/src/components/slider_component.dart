import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_overlay/keyboard_overlay.dart';

class SliderComponent extends StatefulWidget {
  final Color? backgroundColor;
  final Color? textColor;
  final Function()? onSubmitted;
  final String label;
  final bool autoDismiss;
  final List<String> platforms;
  final Function(double) controller;

  SliderComponent(
      {Key? key,
      this.backgroundColor,
      this.textColor,
      this.onSubmitted,
      this.label = 'Done',
      this.autoDismiss = true,
      this.platforms = const ['android', 'ios'],
      required this.controller})
      : super(key: key);

  @override
  _SliderComponentState createState() => _SliderComponentState();
}

class _SliderComponentState extends State<SliderComponent> {
  double _value = 0;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS && widget.platforms.contains('ios') ||
        Platform.isAndroid && widget.platforms.contains('android'))
      return Material(
        child: Container(
          height: 45,
          // width: double.infinity,
          color: widget.backgroundColor ?? Colors.grey,
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.blue[700],
                      inactiveTrackColor: Colors.blue[100],
                      trackShape: RectangularSliderTrackShape(),
                      trackHeight: 4.0,
                      thumbColor: Colors.blueAccent,
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 12.0),
                      overlayColor: Colors.blue.withAlpha(32),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 28.0),
                    ),
                    child: Slider(
                      value: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                        });
                        widget.controller(value);
                      },
                    ),
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.only(right: 24.0, top: 8.0, bottom: 8.0),
                  onPressed: () {
                    if (widget.autoDismiss)
                      KeyboardOverlayManager()
                          .dismissKeyboardAndOverlay(context);
                    this.widget.onSubmitted?.call();
                  },
                  child: Text(widget.label,
                      style: TextStyle(
                          color: widget.textColor ?? Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      );
    return Container();
  }
}
