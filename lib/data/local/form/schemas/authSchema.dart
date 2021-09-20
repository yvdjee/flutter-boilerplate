import 'package:domodar/data/local/form/validator/validator_builder.dart';

Map<String, String? Function(String? value)> authSchema = {
  "email": ValidationBuilder().email().required().build(),
  "password": ValidationBuilder().required("Password is required").build()
};
