import 'package:flutter/foundation.dart';

class EzSchema {
  final Map<String, String? Function(String? value)> _schema;
  final bool? identicalKeys;

  EzSchema.shape(this._schema, {this.identicalKeys});

  Map<String, String> validateSync(Map<String, dynamic> form) {
    if (identicalKeys ?? false) if (!_compareKeys(_schema))
      throw new Exception("value and schema must have the same keys");

    Map<String, String> _errors = {};
    form.forEach((key, value) {
      late String? Function(String?)? validator;
      if (this._schema.containsKey(key)) {
        validator = this._schema[key];
        if (validator!(form[key]) != null)
          _errors[key] = validator(form[key]) ?? '';
      }
    });
    return _errors;
  }

  bool _compareKeys(Map<String, dynamic> form) {
    return (listEquals(form.keys.toList(), this._schema.keys.toList()));
  }
}
