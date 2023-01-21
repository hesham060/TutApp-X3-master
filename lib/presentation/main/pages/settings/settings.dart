import 'package:easy_localization/easy_localization.dart';
import 'package:firstproject/app/di.dart';
import 'package:firstproject/app/shared_prefs.dart';
import 'package:firstproject/data/data_source/local_data_source.dart';
import 'package:firstproject/presentation/resources/languge_manager.dart';
import 'package:firstproject/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/values_manager.dart';
import 'dart:math' as math;

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AppPrefreneces _prefreneces = instance<AppPrefreneces>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: const EdgeInsets.all(AppPadding.p8),
        children: [
          ListTile(
            leading: SvgPicture.asset(ImageAssets.changeLangIc),
            title: Text(AppString.changeLanguage,
                style: Theme.of(context).textTheme.bodyLarge),
            trailing:Transform(alignment: Alignment.center,
            transform:Matrix4.rotationY(_isRrL()?math.pi:0) ,
            child: SvgPicture.asset(ImageAssets.rightArrowSettingsIc) ,

            ),
            onTap: () {
              _changeLanguge();
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.contactUsIc),
            title: Text(AppString.contactUs,
                style: Theme.of(context).textTheme.bodyLarge),
            trailing: Transform(alignment: Alignment.center,
            transform:Matrix4.rotationY(_isRrL()?math.pi:0) ,
            child: SvgPicture.asset(ImageAssets.rightArrowSettingsIc) ,),
            onTap: () {
              _contactUse();
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.inviteFriendsIc),
            title: Text(AppString.inviteYourFriends,
                style: Theme.of(context).textTheme.bodyLarge),
            trailing: Transform(alignment: Alignment.center,
            transform:Matrix4.rotationY(_isRrL()?math.pi:0) ,
            child: SvgPicture.asset(ImageAssets.rightArrowSettingsIc) ,),
            onTap: () {
              _inviteFriends();
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.logoutIc),
            title: Text(AppString.logout,
                style: Theme.of(context).textTheme.bodyLarge),
            trailing: Transform(alignment: Alignment.center,
            transform:Matrix4.rotationY(_isRrL()?math.pi:0) ,
            child: SvgPicture.asset(ImageAssets.rightArrowSettingsIc) ,),
            onTap: () {
              _logout();
            },
          )
        ],
      ),
    );
  }

  _changeLanguge() {
    _prefreneces.changeAppLanguage();
    Phoenix.rebirth(context);
  }
  _isRrL(){
    return context.locale== ARABIC_LOCAL;
  }
  _contactUse() {}
  _inviteFriends() {}

  _logout() {
    // app prefs make that user logout
    _prefreneces.logout();
    // clear cache of logged out user
    _localDataSource.clearCache();
    // navigate to login screen
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }
}
