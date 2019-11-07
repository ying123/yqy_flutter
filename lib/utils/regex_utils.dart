class RegexUtils {
  /// Regex of email.
  static final String regexEmail =
      "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";

  /// Regex of url.
  static final String regexUrl = "[a-zA-z]+://[^\\s]*";

  /// Regex of Chinese character.
  static final String regexZh = "[\\u4e00-\\u9fa5]";

  /// Return whether input matches regex of email.
  static bool isEmail(String input) {
    return matches(regexEmail, input);
  }

  /// Return whether input matches regex of url.
  static bool isURL(String input) {
    return matches(regexUrl, input);
  }

  /// Return whether input matches regex of Chinese character.
  static bool isZh(String input) {
    return '〇' == input || matches(regexZh, input);
  }

  static bool matches(String regex, String input) {
    if (input == null || input.isEmpty) return false;
    return new RegExp(regex).hasMatch(input);
  }


  ///手机号验证
  static bool isChinaPhoneLegal(String str) {
    return RegExp(
        r"^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$")
        .hasMatch(str);
  }


}
