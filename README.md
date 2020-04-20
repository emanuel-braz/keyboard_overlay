# keyboard_overlay

### A simple way to show overlay widgets when keyboard rises, without changing widget three from your current project.

#### It shows a custom widget when TextFields get focused, and everything is disposed automatically on StatefulWidget dispose.

![preview_1](https://user-images.githubusercontent.com/3827308/79713672-dc455480-82a4-11ea-96c6-a51971db6034.gif)

#### Add dependency
```dart
dependencies:
    keyboard_overlay: ^0.1.0
```

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
