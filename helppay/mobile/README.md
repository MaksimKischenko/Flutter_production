# HelpPay (android, ios)

Приложение для платежей физ лиц

Flutter 3.0.0

cmd enviroment varibles:
* appFlavour: String. default: mdom
full - all functions, helppay - scan&payment functions, mdom - accruals&voting functions
* showFakeDeviceFrame: bool. default: false
* defaultLogin: String?.
* defaultPassword: String?.

build for web testing:
```
flutter build web --base-href=/helppay_mobile/ --dart-define showFakeDeviceFrame=true --dart-define komplatApiUrl=http://192.168.244.136/helppay_json --dart-define mdomApiUrl=http://192.168.244.126:8085/mdom_user --dart-define mdomTpIntApi=http://192.168.244.126:8085/komplat_internal --dart-define komplatQrApiUrl=http://192.168.244.126:8085/helppay_qr/online.request --dart-define mdomTpInfoApi=http://192.168.244.126:8085/mdom_user --dart-define defaultLogin=praded@mdom.by --dart-define defaultPassword=0112358


//For sergey qr_scanner build
flutter build apk --dart-define komplatApiUrl=http://192.168.244.126:8085/komplat --dart-define mdomApiUrl=http://192.168.244.126:8085/mdom_user --dart-define mdomTpIntApi=http://192.168.244.126:8085/komplat_internal --dart-define komplatQrApiUrl=http://192.168.244.126:8085/helppay_qr/online.request --dart-define mdomTpInfoApi=http://192.168.244.126:8085/mdom_user --dart-define defaultLogin=praded@mdom.by --dart-define defaultPassword=0112358

build for web testing prod:
```
flutter build web --base-href=/helppay_mobile_production/ --dart-define showFakeDeviceFrame=true 

generate locales file:
```
flutter pub run slang
```

For iOS build :
*Change version and build number in XCode
*Change version and build number in pubspec.yaml if it doesnt chainged earlier
*Run flutter build ipa in command line from mobile folder

