import 'package:domodar/data/form/validator/local.dart';
import 'package:domodar/data/form/validator/regex_list.dart';

import 'form_validator_locale.dart';

typedef StringValidationCallback = String? Function(String? value);

typedef Action<T> = Function(T builder);

class ValidationBuilder {
  ValidationBuilder({
    String? localeName,
    this.optional = false,
    FormValidatorLocale? locale = const LocaleEn(),
    this.requiredMessage,
  }) : _locale = locale as FormValidatorLocale {
    if (!optional) required(requiredMessage);
  }

  final bool optional;
  final String? requiredMessage;
  final FormValidatorLocale _locale;
  final List<StringValidationCallback> validations = [];

  ValidationBuilder reset() {
    validations.clear();
    if (optional != true) {
      required(requiredMessage);
    }
    return this;
  }

  ValidationBuilder add(StringValidationCallback validator) {
    validations.add(validator);
    return this;
  }

  String? test(String? value) {
    for (var validate in validations) {
      if (optional && (value == null || value.isEmpty)) {
        return null;
      }

      final result = validate(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  }

  StringValidationCallback build() => test;

  ValidationBuilder or(
    Action<ValidationBuilder> left,
    Action<ValidationBuilder> right, {
    bool reverse = false,
  }) {
    final v1 = ValidationBuilder(locale: _locale);
    final v2 = ValidationBuilder(locale: _locale);

    left(v1);
    right(v2);

    final v1cb = v1.build();
    final v2cb = v2.build();

    return add((value) {
      final leftResult = v1cb(value);
      if (leftResult == null) {
        return null;
      }
      final rightResult = v2cb(value);
      if (rightResult == null) {
        return null;
      }
      return reverse == true ? leftResult : rightResult;
    });
  }

  ValidationBuilder required([String? message]) =>
      add((v) => v == null || v.isEmpty ? message ?? _locale.required() : null);

  ValidationBuilder minLength(int minLength, [String? message]) =>
      add((v) => v!.length < minLength
          ? message ?? _locale.minLength(v, minLength)
          : null);

  ValidationBuilder maxLength(int maxLength, [String? message]) =>
      add((v) => v!.length > maxLength
          ? message ?? _locale.maxLength(v, maxLength)
          : null);

  ValidationBuilder regExp(RegExp regExp, String message) =>
      add((v) => regExp.hasMatch(v!) ? null : message);

  ValidationBuilder email([String? message]) =>
      add((v) => emailRegExp.hasMatch(v!) ? null : message ?? _locale.email(v));

  ValidationBuilder phone([String? message]) =>
      add((v) => !anyLetter.hasMatch(v!) &&
              phoneRegExp.hasMatch(v.replaceAll(nonDigitsExp, ''))
          ? null
          : message ?? _locale.phoneNumber(v));

  ValidationBuilder ip([String? message]) =>
      add((v) => ipv4RegExp.hasMatch(v!) ? null : message ?? _locale.ip(v));

  ValidationBuilder ipv6([String? message]) =>
      add((v) => ipv6RegExp.hasMatch(v!) ? null : message ?? _locale.ipv6(v));

  ValidationBuilder url([String? message]) =>
      add((v) => urlRegExp.hasMatch(v!) ? null : message ?? _locale.url(v));
}
