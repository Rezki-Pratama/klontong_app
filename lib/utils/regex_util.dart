class RegexUtil {
  /// Regex of simple mobile. // alternativeGeneral r'\+?([ -]?\d+)+|\(\d+\)([ -]\d+)';
  static const String regexPhoneNumber = r'(?:\+)?8\d{2}(\d{6})';

  /// Match PIN codes to exactly 6 digits
  static const String regexPin6Digit = '^\\d{6}\$';

  /// Match PLN prepaid codes to exactly 6 digits
  static const String regexExactly11Digit = '^\\d{11}\$';

  /// Match KTP to exactly 16 digits //more advanced https://www.huzefril.com/posts/regex/regex-ktp/
  static const String regexKTP16Digit = '^\\d{16}\$';

  /// Regex of email. //alternativeGeneral ^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$
  static const String regexEmail = '^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$';

  /// Match password minimal 8 character, one uppercase, one number, one character
  static const String regexPassword = '^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@\$%^&*-]).{8,}\$';
}
