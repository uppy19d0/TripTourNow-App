
import 'package:fluro/fluro.dart';

import 'package:provider/provider.dart';
import 'package:trip_tour_coin/router/router.dart';
import 'package:trip_tour_coin/ui/views/main/EditCasaDeCambio.dart';
import 'package:trip_tour_coin/ui/views/main/Facelock.dart';
import 'package:trip_tour_coin/ui/views/main/UserDetails.dart';
import 'package:trip_tour_coin/ui/views/main/withdraw_select.dart';

import '../class/language_constants.dart';
import '../providers/auth_provider.dart';
import '../providers/ui_provider.dart';
import '../ui/views/auth/Signup.dart';
import '../ui/views/auth/verify_email.dart';
import '../ui/views/confirmation_screens/wait_for_aproval_screen.dart';
import '../ui/views/location_view.dart';
import '../ui/views/login_view.dart';
import '../ui/views/main/BackofficeOffers.dart';
import '../ui/views/main/CasasDeCambio.dart';
import '../ui/views/main/CreateInvoice.dart';
import '../ui/views/main/EditOffer.dart';
import '../ui/views/main/History.dart';
import '../ui/views/main/Invoices.dart';
import '../ui/views/main/MyAccount.dart';
import '../ui/views/main/My_wallet.dart';
import '../ui/views/main/NewOffer.dart';
import '../ui/views/main/OfferConfirmation.dart';
import '../ui/views/main/Offers.dart';
import '../ui/views/main/Transactions.dart';
import '../ui/views/main/UserVerification.dart';
import '../ui/views/main/Users.dart';
import '../ui/views/main/Withdraw_Paypal_Success.dart';
import '../ui/views/main/Withdraws.dart';
import '../ui/views/main/addCasaDeCambio.dart';
import '../ui/views/main/adminOffers.dart';
import '../ui/views/main/administracion.dart';
import '../ui/views/main/backoffice.dart';
import '../ui/views/main/buysuccess.dart';
import '../ui/views/main/cartera-enviar.dart';
import '../ui/views/main/comprar.dart';
import '../ui/views/main/confirmation.dart';
import '../ui/views/main/home_view.dart';
import '../ui/views/main/my_account_view.dart';
import '../ui/views/main/notificaciones.dart';
import '../ui/views/main/recibir.dart';
import '../ui/views/main/virtual_card_screens/virtual_card_screen.dart';
import '../ui/views/main/withdraw_paypal.dart';
import '../ui/views/main/withdraw_paypal_confirm.dart';
import '../ui/views/no_page_found_view.dart';
import '../ui/views/notifications/notifications_read.dart';
import '../ui/views/auth/createAddress.dart';
import '../ui/views/staking/staking_view.dart';

class PageHandlers {
  //casasdecambio handler
  static Handler casasdecambio = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return CasasDeCambio();
  });
  //casadecambio add
  static Handler casadecambioadd = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return AddCasaDeCambio();
  });
  //casadecambio edit
  static Handler casadecambioedit = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);


  });



  //staking
  static Handler staking = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return StakingView();
  });
  //    //OfferConfirmation
  static Handler offerConfirmation = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return OfferConfirmation();
  });
  static Handler location =
      Handler(handlerFunc: (context, params) => const LocationView());

  //administracion
  static Handler administracion= Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return Administracion();
  });
  //adminoffers
  static Handler adminoffers= Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return AdminOffers();
  });
  static Handler login = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.user?.email_verified == false)
      return MailVerificationPage();

    if (authProvider.authStatus == AuthStatus.authenticated) return HomeView();

    return LoginView();
  });
  static Handler register = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    print("register");
    //print parameter 1 from url
    print(params['type']?.first);
    //if type is set var type = type else type 'user';
    var type = params['type']?.first ?? 'user';

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return SignupPage(type: type);
    else
      return HomeView();
  });

  // transactions page
  static Handler transactions = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return TransactionPage();
  });
  static Handler myWallet = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    Provider.of<UiProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.myWalletRoute);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return MyWallet();
  });
  static Handler home = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    print("home");
    print(authProvider.authStatus);
    if (authProvider.authStatus != AuthStatus.authenticated) return LoginView();

    if (authProvider.user?.entropy_created == false)
      return const CreateAddressPage();

    Provider.of<UiProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.homeRoute);

    return HomeView();
  });
  static Handler createAddress = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.authenticated)
      return const CreateAddressPage();

    return LoginView();
  });

  static Handler verifyemail = Handler(handlerFunc: (context, params) {
    Provider.of<UiProvider>(context!, listen: false)
        .setCurrentPageUrl(Flurorouter.verifyMailRoute);
    final authProvider = Provider.of<AuthProvider>(context!);
    return const MailVerificationPage();
  });
  static Handler notifications = Handler(handlerFunc: (context, params) {
    Provider.of<UiProvider>(context!, listen: false)
        .setCurrentPageUrl(Flurorouter.notificationsRoute);
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return const LoginView();
    } else if (params['id']?.first != null) {
      //TicketUpdateView(ticketPos: int.parse(params['id']!.first));
      return NotificationReadView(
          notifiPosition: int.parse(params['id']!.first));
    } else {}
  });

  static Handler bills = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else {}
  });
  static Handler offers = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else {
      return OffersPage();
    }
  });
  static Handler myAccount = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else {
      return MyAccountPage();
    }
  });
  //comprar
  static Handler comprar = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else {
      return ComprarPage();
    }
  });
  //recibir
  static Handler recibir = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else {
      return RecibirPage();
    }
  });
  //enviar
  static Handler enviar = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else {
      return EnviarPage();
    }
  });
  //notificaciones
  static Handler notificaciones = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else {
      return NotificacionesPage();
    }
  });
  //confirmation
  static Handler confirmation = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else {
      return ConfirmationPage();
    }
  });
  //backofffice
  static Handler backoffice = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return Backoffice();
  });
  // backoffice list of offers
  static Handler backofficeListOffers = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return BackofficeOffers();
  });
  static Handler newoffer = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return NewOffer();
  });
  static Handler editoffer = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();

     // return EditOffer();
  });
  //buysuccess
  static Handler buysuccess = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return BuySuccess();
  });
  //withdraws
  static Handler withdraws = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return Withdraws();
  });
  //history
  static Handler history = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return HistoryPage();
  });
  //invoices
  static Handler invoices = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return InvoicesPage();
  });
  //createinvoice
  static Handler createinvoice = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return CreateInvoicePage();
  });
}
//offers

class NoPageFoundHandlers {
  static Handler noPageFound = Handler(handlerFunc: (context, params) {
    return NoPageFoundView();
  });
}
class WithdrawPageHandlers {
  static Handler withdraw = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return Withdraw_method_page();
  });
  //withdraw_paypal
  static Handler withdraw_paypal = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return Withdraw_Paypal();
  });
  //withdraw_paypal_confirm
  static Handler withdraw_paypal_confirm = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return Withdraw_Paypal_Confirm();
  });
  //withdraw_paypal_success
  static Handler withdraw_paypal_success = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return Withdraw_Paypal_Success();
  });
  //newoffer

}
class UserPageHandlers{
  //userVerification
  static Handler userVerification = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return UserVerification();
  });
  //facelock
  static Handler facelock = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return Facelock();
  });
  //waitForApproval
  static Handler waitForApproval = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return WaitForApprovalScreen();
  });
  //virtualCard
  static Handler virtualCard = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
     return VirtualCardScreen();
  });
  //users
  static Handler users = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return SavereceipientScreen();
  });


}
