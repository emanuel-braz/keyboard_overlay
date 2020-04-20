# keyboard_overlay

A simple way to show overlay widgets when keyboard rises, without changing widget three from your current project

```dart
//use mixin on State<StatefulWidget>: HandleFocusNodesOverlayMixin
```

### Init FocusNodeOverlay
```dart
@override
void initState() {
    _nodePassword = GetFocusNodeOverlay(
        child: SpecialDismissable(
            onOkButton: () => print(_nodePassword.controller.text),
            title: 'SPECIAL',
        ),
        controller: TextEditingController()
    )    
}
```

### Use it on TextFields
```dart
TextFormField(
    focusNode: _nodePassword,
    controller: _nodePassword.controller
)
```

```dart
@override
void dispose() {
    // Don't need to dispose FocusNodeOverlay and TextEditingController, it will be disposed automatically
    super.dispose();
}
```
