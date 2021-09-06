import 'package:domodar/stores/providers/connectivity_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension ExtendPadding on Widget {
  paddingAll(double value) {
    return Padding(
      child: this,
      padding: EdgeInsets.all(value),
    );
  }

  paddingLRTB({
    double l = 0.0,
    double r = 0.0,
    double t = 0.0,
    double b = 0.0,
  }) {
    return Padding(
      child: this,
      padding: EdgeInsets.only(left: l, right: r, bottom: b, top: t),
    );
  }
}

extension ExtendVisibilty on Widget {
  visibleWhere(bool condition) {
    return condition ? SizedBox.shrink() : this;
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}

extension StateLayouts on Widget {
  withConnectivityLayout() {
    return Consumer<ConnectivityProvider>(builder: (_, provider, child) {
      return provider.isOffline
          ? Stack(
              children: [
                this,
                // OfflineBar(), ur widget to be shown with the layout
              ],
            )
          : this;
    });
  }
}
