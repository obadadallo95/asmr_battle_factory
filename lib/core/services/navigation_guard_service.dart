import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/exit_confirmation_dialogs.dart';

enum ProtectionLevel {
  none,           // Safe to exit
  warning,        // Unsaved changes (configuration)
  critical,       // API calls in progress (money being spent)
}

class NavigationGuardNotifier extends StateNotifier<ProtectionLevel> {
  NavigationGuardNotifier() : super(ProtectionLevel.none);

  String? _currentOperationName;
  double? _estimatedCost;

  void startCriticalOperation(String operationName, double estimatedCost) {
    state = ProtectionLevel.critical;
    _currentOperationName = operationName;
    _estimatedCost = estimatedCost;
  }
  
  void endCriticalOperation() {
    state = ProtectionLevel.none;
    _currentOperationName = null;
    _estimatedCost = null;
  }
  
  void setUnsavedChanges(bool hasChanges) {
    if (state != ProtectionLevel.critical) {
       state = hasChanges ? ProtectionLevel.warning : ProtectionLevel.none;
    }
  }
  
  Future<bool> canPop(BuildContext context) async {
    switch(state) {
      case ProtectionLevel.critical:
        return await ExitConfirmationDialogs.showCriticalExitDialog(
          context, 
          operationName: _currentOperationName, 
          cost : _estimatedCost
        );
      case ProtectionLevel.warning:
        return await ExitConfirmationDialogs.showUnsavedChangesDialog(context);
      case ProtectionLevel.none:
        return true;
    }
  }
}

final navigationGuardProvider = StateNotifierProvider<NavigationGuardNotifier, ProtectionLevel>((ref) {
  return NavigationGuardNotifier();
});
