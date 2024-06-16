part of 'screen_info_bloc.dart';

class ScreenInfoData extends Equatable {
  final ScreenInfoDataPopularServices popularServices;
  final ScreenInfoInfo info;
  final ScreenInfoServices services;
  final ScreenInfoBasket basket;
  final ScreenInfoService service;
  final ScreenInfoCheck check;

  const ScreenInfoData({
    required this.popularServices,
    required this.info,
    required this.services,
    required this.basket,
    required this.service,
    required this.check
  });

  @override
  List<Object?> get props => [
    popularServices,
    info,
    services,
    basket,
    service,
    check
  ];
}

class ScreenInfoDataPopularServices extends Equatable {
  final String logoUrl;
  final String bannerUrl;
  final String basketButtonLabel;
  final String allServicesButtonLabel;
  final String infoButtonLabel;

  const ScreenInfoDataPopularServices({
    required this.logoUrl,
    required this.bannerUrl,
    required this.basketButtonLabel,
    required this.allServicesButtonLabel,
    required this.infoButtonLabel,
  });

  @override
  List<Object?> get props => [
    logoUrl,
    bannerUrl,
    basketButtonLabel,
    allServicesButtonLabel,
    infoButtonLabel
  ];
}

class ScreenInfoInfo extends Equatable {
  final String logoUrl;
  final String title;
  final String pdfUrl;
  final String settingsButtonLabel;
  final String homeButtonLabel;

  const ScreenInfoInfo({
    required this.logoUrl,
    required this.title,
    required this.pdfUrl,
    required this.settingsButtonLabel,
    required this.homeButtonLabel,
  });

  @override
  List<Object?> get props => [
    logoUrl,
    title,
    pdfUrl,
    settingsButtonLabel,
    homeButtonLabel
  ];
}

class ScreenInfoServices extends Equatable {
  final String logoUrl;
  final String backButtonLabel;
  final String homeButtonLabel;

  const ScreenInfoServices({
    required this.logoUrl,
    required this.backButtonLabel,
    required this.homeButtonLabel,
  });


  @override
  List<Object> get props => [
    logoUrl,
    backButtonLabel,
    homeButtonLabel
  ];
}

class ScreenInfoBasket extends Equatable {
  final String logoUrl;
  final String title;
  final String payBasketButtonLabel;
  final String addPaymentButtonLabel;
  final String clearBasketButton;

  const ScreenInfoBasket({
    required this.logoUrl,
    required this.title,
    required this.payBasketButtonLabel,
    required this.addPaymentButtonLabel,
    required this.clearBasketButton,
  });

  @override
  List<Object> get props => [
    logoUrl,
    title,
    payBasketButtonLabel,
    addPaymentButtonLabel,
    clearBasketButton,
  ];
}

class ScreenInfoService extends Equatable {
  /// id 65
  final ScreenInfoServiceAttrsStep attrsStep;
  /// id 69
  final ScreenInfoServiceSumStep sumStep;
  /// id 73
  final ScreenInfoServiceResultStep resultStep;

  const ScreenInfoService({
    required this.attrsStep,
    required this.sumStep,
    required this.resultStep,
  });

  @override
  List<Object?> get props => [
    attrsStep,
    sumStep,
    resultStep,
  ];
}

class ScreenInfoServiceAttrsStep extends Equatable {
  final String logoUrl;
  final String homeButtonLabel;
  final String nextButtonLabel;

  const ScreenInfoServiceAttrsStep({
    required this.logoUrl,
    required this.homeButtonLabel,
    required this.nextButtonLabel,
  });

  @override
  List<Object> get props => [
    logoUrl,
    homeButtonLabel,
    nextButtonLabel,
  ];
}

class ScreenInfoServiceSumStep extends Equatable {
  final String logoUrl;
  final String homeButtonLabel;
  final String nextButtonLabel;

  const ScreenInfoServiceSumStep({
    required this.logoUrl,
    required this.homeButtonLabel,
    required this.nextButtonLabel,
  });

  @override
  List<Object> get props => [
    logoUrl,
    homeButtonLabel,
    nextButtonLabel,
  ];
}

class ScreenInfoServiceResultStep extends Equatable {
  final String logoUrl;
  final String title;
  final String addToBasketButtonLabel;
  final String homeButtonLabel;
  final String payButtonLabel;

  const ScreenInfoServiceResultStep({
    required this.logoUrl,
    required this.title,
    required this.addToBasketButtonLabel,
    required this.homeButtonLabel,
    required this.payButtonLabel,
  });

  @override
  List<Object> get props => [
    logoUrl,
    title,
    addToBasketButtonLabel,
    homeButtonLabel,
    payButtonLabel
  ];
}

class ScreenInfoCheck extends Equatable {
  final String logoUrl;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String homeButtonLabel;

  const ScreenInfoCheck({
    required this.logoUrl,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.homeButtonLabel,
  });

  @override
  List<Object> get props => [
    logoUrl,
    title,
    subtitle,
    imageUrl,
    homeButtonLabel,
  ];
}
