final class Config {
  Config._();
  static const mailContact = 'mrouhi444@gmail.com';
  static const String appName = 'Spartan VPN';
  static const version = '1.0';
  static const company = 'Plaxylorix';
  static const bundleId = 'free.vpn.Plaxylorix.PhantomVPN';

  // static const vpnUrl = 'https://api.shieldme.top/servers/';

  static const privacyPolicyUrl = 'https://sites.google.com/$company-privacy';
  static const termOfUseUrl = 'https://sites.google.com/view/$company-terms';

  static const storeAppUrl =
      'https://play.google.com/store/apps/details?id=$bundleId';

  static final subIds = <String>{
    // 'saigonzoolandsstudio_sub_2.1',
    // 'saigonzoolandsstudio_sub_2.2',
    'remove_ads_yearly',
  };

  static final consumableIds = <String>{
    // 'saigonzoolandsstudio_1.1',
  };
}
