import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartupViewModel extends BaseViewModel {
  final log = getLogger('StartupViewModel');
  final _sharedPreferencesService = locator<SharedPreferences>();
  final _navigationService = locator<NavigationService>();
  final _database = locator<DDDatabase>();
  final _driftChatService = locator<DriftChatService>();
  final _permissionsService = locator<PermissionsService>();
  final _userService = locator<UserService>();

  bool _animationComplete = false;
  String _destinationRoute;
  dynamic _destinationArguments;

  Future initialise() async {
    await locator<RemoteConfigService>().initialise();
    await _driftChatService
        .setupDrift(FlavorConfig.instance.values.driftChatId);

    var hasUser = _sharedPreferencesService.hasUser;
    var isGuestUser = _sharedPreferencesService.guestMode;
    log.v('hasUser:$hasUser');

    if (hasUser || isGuestUser) {
      // Database initialised first because user service will insert the address
      // into the database
      await _database.initialise();
      await _userService.initialise();

      if (!isGuestUser) {
        await _driftChatService.registerUser(
          userId: _userService.currentUser.id.toString(),
          email: _userService.currentUser.email,
        );
      }

      if (_userService.currentAddress != null) {
        await _navigationService.replaceWith(Routes.homeView);
      } else {
        var hasPermission = await _permissionsService.hasLocationPermission;
        if (!hasPermission) {
          await _permissionsService.requestLocationPermission();
        }

        await _navigationService.replaceWith(
          Routes.addressSelectionView,
          arguments: AddressSelectionViewArguments(
            showDefaultUi: false,
            firstSignIn: true,
            localOnly: isGuestUser,
          ),
        );
      }
    } else {
      await _navigationService.replaceWith(Routes.welcomeView);
    }
  }

  void indicateAnimationComplete() {
    _animationComplete = true;
  }
}
