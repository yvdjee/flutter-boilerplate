import 'package:domodar/data/local/form/validator/validator_builder.dart';

Map<String, String? Function(String? value)> authSchema = {
  "email": EzValidator().email().required().build(),
  "password": EzValidator().required("Password is required").build(),
  "options": EzValidator().oneOf(['A', 'B']).build(),
};
