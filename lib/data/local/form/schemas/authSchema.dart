import 'package:domodar/data/local/form/schemas/EzSchema.dart';
import 'package:domodar/data/local/form/validator/validator_builder.dart';

EzSchema authSchema = EzSchema.shape({
  "email": EzValidator().email().required().build(),
  "password": EzValidator().required().minLength(6).build(),
  "options": EzValidator().oneOf(['A', 'B']).build(),
});
