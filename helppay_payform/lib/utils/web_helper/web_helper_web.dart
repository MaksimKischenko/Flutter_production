// ignore_for_file: unsafe_html

import 'dart:html' as html;

import 'open_type.dart';

void redirectTo(String url, {OpenType openType = OpenType.newWindow}) {
  if (openType == OpenType.newWindow) {
    // add more paramerter to options like 'location=yes,height=570,width=520,scrollbars=yes,status=yes'
    html.window.open(url,'_blank', 'location=yes');
  } else if (openType == OpenType.sameTab) {
    html.window.open(url,'_self');
  } else {
    html.window.open(url,'_blank');
  }
}