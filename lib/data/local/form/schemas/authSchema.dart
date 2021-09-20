import 'package:domodar/data/local/form/validator/validator_builder.dart';

Map<String, String? Function(String? value)> authSchema = {
  "email": EzValidator().email().required().build(),
  "password": EzValidator().required("Password is required").build(),
  "condition": EzValidator().defaultTest("Nope it's not begining with A", (v) {
    if (v![0] == "A") return false;
    return true;
  }).build(),
};
