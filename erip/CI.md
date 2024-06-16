** iOS:

follow link: https://docs.fastlane.tools/actions/upload_to_testflight/

set enviroment variable FASTLANE_PASSWORD:
```
FASTLANE_PASSWORD
```
set SPACESHIP_2FA_SMS_DEFAULT_PHONE_NUMBER:

```
Two-factor Authentication (6 digits code) is enabled for account 'mobile@mdom.by'
More information about Two-factor Authentication: https://support.apple.com/en-us/HT204915

If you're running this in a non-interactive session (e.g. server or CI)
check out https://github.com/fastlane/fastlane/tree/master/spaceship#2-step-verification

(Input `sms` to escape this prompt and select a trusted phone number to send the code as a text message)

(You can also set the environment variable `SPACESHIP_2FA_SMS_DEFAULT_PHONE_NUMBER` to automate this)
(Read more at: https://github.com/fastlane/fastlane/blob/master/spaceship/docs/Authentication.md#auto-select-sms-via-spaceship_2fa_sms_default_phone_number)
```

set FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD:

```
Please sign in with an app-specific password. You can create one at appleid.apple.com. (-22910)
Your account has 2 step verification enabled
Please go to https://appleid.apple.com/account/manage
and generate an application specific password for
the iTunes Transporter, which is used to upload builds

To set the application specific password on a CI machine using
an environment variable, you can set the
FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD variable
```