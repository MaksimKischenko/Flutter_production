# web_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


build for web testing:
```

flutter build web --dart-define komplatISCApi=http://192.168.253.178:5537  --dart-define defaultLogin=isc_89 --dart-define defaultPassword=123456



For prod building 
```
flutter build appbundle --dart-define komplatApiUrl=https://mobile.mdom.by --dart-define mdomApiUrl=https://users.mdom.by --dart-define mdomTpIntApi='https://vote.mdom.by'





