// ignore: avoid_classes_with_only_static_members
import 'blocs/blocs.dart';

class AppConfig {
  static const String appName = 'KPM';

  // cmd args

  static const bool showFakeDeviceFrame = bool.fromEnvironment('showFakeDeviceFrame');

  // cmd args END

  static const int listPopularRequestLoadCount = 20;

  // static const int allServicesCode = 431000000000;
  static const int allServicesCode = 0;

  static const int defaultCurrency = 933;

  // currency code to name
  static const Map<int, String> mapCurrencyToName = {
    933: 'BYN',
    860: 'UZS'
  };

  // default screen data
  static const screenData = ScreenInfoData(
    popularServices: ScreenInfoDataPopularServices(
      // logoUrl: '/imgs/logo.png',
      logoUrl: '',
      // bannerUrl: '/imgs/main_banner.png',
      bannerUrl: '',
      basketButtonLabel: 'Корзина',
      allServicesButtonLabel: 'Все услуги',
      infoButtonLabel: 'Офёрта'
    ),
    info: ScreenInfoInfo(
      logoUrl: '',
      title: 'Оферта',
      pdfUrl: '',
      settingsButtonLabel: 'Настройки',
      homeButtonLabel: 'Главное меню'
    ),
    services: ScreenInfoServices(
      logoUrl: '',
      backButtonLabel: 'Назад',
      homeButtonLabel: 'Главное меню'
    ),
    basket: ScreenInfoBasket(
      logoUrl: '',
      title: 'Корзина платежей',
      payBasketButtonLabel: 'Оплатить корзину',
      addPaymentButtonLabel: 'Добавить платеж',
      clearBasketButton: 'Очистить корзину'
    ),
    service: ScreenInfoService(
      attrsStep: ScreenInfoServiceAttrsStep(
        logoUrl: '',
        homeButtonLabel: 'Главное меню',
        nextButtonLabel: 'Вперёд',
      ),
      sumStep: ScreenInfoServiceSumStep(
        logoUrl: '',
        homeButtonLabel: 'Главное меню',
        nextButtonLabel: 'Вперёд',
      ),
      resultStep: ScreenInfoServiceResultStep(
        logoUrl: '',
        title: 'Чек оплаты',
        addToBasketButtonLabel: 'Добавить в корзину',
        homeButtonLabel: 'Главное меню',
        payButtonLabel: 'Оплатить'
      )
    ),
    check: ScreenInfoCheck(
      logoUrl: '',
      title: 'Чек',
      subtitle: '',
      imageUrl: '',
      homeButtonLabel: 'Главное меню'
    )
  );

}