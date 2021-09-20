import 'package:domodar/data/local/form/validator/regex_list.dart';

import 'form_validator_locale.dart';
import 'local.dart';

typedef StringValidationCallback = String? Function(String? value);

typedef Action<T> = Function(T builder);

class EzValidator {
  EzValidator({
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

  EzValidator reset() {
    validations.clear();
    if (optional != true) {
      required(requiredMessage);
    }
    return this;
  }

  EzValidator add(StringValidationCallback validator) {
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

  EzValidator or(
    Action<EzValidator> left,
    Action<EzValidator> right, {
    bool reverse = false,
  }) {
    final v1 = EzValidator(locale: _locale);
    final v2 = EzValidator(locale: _locale);

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

  EzValidator required([String? message]) =>
      add((v) => v == null || v.isEmpty ? message ?? _locale.required() : null);

  EzValidator minLength(int minLength, [String? message]) =>
      add((v) => v!.length < minLength
          ? message ?? _locale.minLength(v, minLength)
          : null);

  EzValidator min(int min, [String? message]) => add(
      (v) => int.parse('$v') <= min ? message ?? _locale.min('$v', min) : null);

  EzValidator max(int min, [String? message]) => add(
      (v) => int.parse('$v') >= min ? message ?? _locale.max('$v', min) : null);

  EzValidator maxLength(int maxLength, [String? message]) =>
      add((v) => v!.length > maxLength
          ? message ?? _locale.maxLength(v, maxLength)
          : null);

  EzValidator matches(RegExp regExp, String message) =>
      add((v) => regExp.hasMatch(v!) ? null : message);

  EzValidator email([String? message]) =>
      add((v) => emailRegExp.hasMatch(v!) ? null : message ?? _locale.email(v));

  EzValidator phone([String? message]) => add((v) => !anyLetter.hasMatch(v!) &&
          phoneRegExp.hasMatch(v.replaceAll(nonDigitsExp, ''))
      ? null
      : message ?? _locale.phoneNumber(v));

  EzValidator ip([String? message]) =>
      add((v) => ipv4RegExp.hasMatch(v!) ? null : message ?? _locale.ip(v));

  EzValidator ipv6([String? message]) =>
      add((v) => ipv6RegExp.hasMatch(v!) ? null : message ?? _locale.ipv6(v));

  EzValidator url([String? message]) =>
      add((v) => urlRegExp.hasMatch(v!) ? null : message ?? _locale.url(v));

  EzValidator boolean([String? message]) => add(
      (v) => booleanExp.hasMatch(v!) ? null : message ?? _locale.boolean(v));

  EzValidator uuid([String? message]) =>
      add((v) => uuidExp.hasMatch(v!) ? null : message ?? _locale.uuid(v));

  EzValidator lowerCase([String? message]) => add(
      (v) => v == v!.toLowerCase() ? null : message ?? _locale.lowerCase(v));

  EzValidator upperCase([String? message]) => add(
      (v) => v == v!.toUpperCase() ? null : message ?? _locale.upperCase(v));

  EzValidator defaultTest(String message, bool Function(String?) test) =>
      add((v) => test(v) ? null : message);
}
