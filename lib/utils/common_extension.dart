import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:klontong_project/utils/regex_util.dart';

extension ValidatorExt on String {
  bool isValidPassword() {
    return RegExp(RegexUtil.regexPassword).hasMatch(this);
  }

  bool isValidPIN() {
    return RegExp(RegexUtil.regexPin6Digit).hasMatch(this);
  }

  bool isValidEmail() {
    return RegExp(RegexUtil.regexEmail).hasMatch(this);
  }

  bool isValidPhone() {
    return RegExp(RegexUtil.regexPhoneNumber).hasMatch(this);
  }
}

extension AssetStringExt on String {
  String loadString(
      {required BuildContext context, String errorString = 'Error'}) {
    try {
      return AppLocalizations.of(context)!.error;
    } catch (error) {
      debugPrint('$error');
      return errorString;
    }
  }
}

extension CapitalizationExt on String {
  String get inCaps =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';

  String get capitalizeFirstofEachChar => replaceAll(RegExp(' +'), ' ')
      .split(" ")
      .map((str) => str.inCaps)
      .join(" ");
}

extension MoneyFormatter on num {
  static final _currencyFormat = NumberFormat("#,##0", "id_ID");

  String toCurrencyFormat() {
    return _currencyFormat.format(this);
  }
}

extension IntegerValidation on int {
  bool isTrue() {
    if (this == 1) {
      return true;
    } else {
      return false;
    }
  }
}

// extension CurrencyFormatter on double {
//   String toFormattedCurrency() {
//     try {
//       return NumberFormat.simpleCurrency(
//         name: 'IDR',
//       ).format(this / 100);
//     } catch (error) {
//       debugPrint('$error');
//       return "";
//     }
//   }
//
//
// }

//
// extension DoubleFormatter on double {
//   String toEuro() {
//     return NumberFormat.simpleCurrency(
//       name: 'IDR',
//     ).format(this / 100);
//   }
//
//   String toPln() {
//     return NumberFormat.simpleCurrency(
//       name: 'PLN',
//     ).format(this / 100);
//   }
// }
