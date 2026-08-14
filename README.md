# flutter_intercom

A new Flutter project.

## Language override

Update the language for the currently logged-in Intercom user without logging
them out:

```dart
await FlutterIntercom().setLanguageOverride('ja');
```

The language must be enabled in the Intercom workspace. Use Intercom-supported
locale codes such as `en`, `ja`, `zh-CN`, or `zh-TW`.
