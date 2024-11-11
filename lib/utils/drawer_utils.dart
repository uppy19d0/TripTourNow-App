
import 'package:trip_tour_coin/utils/strings.dart';

import 'assets.dart';

class DrawerUtils {
  static List items = [
    {
      'title': Strings.savedReceipients,
      'icon': Assets.receipient,
      'route': '/SaveReceipientScreen',
    },
    {
      'title': Strings.transactionLog,
      'icon': Assets.transactionHistory,
      'route': '/TransactionLogScreen',
    },
    {
      'title': Strings.giftcardLog,
      'icon': Assets.buyGiftCard,
      'route': '/GiftCardLogScreen',
    },
    {
      'title': Strings.billPaymentLog,
      'icon': Assets.billPay,
      'route': '/BillPaymentLogScreen',
    },
    {
      'title': Strings.mobileTopUpLog,
      'icon': Assets.mobileTopUp,
      'route': '/MobileTopUpLogScreen',
    },
    {
      'title': Strings.settings,
      'icon': Assets.settings,
      'route': '/SettingScreen',
    },
    {
      'title': Strings.helpCenter,
      'icon': Assets.helpcenter,
      'route': '/SdavedRdeceipients',
    },
    {
      'title': Strings.privacyPolicy,
      'icon': Assets.privacyPolicy,
      'route': '/savedRdecdeipients',
    },
    {
      'title': Strings.aboutUs,
      'icon': Assets.aboutus,
      'route': '/savedRecdeipients',
    },
    {
      'title': Strings.signOut,
      'icon': Assets.signOut,
      'route': '/signInScreen',
    },
  ];
}
