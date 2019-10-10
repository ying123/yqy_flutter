import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import "package:yqy_flutter/utils/regex_utils.dart";

class RRouter {
  static Router _router;

  static initWithRouter(Router router) {
    _router = router;
  }

  static Router router() {
    return _router;

  }

  static push(BuildContext context, String path, Map<String, dynamic> params, {bool clearStack = false, TransitionType transition = TransitionType.inFromRight}) {
    String query =  "";
    int index = 0;
    for (var key in params.keys) {
      String value = params[key].toString();
      if (value.startsWith('http')) {
        value = Uri.encodeComponent(value);
      }else if (RegexUtils.isZh(value)) {
        value = jsonEncode(Utf8Encoder().convert(value));
      }

      if (index == 0) {
        query = "?";
      } else {
        query = query + "\&";
      }

      query += "$key=$value";
      index++;
    }
    path = path + query;
    return _router.navigateTo(context, path, clearStack: clearStack, transition:transition);
  }

  static pop(BuildContext context) {
    _router.pop(context);
  }
}