import 'package:flutter/material.dart';
import 'package:flutter101/core/Lifecycle/LifecycleListenerEvent.dart';


class LifecycleListener<T extends LifecycleListenerEvent>
    extends WidgetsBindingObserver {
  LifecycleListener({required this.providerInstance}) {
    WidgetsBinding.instance.addObserver(this);
  }

  T providerInstance;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        providerInstance.onResume();
        break;
      case AppLifecycleState.inactive:
        providerInstance.onInactive();
        break;
      case AppLifecycleState.paused:
        providerInstance.onPause();
        break;
      case AppLifecycleState.detached:
        providerInstance.onDetached();
        break;
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}
