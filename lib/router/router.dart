import 'package:fluro/fluro.dart';
import 'package:trip_tour_coin/router/page_handlers.dart';
import 'package:trip_tour_coin/router/staking_handlers.dart';

import 'exchange_handler.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static String rootRoute = '/';
  static String loginRoute = '/login';
  //registerRoute must have type parameter
  static String registerRoute = '/register/:type';

  static String verifyMailRoute = "/verify_email";
  static String homeRoute = '/home';
  static String createAddressRoute = '/createAddress';
  static String myAccountRoute = '/myaAccount';
  static String notificationsRoute = '/notifications';
  static String notificationsReadRoute = '/notification/:id';
  static String billsRoute = '/bills';
  static String ticketsRoute = '/tickets';
  static String ticketsActionRoute = '/tickets/:action';
  static String ticketsActionIdRoute = '/tickets/:action/:id';
  static String myWalletRoute = '/myWallet';
  //transactions
  static String transactionsRoute = '/transactions';
  //offers
  static String offersRoute = '/offers';
  //MyAccount
  static String myAccount = '/myAccount';
  //comprar
  static String comprarRoute = '/comprar';
//recibir
  static String recibirRoute = '/recibir';
  //enviar
  static String enviarRoute = '/enviar';
  //notificaciones
  static String notificacionesRoute = '/notificaciones';
  //withdraw_paypal
  static String withdraw_paypalRoute = '/withdraw_paypal';
  //confirmation
  static String confirmationRoute = '/confirmation';
  static String withdrawSelectRoute = '/withdrawSelect';
  //withdrawpaypalconfirm
  static String withdrawpaypalconfirmRoute = '/withdrawpaypalconfirm';
  //backoffice
  static String backofficeRoute = '/backoffice';
  //backoffice list of offers
  static String backofficeListOffersRoute = '/backofficeListOffers';
  //newoffer
  static String newofferRoute = '/newoffer';
  //editoffer
  static String editofferRoute = '/editoffer';
  //administracion
  static String administracionRoute = '/administracion';
  //adminoffers
  static String adminoffersRoute = '/adminoffers';
  //buysuccess
  static String buysuccessRoute = '/buysuccess';
  //withdraws
  static String withdrawsRoute = '/withdraws';
  //userVerification
  static String userVerificationRoute = '/userVerification';
  //facelock
  static String facelockRoute = '/facelock';
  //waitForApproval
  static String waitForApprovalRoute = '/waitForApproval';
  //VirtualCard
  static String virtualCardRoute = '/virtualCard';
  //    //OfferConfirmationRoute
  static String offerConfirmationRoute = '/offerConfirmation';
  //users and userdetails
  static String usersRoute = '/users';
  static String userDetailsRoute = '/userDetails';
  //history
  static String historyRoute = '/history';
  //invoices
  static String invoicesRoute = '/invoices';
  //createinvoice
  static String createinvoiceRoute = '/createinvoice';
  //stakingRoute
  static String stakingRoute = '/staking';
  static String stakingDepositarRoute = '/staking/deposit';
  static String stakingStakeRoute = '/staking/stake';
  static String stakingEarnRoute = '/staking/earn';
  //casasdecambio
  static String casasdecambioRoute = '/casasdecambio';
  //casadecambio add
  static String casadecambioaddRoute = '/casadecambioadd';
  //casadecambio edit
  static String casadecambioeditRoute = '/casadecambioedit';

  //ExchangeIndex
  static String exchangeIndexRoute = '/exchangeIndex';
  //Exchangeadd
  static String exchangeAddRoute='/exchangeAdd';
  //successExchange
  static String successExchangeRoute='/successExchange';
  //buywithpaypal
  static String buywithpaypalRoute='/buywithpaypal';
  //buy with USDT
  static String buywithusdtRoute='/buywithusdt';
  //buywithBTC
  static String buywithbtcRoute='/buywithbtc';
  //buy with eth
  static String buywithethRoute='/buywitheth';
  //buywithpaypalconfirm
  static String buywithpaypalconfirmRoute='/buywithpaypalconfirm';
  //StakingCancelled
  static String stakingCancelledRoute='/stakingCancelled';
  //ReconciliationConfirmRoute
  static String reconciliationConfirmRoute='/reconciliationConfirm';
  //conciliations
  static String conciliationsRoute='/conciliations';
  //detailConciliationRoute
  static String detailConciliationRoute='/detailConciliation';


  static void configureRoutes() {

    //buy with usdt
    router.define(buywithusdtRoute,
        handler: ExchangeHandlers.buywithusdt, transitionType: TransitionType.none);
    //buy with btc
    router.define(buywithbtcRoute,
        handler: ExchangeHandlers.buywithbtc, transitionType: TransitionType.none);

    // BUY WITH ETH
    router.define(buywithethRoute,
        handler: ExchangeHandlers.buywitheth, transitionType: TransitionType.none);

    //conciliations
    router.define(conciliationsRoute,
        handler: ExchangeHandlers.conciliations, transitionType: TransitionType.none);
    //reconciliationConfirm
    router.define(reconciliationConfirmRoute,
        handler: ExchangeHandlers.reconciliationConfirm, transitionType: TransitionType.none);
    //buywithpaypal
    router.define(buywithpaypalRoute,
        handler: ExchangeHandlers.buywithpaypal, transitionType: TransitionType.none);
    //buywithpaypalconfirm
    router.define(buywithpaypalconfirmRoute,
        handler: ExchangeHandlers.buywithpaypalsuccess, transitionType: TransitionType.none);
    //successExchange
    router.define(successExchangeRoute,
        handler: ExchangeHandlers.successExchange, transitionType: TransitionType.none);
    //exchangeIndex
    router.define(exchangeIndexRoute,
        handler: ExchangeHandlers.exchangeIndex, transitionType: TransitionType.none);
    //exchangeAdd
    router.define(exchangeAddRoute,
        handler: ExchangeHandlers.exchangeAdd, transitionType: TransitionType.none);
    //casa de cambio add
    router.define(casadecambioaddRoute,
        handler: PageHandlers.casadecambioadd,
        transitionType: TransitionType.none);
    //casa de cambio edit
    router.define(casadecambioeditRoute,
        handler: PageHandlers.casadecambioedit,
        transitionType: TransitionType.none);
    //casas de cambio
    router.define(casasdecambioRoute,
        handler: PageHandlers.casasdecambio,
        transitionType: TransitionType.none);
    //staking
    router.define(stakingRoute, handler: PageHandlers.staking, transitionType: TransitionType.none);
    router.define(stakingDepositarRoute, handler: StakingHandlers.stakingDeposit, transitionType: TransitionType.none);
    router.define(stakingStakeRoute, handler: StakingHandlers.stakingStake, transitionType: TransitionType.none);
    router.define(stakingEarnRoute, handler: StakingHandlers.earnStake, transitionType: TransitionType.none);

    router.define(rootRoute,
        handler: PageHandlers.location, transitionType: TransitionType.none);

    router.define(createAddressRoute,
        handler: PageHandlers.createAddress,
        transitionType: TransitionType.none);

    router.define(loginRoute,
        handler: PageHandlers.login, transitionType: TransitionType.none);

    router.define(registerRoute,
        handler: PageHandlers.register, transitionType: TransitionType.none);


    router.define(verifyMailRoute,
        handler: PageHandlers.verifyemail, transitionType: TransitionType.none);
    //route for MyWallet
    router.define(myWalletRoute,
        handler: PageHandlers.myWallet, transitionType: TransitionType.none);
    router.define(transactionsRoute,
        handler: PageHandlers.transactions,
        transitionType: TransitionType.none);

    router.define(homeRoute,
        handler: PageHandlers.home, transitionType: TransitionType.none);
    router.define(myAccountRoute,
        handler: PageHandlers.myAccount, transitionType: TransitionType.none);
    router.define(notificationsRoute,
        handler: PageHandlers.notifications,
        transitionType: TransitionType.none);
    router.define(notificationsReadRoute,
        handler: PageHandlers.notifications,
        transitionType: TransitionType.none);
    //offers
    //OfferConfirmationRoute
    router.define('/offerConfirmation',
        handler: PageHandlers.offerConfirmation,
        transitionType: TransitionType.none);
    router.define(offersRoute,
        handler: PageHandlers.offers, transitionType: TransitionType.none);
    router.define(newofferRoute,
        handler: PageHandlers.newoffer, transitionType: TransitionType.none);
    router.define(editofferRoute,
        handler: PageHandlers.editoffer, transitionType: TransitionType.none);
    //MyAccount
    router.define(myAccountRoute,
        handler: PageHandlers.myAccount, transitionType: TransitionType.none);
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
    //comprar
    router.define(comprarRoute,
        handler: PageHandlers.comprar, transitionType: TransitionType.none);
    //recibir
    router.define(recibirRoute,
        handler: PageHandlers.recibir, transitionType: TransitionType.none);
    //enviar
    router.define(enviarRoute,
        handler: PageHandlers.enviar, transitionType: TransitionType.none);
    //notificaciones
    router.define(notificacionesRoute,
        handler: PageHandlers.notificaciones, transitionType: TransitionType.none);
    //confirmation
    router.define('/confirmation',
        handler: PageHandlers.confirmation, transitionType: TransitionType.none);
    router.define('/withdrawSelect', handler: WithdrawPageHandlers.withdraw , transitionType: TransitionType.none);
  //withdraw_paypal
    router.define('/withdraw_paypal', handler: WithdrawPageHandlers.withdraw_paypal , transitionType: TransitionType.none);
    //withdrawpaypalconfirm
    router.define('/withdrawpaypalconfirm', handler: WithdrawPageHandlers.withdraw_paypal_confirm , transitionType: TransitionType.none);
    //backoffice
    router.define('/backoffice', handler: PageHandlers.backoffice , transitionType: TransitionType.none);
    //backoffice list of offers
    router.define('/backofficeListOffers', handler: PageHandlers.backofficeListOffers , transitionType: TransitionType.none);
    //administracion
    router.define('/administracion', handler: PageHandlers.administracion , transitionType: TransitionType.none);
    //adminoffers
    router.define('/adminoffers', handler: PageHandlers.adminoffers , transitionType: TransitionType.none);
    //buy success
    router.define('/buysuccess', handler: PageHandlers.buysuccess , transitionType: TransitionType.none);
    //withdraws
    router.define('/withdraws', handler: PageHandlers.withdraws , transitionType: TransitionType.none);
    //userVerification
    router.define('/userVerification', handler: UserPageHandlers.userVerification , transitionType: TransitionType.none);
    //facelock
    router.define('/facelock', handler: UserPageHandlers.facelock , transitionType: TransitionType.none);
    //waitForApproval
    router.define('/waitForApproval', handler: UserPageHandlers.waitForApproval , transitionType: TransitionType.none);
    //VirtualCard
    router.define('/virtualCard', handler: UserPageHandlers.virtualCard , transitionType: TransitionType.none);
    //users
    router.define('/users', handler: UserPageHandlers.users , transitionType: TransitionType.none);
    //history
    router.define('/history', handler: PageHandlers.history , transitionType: TransitionType.none);
    //invoices
    router.define('/invoices', handler: PageHandlers.invoices , transitionType: TransitionType.none);
    //createinvoice
    router.define('/createinvoice', handler: PageHandlers.createinvoice , transitionType: TransitionType.none);
    //StakingCancelled
    router.define('/StakingCancelled', handler: StakingHandlers.stakingCancelled , transitionType: TransitionType.none);
  }

}
