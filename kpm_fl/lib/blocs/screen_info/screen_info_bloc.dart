// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:dartx/dartx.dart';
import 'package:equatable/equatable.dart';
import 'package:kpm_fl/data/data.dart';

part 'screen_info_event.dart';
part 'screen_info_state.dart';

class ScreenInfoBloc extends Bloc<ScreenInfoEvent, ScreenInfoData> {
  final DataManager dataManager;

  final ScreenInfoData defaultData;

  ScreenInfoBloc({
    required this.dataManager,
    required this.defaultData
  }) : super(defaultData) {
    on<ScreenInfoEvent>(_onEvent);
  }

  void _onEvent(
    ScreenInfoEvent event,
    Emitter<ScreenInfoData> emit
  ) {
    if (event is ScreenInfoLoad) return _onScreenInfoLoad(event, emit);
  }

  void _onScreenInfoLoad(
    ScreenInfoLoad event,
    Emitter<ScreenInfoData> emit
  ) async {
    try {
      final response = await dataManager.getUserProfileRequest();
      if ((response.errorCode ?? 0) == 0) {
        final popularServicesScreenObject = response.screens?.firstOrNullWhere((e) => e.idx == 1);
        final infoScreenObject = response.screens?.firstOrNullWhere((e) => e.idx == 9);
        final servicesScreenObject = response.screens?.firstOrNullWhere((e) => e.idx == 8);
        final basketScreenObject = response.screens?.firstOrNullWhere((e) => e.idx == 7);
        final serviceAttrsScreenObject = response.screens?.firstOrNullWhere((e) => e.idx == 65);
        final serviceSumScreenObject = response.screens?.firstOrNullWhere((e) => e.idx == 69);
        final serviceResultScreenObject = response.screens?.firstOrNullWhere((e) => e.idx == 73);
        final checkScreenObject = response.screens?.firstOrNullWhere((e) => e.idx == 79);

        emit(ScreenInfoData(
          popularServices: ScreenInfoDataPopularServices(
            logoUrl: popularServicesScreenObject?.getObjectWithId(1)?.url
                ?? defaultData.popularServices.logoUrl,
            bannerUrl: popularServicesScreenObject?.getObjectWithId(4)?.url
                ?? defaultData.popularServices.bannerUrl,
            basketButtonLabel: popularServicesScreenObject?.getObjectWithId(6)?.text
                ?? defaultData.popularServices.basketButtonLabel,
            allServicesButtonLabel: popularServicesScreenObject?.getObjectWithId(7)?.text
                ?? defaultData.popularServices.allServicesButtonLabel,
            infoButtonLabel: popularServicesScreenObject?.getObjectWithId(8)?.text
                ?? defaultData.popularServices.infoButtonLabel,
          ),
          info: ScreenInfoInfo(
            logoUrl: infoScreenObject?.getObjectWithId(1)?.url
                ?? defaultData.info.logoUrl,
            title: infoScreenObject?.getObjectWithId(2)?.text
                ?? defaultData.info.title,
            pdfUrl: infoScreenObject?.getObjectWithId(3)?.url
                ?? defaultData.info.pdfUrl,
            settingsButtonLabel: infoScreenObject?.getObjectWithId(4)?.text
                ?? defaultData.info.settingsButtonLabel,
            homeButtonLabel: infoScreenObject?.getObjectWithId(5)?.text
                ?? defaultData.info.homeButtonLabel
          ),
          services: ScreenInfoServices(
            logoUrl: servicesScreenObject?.getObjectWithId(1)?.url
                ?? defaultData.services.logoUrl,
            backButtonLabel: servicesScreenObject?.getObjectWithId(3)?.text
                ?? defaultData.services.backButtonLabel,
            homeButtonLabel: servicesScreenObject?.getObjectWithId(4)?.text
                ?? defaultData.services.homeButtonLabel
          ),
          basket: ScreenInfoBasket(
            logoUrl: basketScreenObject?.getObjectWithId(1)?.url
                ?? defaultData.basket.logoUrl,
            title: basketScreenObject?.getObjectWithId(2)?.text
                ?? defaultData.basket.title,
            payBasketButtonLabel: basketScreenObject?.getObjectWithId(4)?.text
                ?? defaultData.basket.payBasketButtonLabel,
            addPaymentButtonLabel: basketScreenObject?.getObjectWithId(5)?.text
                ?? defaultData.basket.addPaymentButtonLabel,
            clearBasketButton: basketScreenObject?.getObjectWithId(6)?.text
                ?? defaultData.basket.clearBasketButton
          ),
          service: ScreenInfoService(
            attrsStep: ScreenInfoServiceAttrsStep(
              logoUrl: serviceAttrsScreenObject?.getObjectWithId(1)?.url
                  ?? defaultData.service.attrsStep.logoUrl,
              homeButtonLabel: serviceAttrsScreenObject?.getObjectWithId(2)?.text
                  ?? defaultData.service.attrsStep.homeButtonLabel,
              nextButtonLabel: serviceAttrsScreenObject?.getObjectWithId(3)?.text
                  ?? defaultData.service.attrsStep.nextButtonLabel,
            ),
            sumStep: ScreenInfoServiceSumStep(
              logoUrl: serviceSumScreenObject?.getObjectWithId(1)?.url
                  ?? defaultData.service.sumStep.logoUrl,
              homeButtonLabel: serviceSumScreenObject?.getObjectWithId(2)?.text
                  ?? defaultData.service.sumStep.homeButtonLabel,
              nextButtonLabel: serviceSumScreenObject?.getObjectWithId(3)?.text
                  ?? defaultData.service.sumStep.nextButtonLabel,
            ),
            resultStep: ScreenInfoServiceResultStep(
              logoUrl: serviceResultScreenObject?.getObjectWithId(1)?.url
                  ?? defaultData.service.resultStep.logoUrl,
              title: serviceResultScreenObject?.getObjectWithId(2)?.text
                  ?? defaultData.service.resultStep.logoUrl,
              addToBasketButtonLabel: serviceResultScreenObject?.getObjectWithId(3)?.text
                  ?? defaultData.service.resultStep.logoUrl,
              homeButtonLabel: serviceResultScreenObject?.getObjectWithId(4)?.text
                  ?? defaultData.service.resultStep.logoUrl,
              payButtonLabel: serviceResultScreenObject?.getObjectWithId(5)?.text
                  ?? defaultData.service.resultStep.logoUrl
            )
          ),
          check: ScreenInfoCheck(
            logoUrl: checkScreenObject?.getObjectWithId(1)?.url
                ?? defaultData.check.logoUrl,
            title: checkScreenObject?.getObjectWithId(2)?.text
                ?? defaultData.check.title,
            subtitle: checkScreenObject?.getObjectWithId(3)?.text
                ?? defaultData.check.subtitle,
            imageUrl: checkScreenObject?.getObjectWithId(4)?.url
                ?? defaultData.check.imageUrl,
            homeButtonLabel: checkScreenObject?.getObjectWithId(5)?.text
                ?? defaultData.check.homeButtonLabel,
          )
        ));
      } else {
        emit(defaultData);
      }
    // ignore: avoid_catches_without_on_clauses
    } catch(error, _) {
      emit(defaultData);
    }
  }
}
