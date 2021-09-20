class Schema {
  Schema._();

  static Map<String, String> validateSync(Map<String, dynamic> form,
      Map<String, String? Function(String? value)> schema) {
    Map<String, String> _errors = {};
    form.forEach((key, value) {
      late String? Function(String?)? validator;
      if (schema.containsKey(key)) {
        validator = schema[key];
        if (validator!(form[key]) != null)
          _errors[key] = validator(form[key]) ?? '';
      }
    });
    return _errors;
  }
}
