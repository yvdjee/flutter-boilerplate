import 'package:domodar/stores/language/app_localization.dart';
import 'package:domodar/stores/providers/connectivity_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class Providers {
  Providers._();

  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider.value(
      value: ConnectivityProvider(),
    ),
    ChangeNotifierProvider.value(
      value: AppLocalization(),
    ),
  ];
}
