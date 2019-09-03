import 'dart:convert';
import 'package:html_unescape/html_unescape.dart';

class StringUtils {

  static String urlDecoder(String data) {
    return data == null ? null : HtmlUnescape().convert(data);
  }

  static String removeHtmlLabel(String data) {
    return data?.replaceAll(RegExp('<[^>]+>'), '');
  }
}
