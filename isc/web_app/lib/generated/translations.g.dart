/// Generated file. Do not edit.
///
/// Locales: 2
/// Strings: 735 (367 per locale)
///
/// Built on 2023-04-03 at 09:48 UTC


// coverage:ignore-file
// ignore_for_file: type=lint


import 'package:flutter/widgets.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.ru;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.ru) // set locale
/// - Locale locale = AppLocale.ru.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.ru) // locale check
enum AppLocale with BaseAppLocale<_TranslationsRu> {
	ru(languageCode: 'ru', build: _TranslationsRu.build),
	en(languageCode: 'en', build: _TranslationsEn.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<_TranslationsRu> build;

	/// Gets current instance managed by [LocaleSettings].
	_TranslationsRu get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
_TranslationsRu get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
class Translations {
	Translations._(); // no constructor

	static _TranslationsRu of(BuildContext context) => InheritedLocaleData.of<AppLocale, _TranslationsRu>(context).translations;
}

/// The provider for method B
class TranslationProvider extends BaseTranslationProvider<AppLocale, _TranslationsRu> {
	TranslationProvider({required super.child}) : super(
		initLocale: LocaleSettings.instance.currentLocale,
		initTranslations: LocaleSettings.instance.currentTranslations,
	);

	static InheritedLocaleData<AppLocale, _TranslationsRu> of(BuildContext context) => InheritedLocaleData.of<AppLocale, _TranslationsRu>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	_TranslationsRu get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, _TranslationsRu> {
	LocaleSettings._() : super(
		locales: AppLocale.values,
		baseLocale: _baseLocale,
		utils: AppLocaleUtils.instance,
	);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale) => instance.setLocale(locale);
	static AppLocale setLocaleRaw(String rawLocale) => instance.setLocaleRaw(rawLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, _TranslationsRu> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
}

// context enums

enum GenderContext {
	male,
	female,
}

// interfaces generated as mixins

mixin PageData2 {
	String get title;
	String? get content => null;
}

// translations

// Path: <root>
class _TranslationsRu implements BaseTranslations {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_TranslationsRu.build({PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: _cardinalResolver = cardinalResolver,
		  _ordinalResolver = ordinalResolver;

	final PluralResolver? _cardinalResolver; // ignore: unused_field
	final PluralResolver? _ordinalResolver; // ignore: unused_field

	late final _TranslationsRu _root = this; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensRu mobileScreens = _TranslationsMobileScreensRu._(_root);
	late final _TranslationsModelsRu models = _TranslationsModelsRu._(_root);
	late final _TranslationsWidgetsRu widgets = _TranslationsWidgetsRu._(_root);
	late final _TranslationsModalRu modal = _TranslationsModalRu._(_root);
	late final _TranslationsGeneralRu general = _TranslationsGeneralRu._(_root);
	late final _TranslationsExceptionsRu exceptions = _TranslationsExceptionsRu._(_root);
}

// Path: mobileScreens
class _TranslationsMobileScreensRu {
	_TranslationsMobileScreensRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensSplashRu splash = _TranslationsMobileScreensSplashRu._(_root);
	late final _TranslationsMobileScreensAuthRu auth = _TranslationsMobileScreensAuthRu._(_root);
	late final _TranslationsMobileScreensAuthPasswordResetRu authPasswordReset = _TranslationsMobileScreensAuthPasswordResetRu._(_root);
	late final _TranslationsMobileScreensRegistrationRu registration = _TranslationsMobileScreensRegistrationRu._(_root);
	late final _TranslationsMobileScreensRegistrationCodeRu registrationCode = _TranslationsMobileScreensRegistrationCodeRu._(_root);
	late final _TranslationsMobileScreensRegistrationParamsRu registrationParams = _TranslationsMobileScreensRegistrationParamsRu._(_root);
	late final _TranslationsMobileScreensRegistrationSuccessRu registrationSuccess = _TranslationsMobileScreensRegistrationSuccessRu._(_root);
	late final _TranslationsMobileScreensMainRu main = _TranslationsMobileScreensMainRu._(_root);
	late final _TranslationsMobileScreensPaymentsHistoryRu paymentsHistory = _TranslationsMobileScreensPaymentsHistoryRu._(_root);
	late final _TranslationsMobileScreensQrPaymentRu qrPayment = _TranslationsMobileScreensQrPaymentRu._(_root);
	late final _TranslationsMobileScreensPaymentsHistoryFiltersRu paymentsHistoryFilters = _TranslationsMobileScreensPaymentsHistoryFiltersRu._(_root);
	late final _TranslationsMobileScreensPaymentRu payment = _TranslationsMobileScreensPaymentRu._(_root);
	late final _TranslationsMobileScreensProductsRu products = _TranslationsMobileScreensProductsRu._(_root);
	late final _TranslationsMobileScreensProductAddRu productAdd = _TranslationsMobileScreensProductAddRu._(_root);
	late final _TranslationsMobileScreensCardInfoRu cardInfo = _TranslationsMobileScreensCardInfoRu._(_root);
	late final _TranslationsMobileScreensAccountInfoRu accountInfo = _TranslationsMobileScreensAccountInfoRu._(_root);
	late final _TranslationsMobileScreensProfileRu profile = _TranslationsMobileScreensProfileRu._(_root);
	late final _TranslationsMobileScreensProfileEditRu profileEdit = _TranslationsMobileScreensProfileEditRu._(_root);
	late final _TranslationsMobileScreensSettingsRu settings = _TranslationsMobileScreensSettingsRu._(_root);
	late final _TranslationsMobileScreensChangePasswordRu changePassword = _TranslationsMobileScreensChangePasswordRu._(_root);
	late final _TranslationsMobileScreensQrScanRu qrScan = _TranslationsMobileScreensQrScanRu._(_root);
	late final _TranslationsMobileScreensMdomAccrualsRu mdomAccruals = _TranslationsMobileScreensMdomAccrualsRu._(_root);
	late final _TranslationsMobileScreensMdomNotificationsScreenRu mdomNotificationsScreen = _TranslationsMobileScreensMdomNotificationsScreenRu._(_root);
	late final _TranslationsMobileScreensMdomAccountAddRu mdomAccountAdd = _TranslationsMobileScreensMdomAccountAddRu._(_root);
	late final _TranslationsMobileScreensMdomCompanyChoiseRu mdomCompanyChoise = _TranslationsMobileScreensMdomCompanyChoiseRu._(_root);
	late final _TranslationsMobileScreensMdomCompanySearchRu mdomCompanySearch = _TranslationsMobileScreensMdomCompanySearchRu._(_root);
	late final _TranslationsMobileScreensMdomAccountInfoRu mdomAccountInfo = _TranslationsMobileScreensMdomAccountInfoRu._(_root);
	late final _TranslationsMobileScreensMdomAccountPaymentInfoRu mdomAccountPaymentInfo = _TranslationsMobileScreensMdomAccountPaymentInfoRu._(_root);
	late final _TranslationsMobileScreensMdomServiceInfoRu mdomServiceInfo = _TranslationsMobileScreensMdomServiceInfoRu._(_root);
	late final _TranslationsMobileScreensMdomPediodRu mdomPediod = _TranslationsMobileScreensMdomPediodRu._(_root);
	late final _TranslationsMobileScreensMdomPeriodCustomRu mdomPeriodCustom = _TranslationsMobileScreensMdomPeriodCustomRu._(_root);
	late final _TranslationsMobileScreensSelectLanguageRu selectLanguage = _TranslationsMobileScreensSelectLanguageRu._(_root);
	late final _TranslationsMobileScreensMdomPollsListRu mdomPollsList = _TranslationsMobileScreensMdomPollsListRu._(_root);
	late final _TranslationsMobileScreensMdomPollsListFiltersRu mdomPollsListFilters = _TranslationsMobileScreensMdomPollsListFiltersRu._(_root);
	late final _TranslationsMobileScreensMdomPollRu mdomPoll = _TranslationsMobileScreensMdomPollRu._(_root);
	late final _TranslationsMobileScreensMdomPollStatisticsRu mdomPollStatistics = _TranslationsMobileScreensMdomPollStatisticsRu._(_root);
	late final _TranslationsMobileScreensMdomPollStatisticsQuestionRu mdomPollStatisticsQuestion = _TranslationsMobileScreensMdomPollStatisticsQuestionRu._(_root);
}

// Path: models
class _TranslationsModelsRu {
	_TranslationsModelsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsModelsParamTypeRu paramType = _TranslationsModelsParamTypeRu._(_root);
	late final _TranslationsModelsPeriodRu period = _TranslationsModelsPeriodRu._(_root);
	late final _TranslationsModelsPollStatusRu pollStatus = _TranslationsModelsPollStatusRu._(_root);
	late final _TranslationsModelsPollAnswerRu pollAnswer = _TranslationsModelsPollAnswerRu._(_root);
}

// Path: widgets
class _TranslationsWidgetsRu {
	_TranslationsWidgetsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsWidgetsRefreshHeaderRu refreshHeader = _TranslationsWidgetsRefreshHeaderRu._(_root);
	late final _TranslationsWidgetsRefreshFooterRu refreshFooter = _TranslationsWidgetsRefreshFooterRu._(_root);
	late final _TranslationsWidgetsEmailFieldRu emailField = _TranslationsWidgetsEmailFieldRu._(_root);
	late final _TranslationsWidgetsFioFieldRu fioField = _TranslationsWidgetsFioFieldRu._(_root);
	late final _TranslationsWidgetsPasswordFieldRu passwordField = _TranslationsWidgetsPasswordFieldRu._(_root);
}

// Path: modal
class _TranslationsModalRu {
	_TranslationsModalRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsModalPinSetupRu pinSetup = _TranslationsModalPinSetupRu._(_root);
	late final _TranslationsModalPinVerifyRu pinVerify = _TranslationsModalPinVerifyRu._(_root);
	late final _TranslationsModalBiometricSetupRu biometricSetup = _TranslationsModalBiometricSetupRu._(_root);
	late final _TranslationsModalDecisionMessageRu decisionMessage = _TranslationsModalDecisionMessageRu._(_root);
	late final _TranslationsModalLogOutRu logOut = _TranslationsModalLogOutRu._(_root);
}

// Path: general
class _TranslationsGeneralRu {
	_TranslationsGeneralRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsGeneralErrorModalRu errorModal = _TranslationsGeneralErrorModalRu._(_root);
}

// Path: exceptions
class _TranslationsExceptionsRu {
	_TranslationsExceptionsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get emtyOrganizationsList => 'Добавьте счет';
	String get network => 'Не удалось связаться с серверами';
	late final _TranslationsExceptionsChangePasswordBlocRu changePasswordBloc = _TranslationsExceptionsChangePasswordBlocRu._(_root);
	late final _TranslationsExceptionsPaymentBlocRu paymentBloc = _TranslationsExceptionsPaymentBlocRu._(_root);
	late final _TranslationsExceptionsQrEripRu qrErip = _TranslationsExceptionsQrEripRu._(_root);
	String get onlyIndividuals => 'Данный кабинет предназначен для физ. лиц';
}

// Path: mobileScreens.splash
class _TranslationsMobileScreensSplashRu {
	_TranslationsMobileScreensSplashRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get loadingMessage => 'Пожалуйста, подождите';
	String get repeatButton => 'Повторить';
	String get errorMessage => 'Ошибка';
}

// Path: mobileScreens.auth
class _TranslationsMobileScreensAuthRu {
	_TranslationsMobileScreensAuthRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Вход';
	String get forgotPassword => 'Забыли пароль?';
	String get authButton => 'Войти';
	String get registrationButton => 'Зарегистрироваться';
}

// Path: mobileScreens.authPasswordReset
class _TranslationsMobileScreensAuthPasswordResetRu {
	_TranslationsMobileScreensAuthPasswordResetRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Смена пароля';
	String get resetButton => 'Сменить';
	String get login => 'Логин';
	String get loginHint => 'Ваш логин';
	String get success => 'Успешно';
	String get message => 'Новый пароль выслан на почту';
	late final _TranslationsMobileScreensAuthPasswordResetErrorsRu errors = _TranslationsMobileScreensAuthPasswordResetErrorsRu._(_root);
}

// Path: mobileScreens.registration
class _TranslationsMobileScreensRegistrationRu {
	_TranslationsMobileScreensRegistrationRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Регистрация';
	late final _TranslationsMobileScreensRegistrationPasswordRepeatFieldRu passwordRepeatField = _TranslationsMobileScreensRegistrationPasswordRepeatFieldRu._(_root);
	late final _TranslationsMobileScreensRegistrationSmsSwitchRu smsSwitch = _TranslationsMobileScreensRegistrationSmsSwitchRu._(_root);
	late final _TranslationsMobileScreensRegistrationPhoneFieldRu phoneField = _TranslationsMobileScreensRegistrationPhoneFieldRu._(_root);
	String get applyButton => 'Продолжить';
}

// Path: mobileScreens.registrationCode
class _TranslationsMobileScreensRegistrationCodeRu {
	_TranslationsMobileScreensRegistrationCodeRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Регистрация';
	late final _TranslationsMobileScreensRegistrationCodeCodeFieldRu codeField = _TranslationsMobileScreensRegistrationCodeCodeFieldRu._(_root);
	String get applyButton => 'Зарегистрироваться';
}

// Path: mobileScreens.registrationParams
class _TranslationsMobileScreensRegistrationParamsRu {
	_TranslationsMobileScreensRegistrationParamsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Регистрация';
	String get applyButton => 'Продолжить';
	late final _TranslationsMobileScreensRegistrationParamsParamDateFieldRu paramDateField = _TranslationsMobileScreensRegistrationParamsParamDateFieldRu._(_root);
	late final _TranslationsMobileScreensRegistrationParamsParamFieldRu paramField = _TranslationsMobileScreensRegistrationParamsParamFieldRu._(_root);
}

// Path: mobileScreens.registrationSuccess
class _TranslationsMobileScreensRegistrationSuccessRu {
	_TranslationsMobileScreensRegistrationSuccessRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Готово!';
	String get message => 'Вы успешно прошли регистрацию';
	String get pinSetupDescription => 'Необходимо настроить функцию быстрого входа с помощью Passcode';
	String get setPinButton => 'Настроить';
}

// Path: mobileScreens.main
class _TranslationsMobileScreensMainRu {
	_TranslationsMobileScreensMainRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensMainMenuRu menu = _TranslationsMobileScreensMainMenuRu._(_root);
}

// Path: mobileScreens.paymentsHistory
class _TranslationsMobileScreensPaymentsHistoryRu {
	_TranslationsMobileScreensPaymentsHistoryRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'История';
	String get filterButton => 'Открыть фильтр';
	String get noMoreDataMessage => 'Платежей больше нет';
	String get emptyDataMessage => 'Список пуст.\nВоспользуйтесь фильтром';
}

// Path: mobileScreens.qrPayment
class _TranslationsMobileScreensQrPaymentRu {
	_TranslationsMobileScreensQrPaymentRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get generateQrButton => 'Получить QR';
	String get updateQrButton => 'Обновить QR';
	String get confirmOrderBySMS => 'Подтвердить СМС';
	String get paymentDialogTitle => 'QR оплата';
	String get historyDialogTitle => 'QR операция';
	String get historyDialogMessage => 'Платёж отменён';
}

// Path: mobileScreens.paymentsHistoryFilters
class _TranslationsMobileScreensPaymentsHistoryFiltersRu {
	_TranslationsMobileScreensPaymentsHistoryFiltersRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Фильтр';
	String get resetButton => 'Сбросить';
	String get periodTitle => 'Период';
	late final _TranslationsMobileScreensPaymentsHistoryFiltersDateFromFieldRu dateFromField = _TranslationsMobileScreensPaymentsHistoryFiltersDateFromFieldRu._(_root);
	late final _TranslationsMobileScreensPaymentsHistoryFiltersDateToFieldRu dateToField = _TranslationsMobileScreensPaymentsHistoryFiltersDateToFieldRu._(_root);
	String get productsTitle => 'Счета и карты';
	String get applyButton => 'Применить';
}

// Path: mobileScreens.payment
class _TranslationsMobileScreensPaymentRu {
	_TranslationsMobileScreensPaymentRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Платежи';
	String get sumText => 'К оплате';
	String get payButtonTitle => 'Операция отклонена';
	String get payButtonMessage => 'В данное время функционал недоступен';
	String get emty => 'Список пуст';
	String get details => 'Детализация платежа';
	String get requirmentNumber => 'Номер требования';
	String get errorMessage => 'Ошибка';
	late final _TranslationsMobileScreensPaymentModalRu modal = _TranslationsMobileScreensPaymentModalRu._(_root);
	late final _TranslationsMobileScreensPaymentFieldsPageRu fieldsPage = _TranslationsMobileScreensPaymentFieldsPageRu._(_root);
	late final _TranslationsMobileScreensPaymentServiceResultPageRu serviceResultPage = _TranslationsMobileScreensPaymentServiceResultPageRu._(_root);
	late final _TranslationsMobileScreensPaymentAttrDateRu attrDate = _TranslationsMobileScreensPaymentAttrDateRu._(_root);
}

// Path: mobileScreens.products
class _TranslationsMobileScreensProductsRu {
	_TranslationsMobileScreensProductsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Счета и карты';
	String get addButton => 'Добавить';
	late final _TranslationsMobileScreensProductsMainProductTitleRu mainProductTitle = _TranslationsMobileScreensProductsMainProductTitleRu._(_root);
	late final _TranslationsMobileScreensProductsProductsSegmentControlTitleRu productsSegmentControlTitle = _TranslationsMobileScreensProductsProductsSegmentControlTitleRu._(_root);
}

// Path: mobileScreens.productAdd
class _TranslationsMobileScreensProductAddRu {
	_TranslationsMobileScreensProductAddRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Добавить';
	late final _TranslationsMobileScreensProductAddModalRu modal = _TranslationsMobileScreensProductAddModalRu._(_root);
	late final _TranslationsMobileScreensProductAddProductSelectorRu productSelector = _TranslationsMobileScreensProductAddProductSelectorRu._(_root);
	late final _TranslationsMobileScreensProductAddAccountFormRu accountForm = _TranslationsMobileScreensProductAddAccountFormRu._(_root);
	late final _TranslationsMobileScreensProductAddCardFormRu cardForm = _TranslationsMobileScreensProductAddCardFormRu._(_root);
	late final _TranslationsMobileScreensProductAddParamDateRu paramDate = _TranslationsMobileScreensProductAddParamDateRu._(_root);
}

// Path: mobileScreens.cardInfo
class _TranslationsMobileScreensCardInfoRu {
	_TranslationsMobileScreensCardInfoRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Редактирование карты';
	String get buttonTitle => 'Сохранить';
	late final _TranslationsMobileScreensCardInfoPropertiesRu properties = _TranslationsMobileScreensCardInfoPropertiesRu._(_root);
	late final _TranslationsMobileScreensCardInfoModalRu modal = _TranslationsMobileScreensCardInfoModalRu._(_root);
	late final _TranslationsMobileScreensCardInfoEditNameRu editName = _TranslationsMobileScreensCardInfoEditNameRu._(_root);
	String get makeMainButton => 'Сделать основным';
	String get deleteButton => 'Удалить';
}

// Path: mobileScreens.accountInfo
class _TranslationsMobileScreensAccountInfoRu {
	_TranslationsMobileScreensAccountInfoRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Редактирование счёта';
	String get buttonTitle => 'Сохранить';
	late final _TranslationsMobileScreensAccountInfoPropertiesRu properties = _TranslationsMobileScreensAccountInfoPropertiesRu._(_root);
	late final _TranslationsMobileScreensAccountInfoModalRu modal = _TranslationsMobileScreensAccountInfoModalRu._(_root);
	late final _TranslationsMobileScreensAccountInfoEditNameRu editName = _TranslationsMobileScreensAccountInfoEditNameRu._(_root);
	String get makeMainButton => 'Сделать основным';
	String get deleteButton => 'Удалить';
}

// Path: mobileScreens.profile
class _TranslationsMobileScreensProfileRu {
	_TranslationsMobileScreensProfileRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Профиль';
	String get editButton => 'Редактирование';
	late final _TranslationsMobileScreensProfileSettingsItemRu settingsItem = _TranslationsMobileScreensProfileSettingsItemRu._(_root);
	late final _TranslationsMobileScreensProfileLogOutItemRu logOutItem = _TranslationsMobileScreensProfileLogOutItemRu._(_root);
}

// Path: mobileScreens.profileEdit
class _TranslationsMobileScreensProfileEditRu {
	_TranslationsMobileScreensProfileEditRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Редактирование';
	late final _TranslationsMobileScreensProfileEditModalRu modal = _TranslationsMobileScreensProfileEditModalRu._(_root);
	late final _TranslationsMobileScreensProfileEditParamFieldRu paramField = _TranslationsMobileScreensProfileEditParamFieldRu._(_root);
	String get saveButton => 'Готово';
}

// Path: mobileScreens.settings
class _TranslationsMobileScreensSettingsRu {
	_TranslationsMobileScreensSettingsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Настройки';
	late final _TranslationsMobileScreensSettingsModalRu modal = _TranslationsMobileScreensSettingsModalRu._(_root);
	late final _TranslationsMobileScreensSettingsSectionsRu sections = _TranslationsMobileScreensSettingsSectionsRu._(_root);
	late final _TranslationsMobileScreensSettingsAuthWithBiometricsItemRu authWithBiometricsItem = _TranslationsMobileScreensSettingsAuthWithBiometricsItemRu._(_root);
}

// Path: mobileScreens.changePassword
class _TranslationsMobileScreensChangePasswordRu {
	_TranslationsMobileScreensChangePasswordRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Изменить пароль';
	String get saveButton => 'Изменить';
	String get loadingTitle => 'Пожалуйста, подождите';
	late final _TranslationsMobileScreensChangePasswordOldPasswordFieldRu oldPasswordField = _TranslationsMobileScreensChangePasswordOldPasswordFieldRu._(_root);
	late final _TranslationsMobileScreensChangePasswordNewPasswordFieldRu newPasswordField = _TranslationsMobileScreensChangePasswordNewPasswordFieldRu._(_root);
	late final _TranslationsMobileScreensChangePasswordNewPasswordRepeatFieldRu newPasswordRepeatField = _TranslationsMobileScreensChangePasswordNewPasswordRepeatFieldRu._(_root);
}

// Path: mobileScreens.qrScan
class _TranslationsMobileScreensQrScanRu {
	_TranslationsMobileScreensQrScanRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensQrScanFlashButtonRu flashButton = _TranslationsMobileScreensQrScanFlashButtonRu._(_root);
	late final _TranslationsMobileScreensQrScanModalRu modal = _TranslationsMobileScreensQrScanModalRu._(_root);
	late final _TranslationsMobileScreensQrScanQrCamRu qrCam = _TranslationsMobileScreensQrScanQrCamRu._(_root);
}

// Path: mobileScreens.mdomAccruals
class _TranslationsMobileScreensMdomAccrualsRu {
	_TranslationsMobileScreensMdomAccrualsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Организации';
	String get addButton => '+ Добавить cчет';
	late final _TranslationsMobileScreensMdomAccrualsAccountItemRu accountItem = _TranslationsMobileScreensMdomAccrualsAccountItemRu._(_root);
	late final _TranslationsMobileScreensMdomAccrualsPollItemRu pollItem = _TranslationsMobileScreensMdomAccrualsPollItemRu._(_root);
}

// Path: mobileScreens.mdomNotificationsScreen
class _TranslationsMobileScreensMdomNotificationsScreenRu {
	_TranslationsMobileScreensMdomNotificationsScreenRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Уведомления';
	String get readAllButton => 'Прочесть всё';
	String get readButton => 'Новое';
	late final _TranslationsMobileScreensMdomNotificationsScreenSuccessModalRu successModal = _TranslationsMobileScreensMdomNotificationsScreenSuccessModalRu._(_root);
	String get loadMore => 'Загрузить ещё';
	String get notificationsListEmpty => 'Список уведомлений пуст';
}

// Path: mobileScreens.mdomAccountAdd
class _TranslationsMobileScreensMdomAccountAddRu {
	_TranslationsMobileScreensMdomAccountAddRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Добавление счета';
	late final _TranslationsMobileScreensMdomAccountAddSuccessModalRu successModal = _TranslationsMobileScreensMdomAccountAddSuccessModalRu._(_root);
	String get addButton => 'Добавить';
	late final _TranslationsMobileScreensMdomAccountAddAccountNumberFieldRu accountNumberField = _TranslationsMobileScreensMdomAccountAddAccountNumberFieldRu._(_root);
	late final _TranslationsMobileScreensMdomAccountAddCodeWordFieldRu codeWordField = _TranslationsMobileScreensMdomAccountAddCodeWordFieldRu._(_root);
	late final _TranslationsMobileScreensMdomAccountAddSupplierIdFieldRu supplierIdField = _TranslationsMobileScreensMdomAccountAddSupplierIdFieldRu._(_root);
}

// Path: mobileScreens.mdomCompanyChoise
class _TranslationsMobileScreensMdomCompanyChoiseRu {
	_TranslationsMobileScreensMdomCompanyChoiseRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Выбор организации';
	late final _TranslationsMobileScreensMdomCompanyChoiseSearchFieldRu searchField = _TranslationsMobileScreensMdomCompanyChoiseSearchFieldRu._(_root);
	String get selectButton => 'Выбрать';
}

// Path: mobileScreens.mdomCompanySearch
class _TranslationsMobileScreensMdomCompanySearchRu {
	_TranslationsMobileScreensMdomCompanySearchRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Поиск организации';
	late final _TranslationsMobileScreensMdomCompanySearchSearchFieldRu searchField = _TranslationsMobileScreensMdomCompanySearchSearchFieldRu._(_root);
	late final _TranslationsMobileScreensMdomCompanySearchUnpFieldRu unpField = _TranslationsMobileScreensMdomCompanySearchUnpFieldRu._(_root);
	late final _TranslationsMobileScreensMdomCompanySearchNameFieldRu nameField = _TranslationsMobileScreensMdomCompanySearchNameFieldRu._(_root);
	late final _TranslationsMobileScreensMdomCompanySearchErrorsRu errors = _TranslationsMobileScreensMdomCompanySearchErrorsRu._(_root);
	String get selectButton => 'Выбрать';
}

// Path: mobileScreens.mdomAccountInfo
class _TranslationsMobileScreensMdomAccountInfoRu {
	_TranslationsMobileScreensMdomAccountInfoRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get tilte => 'Выписка по счету';
	late final _TranslationsMobileScreensMdomAccountInfoPeriodSectionRu periodSection = _TranslationsMobileScreensMdomAccountInfoPeriodSectionRu._(_root);
	late final _TranslationsMobileScreensMdomAccountInfoChargingSectionRu chargingSection = _TranslationsMobileScreensMdomAccountInfoChargingSectionRu._(_root);
	late final _TranslationsMobileScreensMdomAccountInfoPaySectionRu paySection = _TranslationsMobileScreensMdomAccountInfoPaySectionRu._(_root);
	late final _TranslationsMobileScreensMdomAccountInfoChargingSectionInfoRu chargingSectionInfo = _TranslationsMobileScreensMdomAccountInfoChargingSectionInfoRu._(_root);
	late final _TranslationsMobileScreensMdomAccountInfoServiceSectionRu serviceSection = _TranslationsMobileScreensMdomAccountInfoServiceSectionRu._(_root);
	late final _TranslationsMobileScreensMdomAccountInfoServiceSectionInfoRu serviceSectionInfo = _TranslationsMobileScreensMdomAccountInfoServiceSectionInfoRu._(_root);
	late final _TranslationsMobileScreensMdomAccountInfoRequirementsInfoRu requirementsInfo = _TranslationsMobileScreensMdomAccountInfoRequirementsInfoRu._(_root);
	late final _TranslationsMobileScreensMdomAccountInfoPayButtonRu payButton = _TranslationsMobileScreensMdomAccountInfoPayButtonRu._(_root);
	String payInfo({required Object amount, required Object currency}) => 'К оплате ${amount} ${currency}';
}

// Path: mobileScreens.mdomAccountPaymentInfo
class _TranslationsMobileScreensMdomAccountPaymentInfoRu {
	_TranslationsMobileScreensMdomAccountPaymentInfoRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get paymentDate => 'Дата платежа';
	String get paymentCode => 'Код платежа';
	String get sum => 'Сумма';
	String get description => 'Описание';
}

// Path: mobileScreens.mdomServiceInfo
class _TranslationsMobileScreensMdomServiceInfoRu {
	_TranslationsMobileScreensMdomServiceInfoRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get doneButton => 'Готово';
}

// Path: mobileScreens.mdomPediod
class _TranslationsMobileScreensMdomPediodRu {
	_TranslationsMobileScreensMdomPediodRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Период';
	String get doneButton => 'Выбрать';
}

// Path: mobileScreens.mdomPeriodCustom
class _TranslationsMobileScreensMdomPeriodCustomRu {
	_TranslationsMobileScreensMdomPeriodCustomRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Выбрать период';
	late final _TranslationsMobileScreensMdomPeriodCustomDateFieldRu dateField = _TranslationsMobileScreensMdomPeriodCustomDateFieldRu._(_root);
	late final _TranslationsMobileScreensMdomPeriodCustomDateFromFieldRu dateFromField = _TranslationsMobileScreensMdomPeriodCustomDateFromFieldRu._(_root);
	late final _TranslationsMobileScreensMdomPeriodCustomDateToFieldRu dateToField = _TranslationsMobileScreensMdomPeriodCustomDateToFieldRu._(_root);
	String get doneButton => 'Выбрать';
}

// Path: mobileScreens.selectLanguage
class _TranslationsMobileScreensSelectLanguageRu {
	_TranslationsMobileScreensSelectLanguageRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Выберите язык';
	String get currentLanguageLabel => 'Текущий';
}

// Path: mobileScreens.mdomPollsList
class _TranslationsMobileScreensMdomPollsListRu {
	_TranslationsMobileScreensMdomPollsListRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Голосования';
	String get filtersButton => 'Фильтр';
	late final _TranslationsMobileScreensMdomPollsListCurrentStatusRu currentStatus = _TranslationsMobileScreensMdomPollsListCurrentStatusRu._(_root);
	String get emptyDataMessage => 'Список пуст.\nВоспользуйтесь фильтром';
	String get noMoreDataMessage => 'Голосований больше нет.';
	late final _TranslationsMobileScreensMdomPollsListPollItemRu pollItem = _TranslationsMobileScreensMdomPollsListPollItemRu._(_root);
}

// Path: mobileScreens.mdomPollsListFilters
class _TranslationsMobileScreensMdomPollsListFiltersRu {
	_TranslationsMobileScreensMdomPollsListFiltersRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Голосования';
	String get cancelButton => 'Отмена';
	String get resetButton => 'Сбросить';
	late final _TranslationsMobileScreensMdomPollsListFiltersStatusPickerRu statusPicker = _TranslationsMobileScreensMdomPollsListFiltersStatusPickerRu._(_root);
	late final _TranslationsMobileScreensMdomPollsListFiltersEndDateRangePickerRu endDateRangePicker = _TranslationsMobileScreensMdomPollsListFiltersEndDateRangePickerRu._(_root);
	String get applyButton => 'Применить';
}

// Path: mobileScreens.mdomPoll
class _TranslationsMobileScreensMdomPollRu {
	_TranslationsMobileScreensMdomPollRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensMdomPollTitleRu title = _TranslationsMobileScreensMdomPollTitleRu._(_root);
	late final _TranslationsMobileScreensMdomPollModalRu modal = _TranslationsMobileScreensMdomPollModalRu._(_root);
	String get linkItem => 'Подробная информация';
	late final _TranslationsMobileScreensMdomPollInfoRu info = _TranslationsMobileScreensMdomPollInfoRu._(_root);
	late final _TranslationsMobileScreensMdomPollQuestionsListRu questionsList = _TranslationsMobileScreensMdomPollQuestionsListRu._(_root);
	late final _TranslationsMobileScreensMdomPollVoteButtonRu voteButton = _TranslationsMobileScreensMdomPollVoteButtonRu._(_root);
	String get editButton => 'Изменить ответы';
	String get pollsStatButtonNoOneVoted => 'Никто не проголосовал';
	String get pollsStatButtonNoOneVotedYeat => 'Ёще никто не проголосовал';
	String pollStatButton({required num count}) => (_root._cardinalResolver ?? PluralResolvers.cardinal('ru'))(count,
		one: 'Проголосовал ${count} человек',
		few: 'Проголосовало ${count} человека',
		other: 'Проголосовало ${count} человек',
	);
}

// Path: mobileScreens.mdomPollStatistics
class _TranslationsMobileScreensMdomPollStatisticsRu {
	_TranslationsMobileScreensMdomPollStatisticsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Вопросы';
	String get votedText => 'Проголосовало';
	String get participantsText => 'Все участники';
}

// Path: mobileScreens.mdomPollStatisticsQuestion
class _TranslationsMobileScreensMdomPollStatisticsQuestionRu {
	_TranslationsMobileScreensMdomPollStatisticsQuestionRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get votedText => 'Всего проголосовало';
	String get errorMessage => 'Ошибка';
	late final _TranslationsMobileScreensMdomPollStatisticsQuestionAnswersTitleRu answersTitle = _TranslationsMobileScreensMdomPollStatisticsQuestionAnswersTitleRu._(_root);
}

// Path: models.paramType
class _TranslationsModelsParamTypeRu {
	_TranslationsModelsParamTypeRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get error => 'Некорректное значение';
}

// Path: models.period
class _TranslationsModelsPeriodRu {
	_TranslationsModelsPeriodRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Лицевой счет';
	late final _TranslationsModelsPeriodNamesRu names = _TranslationsModelsPeriodNamesRu._(_root);
	late final _TranslationsModelsPeriodSelectedNamesRu selectedNames = _TranslationsModelsPeriodSelectedNamesRu._(_root);
}

// Path: models.pollStatus
class _TranslationsModelsPollStatusRu {
	_TranslationsModelsPollStatusRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get all => 'Все';
	String get publication => 'Публикация';
	String get inProgress => 'Идет голосование';
	String get completed => 'Завершено';
}

// Path: models.pollAnswer
class _TranslationsModelsPollAnswerRu {
	_TranslationsModelsPollAnswerRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsModelsPollAnswerActiveRu active = _TranslationsModelsPollAnswerActiveRu._(_root);
	late final _TranslationsModelsPollAnswerVotedRu voted = _TranslationsModelsPollAnswerVotedRu._(_root);
}

// Path: widgets.refreshHeader
class _TranslationsWidgetsRefreshHeaderRu {
	_TranslationsWidgetsRefreshHeaderRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get idle => 'Потяните вниз, чтобы обновить';
}

// Path: widgets.refreshFooter
class _TranslationsWidgetsRefreshFooterRu {
	_TranslationsWidgetsRefreshFooterRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsWidgetsRefreshFooterStatusesRu statuses = _TranslationsWidgetsRefreshFooterStatusesRu._(_root);
}

// Path: widgets.emailField
class _TranslationsWidgetsEmailFieldRu {
	_TranslationsWidgetsEmailFieldRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsWidgetsEmailFieldErrorsRu errors = _TranslationsWidgetsEmailFieldErrorsRu._(_root);
}

// Path: widgets.fioField
class _TranslationsWidgetsFioFieldRu {
	_TranslationsWidgetsFioFieldRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsWidgetsFioFieldErrorsRu errors = _TranslationsWidgetsFioFieldErrorsRu._(_root);
}

// Path: widgets.passwordField
class _TranslationsWidgetsPasswordFieldRu {
	_TranslationsWidgetsPasswordFieldRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Пароль';
	late final _TranslationsWidgetsPasswordFieldErrorsRu errors = _TranslationsWidgetsPasswordFieldErrorsRu._(_root);
}

// Path: modal.pinSetup
class _TranslationsModalPinSetupRu {
	_TranslationsModalPinSetupRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsModalPinSetupTitleRu title = _TranslationsModalPinSetupTitleRu._(_root);
	String get cancelButton => 'Отмена';
	String get localizedReason => 'Авторизация в приложении';
}

// Path: modal.pinVerify
class _TranslationsModalPinVerifyRu {
	_TranslationsModalPinVerifyRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Введите PIN';
	String get cancelButton => 'Отмена';
	String get biometricReason => 'Авторизация в приложении';
}

// Path: modal.biometricSetup
class _TranslationsModalBiometricSetupRu {
	_TranslationsModalBiometricSetupRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get biometricDescription => 'биометрию';
	String title({required Object biometricDescription}) => 'Использовать ${biometricDescription} для входа в приложение?';
	String get confirmButton => 'Да';
	String get cancelButton => 'Нет';
}

// Path: modal.decisionMessage
class _TranslationsModalDecisionMessageRu {
	_TranslationsModalDecisionMessageRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Внимание';
	String get confirmButton => 'Ок';
	String get cancelButton => 'Отмена';
}

// Path: modal.logOut
class _TranslationsModalLogOutRu {
	_TranslationsModalLogOutRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Уверены, что хотите выйти?';
	String get message => 'Ваши авторизованные данные будут удалены с устройства';
	String get confirmButton => 'Выйти';
	String get cancelButton => 'Остаться';
}

// Path: general.errorModal
class _TranslationsGeneralErrorModalRu {
	_TranslationsGeneralErrorModalRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Ошибка';
}

// Path: exceptions.changePasswordBloc
class _TranslationsExceptionsChangePasswordBlocRu {
	_TranslationsExceptionsChangePasswordBlocRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get wrongOldPassword => 'Неверный старый пароль';
}

// Path: exceptions.paymentBloc
class _TranslationsExceptionsPaymentBlocRu {
	_TranslationsExceptionsPaymentBlocRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get unknownService => 'Не удалось получить информацию об услуге';
}

// Path: exceptions.qrErip
class _TranslationsExceptionsQrEripRu {
	_TranslationsExceptionsQrEripRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get verifyCheckSum => 'Неверная контрольная суммая';
}

// Path: mobileScreens.authPasswordReset.errors
class _TranslationsMobileScreensAuthPasswordResetErrorsRu {
	_TranslationsMobileScreensAuthPasswordResetErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get empty => 'Поле обязательно для заполнения';
}

// Path: mobileScreens.registration.passwordRepeatField
class _TranslationsMobileScreensRegistrationPasswordRepeatFieldRu {
	_TranslationsMobileScreensRegistrationPasswordRepeatFieldRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Повторите пароль';
	late final _TranslationsMobileScreensRegistrationPasswordRepeatFieldErrorsRu errors = _TranslationsMobileScreensRegistrationPasswordRepeatFieldErrorsRu._(_root);
}

// Path: mobileScreens.registration.smsSwitch
class _TranslationsMobileScreensRegistrationSmsSwitchRu {
	_TranslationsMobileScreensRegistrationSmsSwitchRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get tilte => 'Отправить код подтверждения по SMS';
}

// Path: mobileScreens.registration.phoneField
class _TranslationsMobileScreensRegistrationPhoneFieldRu {
	_TranslationsMobileScreensRegistrationPhoneFieldRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Номер телефона';
	late final _TranslationsMobileScreensRegistrationPhoneFieldErrorsRu errors = _TranslationsMobileScreensRegistrationPhoneFieldErrorsRu._(_root);
}

// Path: mobileScreens.registrationCode.codeField
class _TranslationsMobileScreensRegistrationCodeCodeFieldRu {
	_TranslationsMobileScreensRegistrationCodeCodeFieldRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensRegistrationCodeCodeFieldTitleRu title = _TranslationsMobileScreensRegistrationCodeCodeFieldTitleRu._(_root);
	late final _TranslationsMobileScreensRegistrationCodeCodeFieldErrorsRu errors = _TranslationsMobileScreensRegistrationCodeCodeFieldErrorsRu._(_root);
}

// Path: mobileScreens.registrationParams.paramDateField
class _TranslationsMobileScreensRegistrationParamsParamDateFieldRu {
	_TranslationsMobileScreensRegistrationParamsParamDateFieldRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensRegistrationParamsParamDateFieldErrorsRu errors = _TranslationsMobileScreensRegistrationParamsParamDateFieldErrorsRu._(_root);
}

// Path: mobileScreens.registrationParams.paramField
class _TranslationsMobileScreensRegistrationParamsParamFieldRu {
	_TranslationsMobileScreensRegistrationParamsParamFieldRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensRegistrationParamsParamFieldErrorsRu errors = _TranslationsMobileScreensRegistrationParamsParamFieldErrorsRu._(_root);
}

// Path: mobileScreens.main.menu
class _TranslationsMobileScreensMainMenuRu {
	_TranslationsMobileScreensMainMenuRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get history => 'История';
	String get userGuide => 'Справка';
	String get products => 'Продукты';
	String get accruals => 'Организации';
	String get claims => 'Требования';
	String get payments => 'Платежи';
	String get profile => 'Профиль';
	String get scanQr => 'Сканер';
	String get qrPayment => 'Мой QR';
}

// Path: mobileScreens.paymentsHistoryFilters.dateFromField
class _TranslationsMobileScreensPaymentsHistoryFiltersDateFromFieldRu {
	_TranslationsMobileScreensPaymentsHistoryFiltersDateFromFieldRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get tilte => 'c';
	late final _TranslationsMobileScreensPaymentsHistoryFiltersDateFromFieldErrorsRu errors = _TranslationsMobileScreensPaymentsHistoryFiltersDateFromFieldErrorsRu._(_root);
}

// Path: mobileScreens.paymentsHistoryFilters.dateToField
class _TranslationsMobileScreensPaymentsHistoryFiltersDateToFieldRu {
	_TranslationsMobileScreensPaymentsHistoryFiltersDateToFieldRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get tilte => 'по';
	late final _TranslationsMobileScreensPaymentsHistoryFiltersDateToFieldErrorsRu errors = _TranslationsMobileScreensPaymentsHistoryFiltersDateToFieldErrorsRu._(_root);
}

// Path: mobileScreens.payment.modal
class _TranslationsMobileScreensPaymentModalRu {
	_TranslationsMobileScreensPaymentModalRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensPaymentModalErrorRu error = _TranslationsMobileScreensPaymentModalErrorRu._(_root);
}

// Path: mobileScreens.payment.fieldsPage
class _TranslationsMobileScreensPaymentFieldsPageRu {
	_TranslationsMobileScreensPaymentFieldsPageRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensPaymentFieldsPageParamFieldRu paramField = _TranslationsMobileScreensPaymentFieldsPageParamFieldRu._(_root);
	String get nextButton => 'Далее';
}

// Path: mobileScreens.payment.serviceResultPage
class _TranslationsMobileScreensPaymentServiceResultPageRu {
	_TranslationsMobileScreensPaymentServiceResultPageRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get nextButton => 'Оплатить';
}

// Path: mobileScreens.payment.attrDate
class _TranslationsMobileScreensPaymentAttrDateRu {
	_TranslationsMobileScreensPaymentAttrDateRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensPaymentAttrDateErrorsRu errors = _TranslationsMobileScreensPaymentAttrDateErrorsRu._(_root);
}

// Path: mobileScreens.products.mainProductTitle
class _TranslationsMobileScreensProductsMainProductTitleRu {
	_TranslationsMobileScreensProductsMainProductTitleRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get account => 'Основной счет';
	String get card => 'Основная карта';
}

// Path: mobileScreens.products.productsSegmentControlTitle
class _TranslationsMobileScreensProductsProductsSegmentControlTitleRu {
	_TranslationsMobileScreensProductsProductsSegmentControlTitleRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get account => 'Счета';
	String get card => 'Карты';
}

// Path: mobileScreens.productAdd.modal
class _TranslationsMobileScreensProductAddModalRu {
	_TranslationsMobileScreensProductAddModalRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensProductAddModalSuccessRu success = _TranslationsMobileScreensProductAddModalSuccessRu._(_root);
}

// Path: mobileScreens.productAdd.productSelector
class _TranslationsMobileScreensProductAddProductSelectorRu {
	_TranslationsMobileScreensProductAddProductSelectorRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get account => 'Счет';
	String get card => 'Карту';
}

// Path: mobileScreens.productAdd.accountForm
class _TranslationsMobileScreensProductAddAccountFormRu {
	_TranslationsMobileScreensProductAddAccountFormRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensProductAddAccountFormAccountNumberFieldRu accountNumberField = _TranslationsMobileScreensProductAddAccountFormAccountNumberFieldRu._(_root);
	late final _TranslationsMobileScreensProductAddAccountFormParamFieldRu paramField = _TranslationsMobileScreensProductAddAccountFormParamFieldRu._(_root);
	String get addButton => 'Добавить счет';
}

// Path: mobileScreens.productAdd.cardForm
class _TranslationsMobileScreensProductAddCardFormRu {
	_TranslationsMobileScreensProductAddCardFormRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensProductAddCardFormCardNumberFieldRu cardNumberField = _TranslationsMobileScreensProductAddCardFormCardNumberFieldRu._(_root);
	late final _TranslationsMobileScreensProductAddCardFormExpiryFieldRu expiryField = _TranslationsMobileScreensProductAddCardFormExpiryFieldRu._(_root);
	late final _TranslationsMobileScreensProductAddCardFormCvvFieldRu cvvField = _TranslationsMobileScreensProductAddCardFormCvvFieldRu._(_root);
	late final _TranslationsMobileScreensProductAddCardFormParamFieldRu paramField = _TranslationsMobileScreensProductAddCardFormParamFieldRu._(_root);
	String get addButton => 'Добавить карту';
}

// Path: mobileScreens.productAdd.paramDate
class _TranslationsMobileScreensProductAddParamDateRu {
	_TranslationsMobileScreensProductAddParamDateRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensProductAddParamDateErrorsRu errors = _TranslationsMobileScreensProductAddParamDateErrorsRu._(_root);
}

// Path: mobileScreens.cardInfo.properties
class _TranslationsMobileScreensCardInfoPropertiesRu {
	_TranslationsMobileScreensCardInfoPropertiesRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get number => 'Номер карты';
	String get expirationDate => 'Срок действия';
}

// Path: mobileScreens.cardInfo.modal
class _TranslationsMobileScreensCardInfoModalRu {
	_TranslationsMobileScreensCardInfoModalRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensCardInfoModalDeleteProductRu deleteProduct = _TranslationsMobileScreensCardInfoModalDeleteProductRu._(_root);
	late final _TranslationsMobileScreensCardInfoModalSuccesProductDeleteRu succesProductDelete = _TranslationsMobileScreensCardInfoModalSuccesProductDeleteRu._(_root);
}

// Path: mobileScreens.cardInfo.editName
class _TranslationsMobileScreensCardInfoEditNameRu {
	_TranslationsMobileScreensCardInfoEditNameRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensCardInfoEditNameParamFieldRu paramField = _TranslationsMobileScreensCardInfoEditNameParamFieldRu._(_root);
	String get doneButton => 'Готово';
}

// Path: mobileScreens.accountInfo.properties
class _TranslationsMobileScreensAccountInfoPropertiesRu {
	_TranslationsMobileScreensAccountInfoPropertiesRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get number => 'Номер счета';
}

// Path: mobileScreens.accountInfo.modal
class _TranslationsMobileScreensAccountInfoModalRu {
	_TranslationsMobileScreensAccountInfoModalRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensAccountInfoModalDeleteProductRu deleteProduct = _TranslationsMobileScreensAccountInfoModalDeleteProductRu._(_root);
	late final _TranslationsMobileScreensAccountInfoModalSuccesProductDeleteRu succesProductDelete = _TranslationsMobileScreensAccountInfoModalSuccesProductDeleteRu._(_root);
}

// Path: mobileScreens.accountInfo.editName
class _TranslationsMobileScreensAccountInfoEditNameRu {
	_TranslationsMobileScreensAccountInfoEditNameRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensAccountInfoEditNameParamFieldRu paramField = _TranslationsMobileScreensAccountInfoEditNameParamFieldRu._(_root);
	String get doneButton => 'Готово';
}

// Path: mobileScreens.profile.settingsItem
class _TranslationsMobileScreensProfileSettingsItemRu {
	_TranslationsMobileScreensProfileSettingsItemRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Настройки';
}

// Path: mobileScreens.profile.logOutItem
class _TranslationsMobileScreensProfileLogOutItemRu {
	_TranslationsMobileScreensProfileLogOutItemRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Выход';
}

// Path: mobileScreens.profileEdit.modal
class _TranslationsMobileScreensProfileEditModalRu {
	_TranslationsMobileScreensProfileEditModalRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensProfileEditModalSuccessRu success = _TranslationsMobileScreensProfileEditModalSuccessRu._(_root);
}

// Path: mobileScreens.profileEdit.paramField
class _TranslationsMobileScreensProfileEditParamFieldRu {
	_TranslationsMobileScreensProfileEditParamFieldRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensProfileEditParamFieldErrorsRu errors = _TranslationsMobileScreensProfileEditParamFieldErrorsRu._(_root);
}

// Path: mobileScreens.settings.modal
class _TranslationsMobileScreensSettingsModalRu {
	_TranslationsMobileScreensSettingsModalRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensSettingsModalChangePinSuccessRu changePinSuccess = _TranslationsMobileScreensSettingsModalChangePinSuccessRu._(_root);
}

// Path: mobileScreens.settings.sections
class _TranslationsMobileScreensSettingsSectionsRu {
	_TranslationsMobileScreensSettingsSectionsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensSettingsSectionsAccessRu access = _TranslationsMobileScreensSettingsSectionsAccessRu._(_root);
	late final _TranslationsMobileScreensSettingsSectionsAccountRu account = _TranslationsMobileScreensSettingsSectionsAccountRu._(_root);
	late final _TranslationsMobileScreensSettingsSectionsDeleteAccountRu deleteAccount = _TranslationsMobileScreensSettingsSectionsDeleteAccountRu._(_root);
}

// Path: mobileScreens.settings.authWithBiometricsItem
class _TranslationsMobileScreensSettingsAuthWithBiometricsItemRu {
	_TranslationsMobileScreensSettingsAuthWithBiometricsItemRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get biometricDescription => 'биометрии';
	String message({required Object biometricDescription}) => 'Вход по ${biometricDescription}';
}

// Path: mobileScreens.changePassword.oldPasswordField
class _TranslationsMobileScreensChangePasswordOldPasswordFieldRu {
	_TranslationsMobileScreensChangePasswordOldPasswordFieldRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Старый пароль';
	late final _TranslationsMobileScreensChangePasswordOldPasswordFieldErrorsRu errors = _TranslationsMobileScreensChangePasswordOldPasswordFieldErrorsRu._(_root);
}

// Path: mobileScreens.changePassword.newPasswordField
class _TranslationsMobileScreensChangePasswordNewPasswordFieldRu {
	_TranslationsMobileScreensChangePasswordNewPasswordFieldRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Новый пароль';
	late final _TranslationsMobileScreensChangePasswordNewPasswordFieldErrorsRu errors = _TranslationsMobileScreensChangePasswordNewPasswordFieldErrorsRu._(_root);
}

// Path: mobileScreens.changePassword.newPasswordRepeatField
class _TranslationsMobileScreensChangePasswordNewPasswordRepeatFieldRu {
	_TranslationsMobileScreensChangePasswordNewPasswordRepeatFieldRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Подтвердите новый пароль';
	late final _TranslationsMobileScreensChangePasswordNewPasswordRepeatFieldErrorsRu errors = _TranslationsMobileScreensChangePasswordNewPasswordRepeatFieldErrorsRu._(_root);
}

// Path: mobileScreens.qrScan.flashButton
class _TranslationsMobileScreensQrScanFlashButtonRu {
	_TranslationsMobileScreensQrScanFlashButtonRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get turnOn => 'Включить вспышку';
	String get turnOff => 'Выключить вспышку';
}

// Path: mobileScreens.qrScan.modal
class _TranslationsMobileScreensQrScanModalRu {
	_TranslationsMobileScreensQrScanModalRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensQrScanModalErrorRu error = _TranslationsMobileScreensQrScanModalErrorRu._(_root);
}

// Path: mobileScreens.qrScan.qrCam
class _TranslationsMobileScreensQrScanQrCamRu {
	_TranslationsMobileScreensQrScanQrCamRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensQrScanQrCamPermissionsRu permissions = _TranslationsMobileScreensQrScanQrCamPermissionsRu._(_root);
	String get providePermissionButton => 'Предоставить разрешение';
	String get scanMessage => 'Наведите камеру на QR-код';
}

// Path: mobileScreens.mdomAccruals.accountItem
class _TranslationsMobileScreensMdomAccrualsAccountItemRu {
	_TranslationsMobileScreensMdomAccrualsAccountItemRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => '№ лицевого счета';
	String get underConsideration => 'На рассмотрении';
	String get waitingRegistration => 'Ожидает регистрации клиентом';
}

// Path: mobileScreens.mdomAccruals.pollItem
class _TranslationsMobileScreensMdomAccrualsPollItemRu {
	_TranslationsMobileScreensMdomAccrualsPollItemRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Голосования';
	String get newLabel => 'Новое';
}

// Path: mobileScreens.mdomNotificationsScreen.successModal
class _TranslationsMobileScreensMdomNotificationsScreenSuccessModalRu {
	_TranslationsMobileScreensMdomNotificationsScreenSuccessModalRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Прочитано';
}

// Path: mobileScreens.mdomAccountAdd.successModal
class _TranslationsMobileScreensMdomAccountAddSuccessModalRu {
	_TranslationsMobileScreensMdomAccountAddSuccessModalRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Успешно';
	String get text => 'Счёт добавлен';
}

// Path: mobileScreens.mdomAccountAdd.accountNumberField
class _TranslationsMobileScreensMdomAccountAddAccountNumberFieldRu {
	_TranslationsMobileScreensMdomAccountAddAccountNumberFieldRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Номер счета';
	late final _TranslationsMobileScreensMdomAccountAddAccountNumberFieldErrorsRu errors = _TranslationsMobileScreensMdomAccountAddAccountNumberFieldErrorsRu._(_root);
}

// Path: mobileScreens.mdomAccountAdd.codeWordField
class _TranslationsMobileScreensMdomAccountAddCodeWordFieldRu {
	_TranslationsMobileScreensMdomAccountAddCodeWordFieldRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Кодовое слово';
	late final _TranslationsMobileScreensMdomAccountAddCodeWordFieldErrorsRu errors = _TranslationsMobileScreensMdomAccountAddCodeWordFieldErrorsRu._(_root);
}

// Path: mobileScreens.mdomAccountAdd.supplierIdField
class _TranslationsMobileScreensMdomAccountAddSupplierIdFieldRu {
	_TranslationsMobileScreensMdomAccountAddSupplierIdFieldRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'ID организации';
	late final _TranslationsMobileScreensMdomAccountAddSupplierIdFieldErrorsRu errors = _TranslationsMobileScreensMdomAccountAddSupplierIdFieldErrorsRu._(_root);
}

// Path: mobileScreens.mdomCompanyChoise.searchField
class _TranslationsMobileScreensMdomCompanyChoiseSearchFieldRu {
	_TranslationsMobileScreensMdomCompanyChoiseSearchFieldRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get hint => 'Поиск';
}

// Path: mobileScreens.mdomCompanySearch.searchField
class _TranslationsMobileScreensMdomCompanySearchSearchFieldRu {
	_TranslationsMobileScreensMdomCompanySearchSearchFieldRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get hint => 'Поиск';
}

// Path: mobileScreens.mdomCompanySearch.unpField
class _TranslationsMobileScreensMdomCompanySearchUnpFieldRu {
	_TranslationsMobileScreensMdomCompanySearchUnpFieldRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'УНП';
	late final _TranslationsMobileScreensMdomCompanySearchUnpFieldErrorsRu errors = _TranslationsMobileScreensMdomCompanySearchUnpFieldErrorsRu._(_root);
}

// Path: mobileScreens.mdomCompanySearch.nameField
class _TranslationsMobileScreensMdomCompanySearchNameFieldRu {
	_TranslationsMobileScreensMdomCompanySearchNameFieldRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Наименование организации';
	late final _TranslationsMobileScreensMdomCompanySearchNameFieldErrorsRu errors = _TranslationsMobileScreensMdomCompanySearchNameFieldErrorsRu._(_root);
}

// Path: mobileScreens.mdomCompanySearch.errors
class _TranslationsMobileScreensMdomCompanySearchErrorsRu {
	_TranslationsMobileScreensMdomCompanySearchErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get empty => 'Организация не найдена';
}

// Path: mobileScreens.mdomAccountInfo.periodSection
class _TranslationsMobileScreensMdomAccountInfoPeriodSectionRu {
	_TranslationsMobileScreensMdomAccountInfoPeriodSectionRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get tilte => 'Период';
}

// Path: mobileScreens.mdomAccountInfo.chargingSection
class _TranslationsMobileScreensMdomAccountInfoChargingSectionRu {
	_TranslationsMobileScreensMdomAccountInfoChargingSectionRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get tilte => 'Статистика начислений';
}

// Path: mobileScreens.mdomAccountInfo.paySection
class _TranslationsMobileScreensMdomAccountInfoPaySectionRu {
	_TranslationsMobileScreensMdomAccountInfoPaySectionRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get tilte => 'Статистика по оплате';
}

// Path: mobileScreens.mdomAccountInfo.chargingSectionInfo
class _TranslationsMobileScreensMdomAccountInfoChargingSectionInfoRu {
	_TranslationsMobileScreensMdomAccountInfoChargingSectionInfoRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get remainder => 'Переходящий остаток';
	String get fine => 'Пеня';
	String get paid => 'Оплачено';
	String get total => 'Всего начислено';
}

// Path: mobileScreens.mdomAccountInfo.serviceSection
class _TranslationsMobileScreensMdomAccountInfoServiceSectionRu {
	_TranslationsMobileScreensMdomAccountInfoServiceSectionRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get tilte => 'Статистика по услугам';
	late final _TranslationsMobileScreensMdomAccountInfoServiceSectionItemRu item = _TranslationsMobileScreensMdomAccountInfoServiceSectionItemRu._(_root);
}

// Path: mobileScreens.mdomAccountInfo.serviceSectionInfo
class _TranslationsMobileScreensMdomAccountInfoServiceSectionInfoRu {
	_TranslationsMobileScreensMdomAccountInfoServiceSectionInfoRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensMdomAccountInfoServiceSectionInfoItemRu item = _TranslationsMobileScreensMdomAccountInfoServiceSectionInfoItemRu._(_root);
}

// Path: mobileScreens.mdomAccountInfo.requirementsInfo
class _TranslationsMobileScreensMdomAccountInfoRequirementsInfoRu {
	_TranslationsMobileScreensMdomAccountInfoRequirementsInfoRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get dateStart => 'Дата начала действия требования:';
	String get dateEnd => 'Дата окончания действия требования:';
	String get accrued => 'Общая сумма оплат по требованию:';
	String get total => 'Сумма к оплате:';
}

// Path: mobileScreens.mdomAccountInfo.payButton
class _TranslationsMobileScreensMdomAccountInfoPayButtonRu {
	_TranslationsMobileScreensMdomAccountInfoPayButtonRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get noPayments => 'Готово';
	String needPay({required Object amount, required Object currency}) => 'Оплатить ${amount} ${currency}';
	String noNeedPay({required Object amount, required Object currency}) => 'Переплата ${amount} ${currency}';
}

// Path: mobileScreens.mdomPeriodCustom.dateField
class _TranslationsMobileScreensMdomPeriodCustomDateFieldRu {
	_TranslationsMobileScreensMdomPeriodCustomDateFieldRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensMdomPeriodCustomDateFieldErrorsRu errors = _TranslationsMobileScreensMdomPeriodCustomDateFieldErrorsRu._(_root);
}

// Path: mobileScreens.mdomPeriodCustom.dateFromField
class _TranslationsMobileScreensMdomPeriodCustomDateFromFieldRu {
	_TranslationsMobileScreensMdomPeriodCustomDateFromFieldRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get tilte => 'Начало периода';
	String get hint => '01/01/2022';
	late final _TranslationsMobileScreensMdomPeriodCustomDateFromFieldErrorsRu errors = _TranslationsMobileScreensMdomPeriodCustomDateFromFieldErrorsRu._(_root);
}

// Path: mobileScreens.mdomPeriodCustom.dateToField
class _TranslationsMobileScreensMdomPeriodCustomDateToFieldRu {
	_TranslationsMobileScreensMdomPeriodCustomDateToFieldRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get tilte => 'Конец периода';
	String get hint => '01/02/2022';
	late final _TranslationsMobileScreensMdomPeriodCustomDateToFieldErrorsRu errors = _TranslationsMobileScreensMdomPeriodCustomDateToFieldErrorsRu._(_root);
}

// Path: mobileScreens.mdomPollsList.currentStatus
class _TranslationsMobileScreensMdomPollsListCurrentStatusRu {
	_TranslationsMobileScreensMdomPollsListCurrentStatusRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Статус';
}

// Path: mobileScreens.mdomPollsList.pollItem
class _TranslationsMobileScreensMdomPollsListPollItemRu {
	_TranslationsMobileScreensMdomPollsListPollItemRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensMdomPollsListPollItemVotedTextRu votedText = _TranslationsMobileScreensMdomPollsListPollItemVotedTextRu._(_root);
	String startText({required Object date}) => 'Начнется ${date}';
	String completedText({required Object date}) => 'Завершено ${date}';
	String get endingText => 'Окончание';
}

// Path: mobileScreens.mdomPollsListFilters.statusPicker
class _TranslationsMobileScreensMdomPollsListFiltersStatusPickerRu {
	_TranslationsMobileScreensMdomPollsListFiltersStatusPickerRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Статус';
}

// Path: mobileScreens.mdomPollsListFilters.endDateRangePicker
class _TranslationsMobileScreensMdomPollsListFiltersEndDateRangePickerRu {
	_TranslationsMobileScreensMdomPollsListFiltersEndDateRangePickerRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Окончание голосования';
	String get calendarModalTitle => 'Окончание голосования';
}

// Path: mobileScreens.mdomPoll.title
class _TranslationsMobileScreensMdomPollTitleRu {
	_TranslationsMobileScreensMdomPollTitleRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get expandText => 'показать';
	String get collapseText => 'свернуть';
}

// Path: mobileScreens.mdomPoll.modal
class _TranslationsMobileScreensMdomPollModalRu {
	_TranslationsMobileScreensMdomPollModalRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get successVote => 'Ваши ответы отправлены';
	String get successEdit => 'Ваши ответы обновлены';
}

// Path: mobileScreens.mdomPoll.info
class _TranslationsMobileScreensMdomPollInfoRu {
	_TranslationsMobileScreensMdomPollInfoRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get ending => 'Окончание';
}

// Path: mobileScreens.mdomPoll.questionsList
class _TranslationsMobileScreensMdomPollQuestionsListRu {
	_TranslationsMobileScreensMdomPollQuestionsListRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Вопросы';
	String get votedText => 'Вы проголосовали';
	String startText({required Object date}) => 'Начнется ${date}';
	String completedText({required Object date}) => 'Завершено ${date}';
}

// Path: mobileScreens.mdomPoll.voteButton
class _TranslationsMobileScreensMdomPollVoteButtonRu {
	_TranslationsMobileScreensMdomPollVoteButtonRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get vote => 'Проголосовать';
	String get edit => 'Сохранить';
}

// Path: mobileScreens.mdomPollStatisticsQuestion.answersTitle
class _TranslationsMobileScreensMdomPollStatisticsQuestionAnswersTitleRu {
	_TranslationsMobileScreensMdomPollStatisticsQuestionAnswersTitleRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get yes => 'Да';
	String get no => 'Нет';
	String get abstain => 'Воздержались';
}

// Path: models.period.names
class _TranslationsModelsPeriodNamesRu {
	_TranslationsModelsPeriodNamesRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get notSet => 'Неизвестно';
	String get month => 'Месяц';
	String get quarter => 'Квартал';
	String get year => 'Год';
	String get custom => 'Выбрать период';
}

// Path: models.period.selectedNames
class _TranslationsModelsPeriodSelectedNamesRu {
	_TranslationsModelsPeriodSelectedNamesRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get notSet => 'Выбрать период';
	String month({required Object month, required Object year}) => '${month} ${year}';
	String quarter({required Object quarter, required Object year}) => '${quarter} квартал ${year}';
	String year({required Object year}) => '${year} год';
	String custom({required Object startDate, required Object endDate}) => '${startDate} - ${endDate}';
}

// Path: models.pollAnswer.active
class _TranslationsModelsPollAnswerActiveRu {
	_TranslationsModelsPollAnswerActiveRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get yes => 'Да';
	String get no => 'Нет';
	String get abstain => 'Воздержаться';
}

// Path: models.pollAnswer.voted
class _TranslationsModelsPollAnswerVotedRu {
	_TranslationsModelsPollAnswerVotedRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get yes => 'Да';
	String get no => 'Нет';
	String get abstain => 'Воздерж.';
}

// Path: widgets.refreshFooter.statuses
class _TranslationsWidgetsRefreshFooterStatusesRu {
	_TranslationsWidgetsRefreshFooterStatusesRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get noMoreData => 'Данных больше нет';
	String get idle => 'Загрузить еще';
	String get failed => 'Ошибка связи с сервером';
	String get canLoading => 'Отпустите, чтобы загрузить еще';
}

// Path: widgets.emailField.errors
class _TranslationsWidgetsEmailFieldErrorsRu {
	_TranslationsWidgetsEmailFieldErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get incorrect => 'Неверный формат E-mail';
	String get empty => 'Введите E-mail';
}

// Path: widgets.fioField.errors
class _TranslationsWidgetsFioFieldErrorsRu {
	_TranslationsWidgetsFioFieldErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get incorrect => 'Неверный формат ФИО';
	String get empty => 'Введите ФИО';
}

// Path: widgets.passwordField.errors
class _TranslationsWidgetsPasswordFieldErrorsRu {
	_TranslationsWidgetsPasswordFieldErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get empty => 'Введите пароль';
	String minLength({required Object minLength}) => 'Минимальная длина пароля ${minLength} символом';
}

// Path: modal.pinSetup.title
class _TranslationsModalPinSetupTitleRu {
	_TranslationsModalPinSetupTitleRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get first => 'Придумайте PIN';
	String get repeat => 'Повторите новый PIN';
}

// Path: mobileScreens.registration.passwordRepeatField.errors
class _TranslationsMobileScreensRegistrationPasswordRepeatFieldErrorsRu {
	_TranslationsMobileScreensRegistrationPasswordRepeatFieldErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get passwordsNotMatch => 'Пароли не совпадают';
}

// Path: mobileScreens.registration.phoneField.errors
class _TranslationsMobileScreensRegistrationPhoneFieldErrorsRu {
	_TranslationsMobileScreensRegistrationPhoneFieldErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get incorrectFormat => 'Неверный формат';
	String get empty => 'Поле обязательно для заполнения';
}

// Path: mobileScreens.registrationCode.codeField.title
class _TranslationsMobileScreensRegistrationCodeCodeFieldTitleRu {
	_TranslationsMobileScreensRegistrationCodeCodeFieldTitleRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get email => 'Код из E-mail';
	String get sms => 'Код из SMS';
}

// Path: mobileScreens.registrationCode.codeField.errors
class _TranslationsMobileScreensRegistrationCodeCodeFieldErrorsRu {
	_TranslationsMobileScreensRegistrationCodeCodeFieldErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get incorrectFormat => 'Неверный формат';
	String get empty => 'Поле обязательно для заполнения';
}

// Path: mobileScreens.registrationParams.paramDateField.errors
class _TranslationsMobileScreensRegistrationParamsParamDateFieldErrorsRu {
	_TranslationsMobileScreensRegistrationParamsParamDateFieldErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get general => 'Некорректная дата';
}

// Path: mobileScreens.registrationParams.paramField.errors
class _TranslationsMobileScreensRegistrationParamsParamFieldErrorsRu {
	_TranslationsMobileScreensRegistrationParamsParamFieldErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get empty => 'Поле обязательно для заполнения';
	String minLength({required Object minLength}) => 'Минимальная длина ${minLength}';
}

// Path: mobileScreens.paymentsHistoryFilters.dateFromField.errors
class _TranslationsMobileScreensPaymentsHistoryFiltersDateFromFieldErrorsRu {
	_TranslationsMobileScreensPaymentsHistoryFiltersDateFromFieldErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get dateIsAfter => 'Ошибка';
	String get empty => 'Ошибка';
}

// Path: mobileScreens.paymentsHistoryFilters.dateToField.errors
class _TranslationsMobileScreensPaymentsHistoryFiltersDateToFieldErrorsRu {
	_TranslationsMobileScreensPaymentsHistoryFiltersDateToFieldErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get dateIsBefore => 'Ошибка';
	String get empty => 'Ошибка';
}

// Path: mobileScreens.payment.modal.error
class _TranslationsMobileScreensPaymentModalErrorRu {
	_TranslationsMobileScreensPaymentModalErrorRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Ошибка';
	String get repeatButton => 'Повторить';
	String get doneButton => 'Ок';
}

// Path: mobileScreens.payment.fieldsPage.paramField
class _TranslationsMobileScreensPaymentFieldsPageParamFieldRu {
	_TranslationsMobileScreensPaymentFieldsPageParamFieldRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensPaymentFieldsPageParamFieldErrorsRu errors = _TranslationsMobileScreensPaymentFieldsPageParamFieldErrorsRu._(_root);
}

// Path: mobileScreens.payment.attrDate.errors
class _TranslationsMobileScreensPaymentAttrDateErrorsRu {
	_TranslationsMobileScreensPaymentAttrDateErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get general => 'Некорректная дата';
}

// Path: mobileScreens.productAdd.modal.success
class _TranslationsMobileScreensProductAddModalSuccessRu {
	_TranslationsMobileScreensProductAddModalSuccessRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Успешно';
	late final _TranslationsMobileScreensProductAddModalSuccessMessageRu message = _TranslationsMobileScreensProductAddModalSuccessMessageRu._(_root);
}

// Path: mobileScreens.productAdd.accountForm.accountNumberField
class _TranslationsMobileScreensProductAddAccountFormAccountNumberFieldRu {
	_TranslationsMobileScreensProductAddAccountFormAccountNumberFieldRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get tilte => 'Номер счета*';
	late final _TranslationsMobileScreensProductAddAccountFormAccountNumberFieldErrorsRu errors = _TranslationsMobileScreensProductAddAccountFormAccountNumberFieldErrorsRu._(_root);
}

// Path: mobileScreens.productAdd.accountForm.paramField
class _TranslationsMobileScreensProductAddAccountFormParamFieldRu {
	_TranslationsMobileScreensProductAddAccountFormParamFieldRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensProductAddAccountFormParamFieldErrorsRu errors = _TranslationsMobileScreensProductAddAccountFormParamFieldErrorsRu._(_root);
}

// Path: mobileScreens.productAdd.cardForm.cardNumberField
class _TranslationsMobileScreensProductAddCardFormCardNumberFieldRu {
	_TranslationsMobileScreensProductAddCardFormCardNumberFieldRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get tilte => 'Номер карты*';
	late final _TranslationsMobileScreensProductAddCardFormCardNumberFieldErrorsRu errors = _TranslationsMobileScreensProductAddCardFormCardNumberFieldErrorsRu._(_root);
}

// Path: mobileScreens.productAdd.cardForm.expiryField
class _TranslationsMobileScreensProductAddCardFormExpiryFieldRu {
	_TranslationsMobileScreensProductAddCardFormExpiryFieldRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get tilte => 'Срок действия*';
	late final _TranslationsMobileScreensProductAddCardFormExpiryFieldErrorsRu errors = _TranslationsMobileScreensProductAddCardFormExpiryFieldErrorsRu._(_root);
}

// Path: mobileScreens.productAdd.cardForm.cvvField
class _TranslationsMobileScreensProductAddCardFormCvvFieldRu {
	_TranslationsMobileScreensProductAddCardFormCvvFieldRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensProductAddCardFormCvvFieldErrorsRu errors = _TranslationsMobileScreensProductAddCardFormCvvFieldErrorsRu._(_root);
}

// Path: mobileScreens.productAdd.cardForm.paramField
class _TranslationsMobileScreensProductAddCardFormParamFieldRu {
	_TranslationsMobileScreensProductAddCardFormParamFieldRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensProductAddCardFormParamFieldErrorsRu errors = _TranslationsMobileScreensProductAddCardFormParamFieldErrorsRu._(_root);
}

// Path: mobileScreens.productAdd.paramDate.errors
class _TranslationsMobileScreensProductAddParamDateErrorsRu {
	_TranslationsMobileScreensProductAddParamDateErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get general => 'Некорректная дата';
}

// Path: mobileScreens.cardInfo.modal.deleteProduct
class _TranslationsMobileScreensCardInfoModalDeleteProductRu {
	_TranslationsMobileScreensCardInfoModalDeleteProductRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Внимание';
	String get message => 'Действительно хотите удалить карту?';
	String get deleteButton => 'Удалить';
	String get cancelButton => 'Нет';
}

// Path: mobileScreens.cardInfo.modal.succesProductDelete
class _TranslationsMobileScreensCardInfoModalSuccesProductDeleteRu {
	_TranslationsMobileScreensCardInfoModalSuccesProductDeleteRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Успешно';
	String get message => 'Карта удалена';
}

// Path: mobileScreens.cardInfo.editName.paramField
class _TranslationsMobileScreensCardInfoEditNameParamFieldRu {
	_TranslationsMobileScreensCardInfoEditNameParamFieldRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensCardInfoEditNameParamFieldErrorsRu errors = _TranslationsMobileScreensCardInfoEditNameParamFieldErrorsRu._(_root);
}

// Path: mobileScreens.accountInfo.modal.deleteProduct
class _TranslationsMobileScreensAccountInfoModalDeleteProductRu {
	_TranslationsMobileScreensAccountInfoModalDeleteProductRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Внимание';
	String get message => 'Действительно хотите удалить счет?';
	String get deleteButton => 'Удалить';
	String get cancelButton => 'Нет';
}

// Path: mobileScreens.accountInfo.modal.succesProductDelete
class _TranslationsMobileScreensAccountInfoModalSuccesProductDeleteRu {
	_TranslationsMobileScreensAccountInfoModalSuccesProductDeleteRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Успешно';
	String get message => 'Счет удален';
}

// Path: mobileScreens.accountInfo.editName.paramField
class _TranslationsMobileScreensAccountInfoEditNameParamFieldRu {
	_TranslationsMobileScreensAccountInfoEditNameParamFieldRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsMobileScreensAccountInfoEditNameParamFieldErrorsRu errors = _TranslationsMobileScreensAccountInfoEditNameParamFieldErrorsRu._(_root);
}

// Path: mobileScreens.profileEdit.modal.success
class _TranslationsMobileScreensProfileEditModalSuccessRu {
	_TranslationsMobileScreensProfileEditModalSuccessRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Успешно';
	String get message => 'Пользователь отредактировать';
}

// Path: mobileScreens.profileEdit.paramField.errors
class _TranslationsMobileScreensProfileEditParamFieldErrorsRu {
	_TranslationsMobileScreensProfileEditParamFieldErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get empty => 'Поле обязательно для заполнения';
	String minLength({required Object minLength}) => 'Минимальная длина ${minLength}';
}

// Path: mobileScreens.settings.modal.changePinSuccess
class _TranslationsMobileScreensSettingsModalChangePinSuccessRu {
	_TranslationsMobileScreensSettingsModalChangePinSuccessRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Успешно';
	String get message => 'PIN-код измененён';
}

// Path: mobileScreens.settings.sections.access
class _TranslationsMobileScreensSettingsSectionsAccessRu {
	_TranslationsMobileScreensSettingsSectionsAccessRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Доступ';
	String get changePin => 'Изменить код доступа';
}

// Path: mobileScreens.settings.sections.account
class _TranslationsMobileScreensSettingsSectionsAccountRu {
	_TranslationsMobileScreensSettingsSectionsAccountRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get tilte => 'Аккаунт';
	String get language => 'Язык';
	String get changePassword => 'Изменить пароль';
}

// Path: mobileScreens.settings.sections.deleteAccount
class _TranslationsMobileScreensSettingsSectionsDeleteAccountRu {
	_TranslationsMobileScreensSettingsSectionsDeleteAccountRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Удаление учетной записи';
	String get text => 'Вы уверены что хотите удалить учетную запись?';
	String get success => 'Учетная запись успешно удалена';
	String get yes => 'Да';
	String get no => 'Нет';
}

// Path: mobileScreens.changePassword.oldPasswordField.errors
class _TranslationsMobileScreensChangePasswordOldPasswordFieldErrorsRu {
	_TranslationsMobileScreensChangePasswordOldPasswordFieldErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get incorrect => 'Неверный старый пароль';
}

// Path: mobileScreens.changePassword.newPasswordField.errors
class _TranslationsMobileScreensChangePasswordNewPasswordFieldErrorsRu {
	_TranslationsMobileScreensChangePasswordNewPasswordFieldErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get passwordsNotMatch => 'Пароли не совпадают';
}

// Path: mobileScreens.changePassword.newPasswordRepeatField.errors
class _TranslationsMobileScreensChangePasswordNewPasswordRepeatFieldErrorsRu {
	_TranslationsMobileScreensChangePasswordNewPasswordRepeatFieldErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get passwordsNotMatch => 'Пароли не совпадают';
}

// Path: mobileScreens.qrScan.modal.error
class _TranslationsMobileScreensQrScanModalErrorRu {
	_TranslationsMobileScreensQrScanModalErrorRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Ошибка';
	String message({required Object error}) => 'QR-код невалидный. ${error}';
}

// Path: mobileScreens.qrScan.qrCam.permissions
class _TranslationsMobileScreensQrScanQrCamPermissionsRu {
	_TranslationsMobileScreensQrScanQrCamPermissionsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get denied => 'Вы не предоставили разрешение доступа к камере';
	String get permamentlyDenied => 'Доступ к камере пермаментно заблокирован вами или политикой безопасности телефона';
}

// Path: mobileScreens.mdomAccountAdd.accountNumberField.errors
class _TranslationsMobileScreensMdomAccountAddAccountNumberFieldErrorsRu {
	_TranslationsMobileScreensMdomAccountAddAccountNumberFieldErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get empty => 'Введите номер счета';
}

// Path: mobileScreens.mdomAccountAdd.codeWordField.errors
class _TranslationsMobileScreensMdomAccountAddCodeWordFieldErrorsRu {
	_TranslationsMobileScreensMdomAccountAddCodeWordFieldErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get empty => 'Введите кодовое слово';
}

// Path: mobileScreens.mdomAccountAdd.supplierIdField.errors
class _TranslationsMobileScreensMdomAccountAddSupplierIdFieldErrorsRu {
	_TranslationsMobileScreensMdomAccountAddSupplierIdFieldErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get empty => 'Внесите числовой код организации';
}

// Path: mobileScreens.mdomCompanySearch.unpField.errors
class _TranslationsMobileScreensMdomCompanySearchUnpFieldErrorsRu {
	_TranslationsMobileScreensMdomCompanySearchUnpFieldErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get empty => 'Введите УНП';
	String get length => 'Минимальная длина 9 символов';
}

// Path: mobileScreens.mdomCompanySearch.nameField.errors
class _TranslationsMobileScreensMdomCompanySearchNameFieldErrorsRu {
	_TranslationsMobileScreensMdomCompanySearchNameFieldErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get empty => 'Введите наименование';
	String get length => 'Минимальная длина 3 символа';
}

// Path: mobileScreens.mdomAccountInfo.serviceSection.item
class _TranslationsMobileScreensMdomAccountInfoServiceSectionItemRu {
	_TranslationsMobileScreensMdomAccountInfoServiceSectionItemRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get count => 'Кол-во';
	String get rate => 'Тариф';
}

// Path: mobileScreens.mdomAccountInfo.serviceSectionInfo.item
class _TranslationsMobileScreensMdomAccountInfoServiceSectionInfoItemRu {
	_TranslationsMobileScreensMdomAccountInfoServiceSectionInfoItemRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get count => 'Количество';
	String get units => 'Единиц';
	String get tarif => 'Тариф руб.';
	String get accrued => 'Начислено руб.';
	String get recalculation => 'Перерасчет руб.';
	String get benefit => 'Льгота руб.';
	String get total => 'Итого руб.';
}

// Path: mobileScreens.mdomPeriodCustom.dateField.errors
class _TranslationsMobileScreensMdomPeriodCustomDateFieldErrorsRu {
	_TranslationsMobileScreensMdomPeriodCustomDateFieldErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get format => 'Неверный формат даты';
}

// Path: mobileScreens.mdomPeriodCustom.dateFromField.errors
class _TranslationsMobileScreensMdomPeriodCustomDateFromFieldErrorsRu {
	_TranslationsMobileScreensMdomPeriodCustomDateFromFieldErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get dateIsAfter => 'Ошибка';
	String get empty => 'Ошибка';
}

// Path: mobileScreens.mdomPeriodCustom.dateToField.errors
class _TranslationsMobileScreensMdomPeriodCustomDateToFieldErrorsRu {
	_TranslationsMobileScreensMdomPeriodCustomDateToFieldErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get dateIsBefore => 'Ошибка';
	String get empty => 'Ошибка';
}

// Path: mobileScreens.mdomPollsList.pollItem.votedText
class _TranslationsMobileScreensMdomPollsListPollItemVotedTextRu {
	_TranslationsMobileScreensMdomPollsListPollItemVotedTextRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get yes => 'Вы проголосовали';
	String get no => 'Не проголосовано';
}

// Path: mobileScreens.payment.fieldsPage.paramField.errors
class _TranslationsMobileScreensPaymentFieldsPageParamFieldErrorsRu {
	_TranslationsMobileScreensPaymentFieldsPageParamFieldErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get empty => 'Поле обязательно для заполнения';
	String minLength({required Object minLength}) => 'Минимальная длина ${minLength}';
}

// Path: mobileScreens.productAdd.modal.success.message
class _TranslationsMobileScreensProductAddModalSuccessMessageRu {
	_TranslationsMobileScreensProductAddModalSuccessMessageRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get account => 'Счет добавлен';
	String get card => 'Карта добавлена';
}

// Path: mobileScreens.productAdd.accountForm.accountNumberField.errors
class _TranslationsMobileScreensProductAddAccountFormAccountNumberFieldErrorsRu {
	_TranslationsMobileScreensProductAddAccountFormAccountNumberFieldErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get empty => 'Введите номер счета';
	String get incorrectFormat => 'Неверный формат номера счета';
}

// Path: mobileScreens.productAdd.accountForm.paramField.errors
class _TranslationsMobileScreensProductAddAccountFormParamFieldErrorsRu {
	_TranslationsMobileScreensProductAddAccountFormParamFieldErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get empty => 'Поле обязательно для заполнения';
	String minLength({required Object minLength}) => 'Минимальная длина ${minLength}';
}

// Path: mobileScreens.productAdd.cardForm.cardNumberField.errors
class _TranslationsMobileScreensProductAddCardFormCardNumberFieldErrorsRu {
	_TranslationsMobileScreensProductAddCardFormCardNumberFieldErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get empty => 'Введите номер карты';
	String get incorrectFormat => 'Неверный формат номера карты';
}

// Path: mobileScreens.productAdd.cardForm.expiryField.errors
class _TranslationsMobileScreensProductAddCardFormExpiryFieldErrorsRu {
	_TranslationsMobileScreensProductAddCardFormExpiryFieldErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get empty => 'Введите срок действия';
	String get incorrectFormat => 'Неверный формат номера карты';
}

// Path: mobileScreens.productAdd.cardForm.cvvField.errors
class _TranslationsMobileScreensProductAddCardFormCvvFieldErrorsRu {
	_TranslationsMobileScreensProductAddCardFormCvvFieldErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get empty => 'Введите CVV';
	String get incorrectFormat => 'Неверный формат CVV';
}

// Path: mobileScreens.productAdd.cardForm.paramField.errors
class _TranslationsMobileScreensProductAddCardFormParamFieldErrorsRu {
	_TranslationsMobileScreensProductAddCardFormParamFieldErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get empty => 'Поле обязательно для заполнения';
	String minLength({required Object minLength}) => 'Минимальная длина ${minLength}';
}

// Path: mobileScreens.cardInfo.editName.paramField.errors
class _TranslationsMobileScreensCardInfoEditNameParamFieldErrorsRu {
	_TranslationsMobileScreensCardInfoEditNameParamFieldErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get empty => 'Поле обязательно для заполнения';
	String minLength({required Object minLength}) => 'Минимальная длина ${minLength}';
}

// Path: mobileScreens.accountInfo.editName.paramField.errors
class _TranslationsMobileScreensAccountInfoEditNameParamFieldErrorsRu {
	_TranslationsMobileScreensAccountInfoEditNameParamFieldErrorsRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get empty => 'Поле обязательно для заполнения';
	String minLength({required Object minLength}) => 'Минимальная длина ${minLength}';
}

// Path: <root>
class _TranslationsEn extends _TranslationsRu {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_TranslationsEn.build({PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: _cardinalResolver = cardinalResolver,
		  _ordinalResolver = ordinalResolver,
		super.build();

	@override final PluralResolver? _cardinalResolver; // ignore: unused_field
	@override final PluralResolver? _ordinalResolver; // ignore: unused_field

	@override late final _TranslationsEn _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensEn mobileScreens = _TranslationsMobileScreensEn._(_root);
	@override late final _TranslationsModelsEn models = _TranslationsModelsEn._(_root);
	@override late final _TranslationsWidgetsEn widgets = _TranslationsWidgetsEn._(_root);
	@override late final _TranslationsModalEn modal = _TranslationsModalEn._(_root);
	@override late final _TranslationsGeneralEn general = _TranslationsGeneralEn._(_root);
	@override late final _TranslationsExceptionsEn exceptions = _TranslationsExceptionsEn._(_root);
}

// Path: mobileScreens
class _TranslationsMobileScreensEn extends _TranslationsMobileScreensRu {
	_TranslationsMobileScreensEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensSplashEn splash = _TranslationsMobileScreensSplashEn._(_root);
	@override late final _TranslationsMobileScreensAuthEn auth = _TranslationsMobileScreensAuthEn._(_root);
	@override late final _TranslationsMobileScreensAuthPasswordResetEn authPasswordReset = _TranslationsMobileScreensAuthPasswordResetEn._(_root);
	@override late final _TranslationsMobileScreensRegistrationEn registration = _TranslationsMobileScreensRegistrationEn._(_root);
	@override late final _TranslationsMobileScreensRegistrationCodeEn registrationCode = _TranslationsMobileScreensRegistrationCodeEn._(_root);
	@override late final _TranslationsMobileScreensRegistrationParamsEn registrationParams = _TranslationsMobileScreensRegistrationParamsEn._(_root);
	@override late final _TranslationsMobileScreensRegistrationSuccessEn registrationSuccess = _TranslationsMobileScreensRegistrationSuccessEn._(_root);
	@override late final _TranslationsMobileScreensMainEn main = _TranslationsMobileScreensMainEn._(_root);
	@override late final _TranslationsMobileScreensPaymentsHistoryEn paymentsHistory = _TranslationsMobileScreensPaymentsHistoryEn._(_root);
	@override late final _TranslationsMobileScreensQrPaymentEn qrPayment = _TranslationsMobileScreensQrPaymentEn._(_root);
	@override late final _TranslationsMobileScreensPaymentsHistoryFiltersEn paymentsHistoryFilters = _TranslationsMobileScreensPaymentsHistoryFiltersEn._(_root);
	@override late final _TranslationsMobileScreensProductsEn products = _TranslationsMobileScreensProductsEn._(_root);
	@override late final _TranslationsMobileScreensPaymentEn payment = _TranslationsMobileScreensPaymentEn._(_root);
	@override late final _TranslationsMobileScreensProductAddEn productAdd = _TranslationsMobileScreensProductAddEn._(_root);
	@override late final _TranslationsMobileScreensCardInfoEn cardInfo = _TranslationsMobileScreensCardInfoEn._(_root);
	@override late final _TranslationsMobileScreensAccountInfoEn accountInfo = _TranslationsMobileScreensAccountInfoEn._(_root);
	@override late final _TranslationsMobileScreensProfileEn profile = _TranslationsMobileScreensProfileEn._(_root);
	@override late final _TranslationsMobileScreensProfileEditEn profileEdit = _TranslationsMobileScreensProfileEditEn._(_root);
	@override late final _TranslationsMobileScreensSettingsEn settings = _TranslationsMobileScreensSettingsEn._(_root);
	@override late final _TranslationsMobileScreensChangePasswordEn changePassword = _TranslationsMobileScreensChangePasswordEn._(_root);
	@override late final _TranslationsMobileScreensQrScanEn qrScan = _TranslationsMobileScreensQrScanEn._(_root);
	@override late final _TranslationsMobileScreensMdomAccrualsEn mdomAccruals = _TranslationsMobileScreensMdomAccrualsEn._(_root);
	@override late final _TranslationsMobileScreensMdomNotificationsScreenEn mdomNotificationsScreen = _TranslationsMobileScreensMdomNotificationsScreenEn._(_root);
	@override late final _TranslationsMobileScreensMdomAccountAddEn mdomAccountAdd = _TranslationsMobileScreensMdomAccountAddEn._(_root);
	@override late final _TranslationsMobileScreensMdomCompanyChoiseEn mdomCompanyChoise = _TranslationsMobileScreensMdomCompanyChoiseEn._(_root);
	@override late final _TranslationsMobileScreensMdomCompanySearchEn mdomCompanySearch = _TranslationsMobileScreensMdomCompanySearchEn._(_root);
	@override late final _TranslationsMobileScreensMdomAccountInfoEn mdomAccountInfo = _TranslationsMobileScreensMdomAccountInfoEn._(_root);
	@override late final _TranslationsMobileScreensMdomAccountPaymentInfoEn mdomAccountPaymentInfo = _TranslationsMobileScreensMdomAccountPaymentInfoEn._(_root);
	@override late final _TranslationsMobileScreensMdomServiceInfoEn mdomServiceInfo = _TranslationsMobileScreensMdomServiceInfoEn._(_root);
	@override late final _TranslationsMobileScreensMdomPediodEn mdomPediod = _TranslationsMobileScreensMdomPediodEn._(_root);
	@override late final _TranslationsMobileScreensMdomPeriodCustomEn mdomPeriodCustom = _TranslationsMobileScreensMdomPeriodCustomEn._(_root);
	@override late final _TranslationsMobileScreensSelectLanguageEn selectLanguage = _TranslationsMobileScreensSelectLanguageEn._(_root);
	@override late final _TranslationsMobileScreensMdomPollsListEn mdomPollsList = _TranslationsMobileScreensMdomPollsListEn._(_root);
	@override late final _TranslationsMobileScreensMdomPollsListFiltersEn mdomPollsListFilters = _TranslationsMobileScreensMdomPollsListFiltersEn._(_root);
	@override late final _TranslationsMobileScreensMdomPollEn mdomPoll = _TranslationsMobileScreensMdomPollEn._(_root);
	@override late final _TranslationsMobileScreensMdomPollStatisticsEn mdomPollStatistics = _TranslationsMobileScreensMdomPollStatisticsEn._(_root);
	@override late final _TranslationsMobileScreensMdomPollStatisticsQuestionEn mdomPollStatisticsQuestion = _TranslationsMobileScreensMdomPollStatisticsQuestionEn._(_root);
}

// Path: models
class _TranslationsModelsEn extends _TranslationsModelsRu {
	_TranslationsModelsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsModelsParamTypeEn paramType = _TranslationsModelsParamTypeEn._(_root);
	@override late final _TranslationsModelsPeriodEn period = _TranslationsModelsPeriodEn._(_root);
	@override late final _TranslationsModelsPollStatusEn pollStatus = _TranslationsModelsPollStatusEn._(_root);
	@override late final _TranslationsModelsPollAnswerEn pollAnswer = _TranslationsModelsPollAnswerEn._(_root);
}

// Path: widgets
class _TranslationsWidgetsEn extends _TranslationsWidgetsRu {
	_TranslationsWidgetsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsWidgetsRefreshHeaderEn refreshHeader = _TranslationsWidgetsRefreshHeaderEn._(_root);
	@override late final _TranslationsWidgetsRefreshFooterEn refreshFooter = _TranslationsWidgetsRefreshFooterEn._(_root);
	@override late final _TranslationsWidgetsEmailFieldEn emailField = _TranslationsWidgetsEmailFieldEn._(_root);
	@override late final _TranslationsWidgetsFioFieldEn fioField = _TranslationsWidgetsFioFieldEn._(_root);
	@override late final _TranslationsWidgetsPasswordFieldEn passwordField = _TranslationsWidgetsPasswordFieldEn._(_root);
}

// Path: modal
class _TranslationsModalEn extends _TranslationsModalRu {
	_TranslationsModalEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsModalPinSetupEn pinSetup = _TranslationsModalPinSetupEn._(_root);
	@override late final _TranslationsModalPinVerifyEn pinVerify = _TranslationsModalPinVerifyEn._(_root);
	@override late final _TranslationsModalBiometricSetupEn biometricSetup = _TranslationsModalBiometricSetupEn._(_root);
	@override late final _TranslationsModalDecisionMessageEn decisionMessage = _TranslationsModalDecisionMessageEn._(_root);
	@override late final _TranslationsModalLogOutEn logOut = _TranslationsModalLogOutEn._(_root);
}

// Path: general
class _TranslationsGeneralEn extends _TranslationsGeneralRu {
	_TranslationsGeneralEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsGeneralErrorModalEn errorModal = _TranslationsGeneralErrorModalEn._(_root);
}

// Path: exceptions
class _TranslationsExceptionsEn extends _TranslationsExceptionsRu {
	_TranslationsExceptionsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get emtyOrganizationsList => 'Add an account';
	@override String get networkError => 'Failed to connect servers';
	@override late final _TranslationsExceptionsChangePasswordBlocEn changePasswordBloc = _TranslationsExceptionsChangePasswordBlocEn._(_root);
	@override late final _TranslationsExceptionsPaymentBlocEn paymentBloc = _TranslationsExceptionsPaymentBlocEn._(_root);
	@override late final _TranslationsExceptionsQrEripEn qrErip = _TranslationsExceptionsQrEripEn._(_root);
	@override String get onlyIndividuals => 'This application is intended for individuals';
}

// Path: mobileScreens.splash
class _TranslationsMobileScreensSplashEn extends _TranslationsMobileScreensSplashRu {
	_TranslationsMobileScreensSplashEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get loadingMessage => 'Please wait';
	@override String get repeatButton => 'Repeat';
	@override String get errorMessage => 'Error';
}

// Path: mobileScreens.auth
class _TranslationsMobileScreensAuthEn extends _TranslationsMobileScreensAuthRu {
	_TranslationsMobileScreensAuthEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Enter';
	@override String get forgotPassword => 'Forgot your password?';
	@override String get authButton => 'Enter';
	@override String get registrationButton => 'Register';
}

// Path: mobileScreens.authPasswordReset
class _TranslationsMobileScreensAuthPasswordResetEn extends _TranslationsMobileScreensAuthPasswordResetRu {
	_TranslationsMobileScreensAuthPasswordResetEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Change password';
	@override String get resetButton => 'Change';
	@override String get login => 'Login';
	@override String get success => 'Successfully';
	@override String get message => 'New password sent by email';
	@override String get loginHint => 'Your login';
	@override late final _TranslationsMobileScreensAuthPasswordResetErrorsEn errors = _TranslationsMobileScreensAuthPasswordResetErrorsEn._(_root);
}

// Path: mobileScreens.registration
class _TranslationsMobileScreensRegistrationEn extends _TranslationsMobileScreensRegistrationRu {
	_TranslationsMobileScreensRegistrationEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Registration';
	@override late final _TranslationsMobileScreensRegistrationPasswordRepeatFieldEn passwordRepeatField = _TranslationsMobileScreensRegistrationPasswordRepeatFieldEn._(_root);
	@override late final _TranslationsMobileScreensRegistrationSmsSwitchEn smsSwitch = _TranslationsMobileScreensRegistrationSmsSwitchEn._(_root);
	@override late final _TranslationsMobileScreensRegistrationPhoneFieldEn phoneField = _TranslationsMobileScreensRegistrationPhoneFieldEn._(_root);
	@override String get applyButton => 'Proceed';
}

// Path: mobileScreens.registrationCode
class _TranslationsMobileScreensRegistrationCodeEn extends _TranslationsMobileScreensRegistrationCodeRu {
	_TranslationsMobileScreensRegistrationCodeEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Registration';
	@override late final _TranslationsMobileScreensRegistrationCodeCodeFieldEn codeField = _TranslationsMobileScreensRegistrationCodeCodeFieldEn._(_root);
	@override String get applyButton => 'Register';
}

// Path: mobileScreens.registrationParams
class _TranslationsMobileScreensRegistrationParamsEn extends _TranslationsMobileScreensRegistrationParamsRu {
	_TranslationsMobileScreensRegistrationParamsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Registration';
	@override String get applyButton => 'Proceed';
	@override late final _TranslationsMobileScreensRegistrationParamsParamDateFieldEn paramDateField = _TranslationsMobileScreensRegistrationParamsParamDateFieldEn._(_root);
	@override late final _TranslationsMobileScreensRegistrationParamsParamFieldEn paramField = _TranslationsMobileScreensRegistrationParamsParamFieldEn._(_root);
}

// Path: mobileScreens.registrationSuccess
class _TranslationsMobileScreensRegistrationSuccessEn extends _TranslationsMobileScreensRegistrationSuccessRu {
	_TranslationsMobileScreensRegistrationSuccessEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ready!';
	@override String get message => 'You have successfully registered';
	@override String get pinSetupDescription => 'Need to set up the fast login feature with Passcode';
	@override String get setPinButton => 'Set up';
}

// Path: mobileScreens.main
class _TranslationsMobileScreensMainEn extends _TranslationsMobileScreensMainRu {
	_TranslationsMobileScreensMainEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensMainMenuEn menu = _TranslationsMobileScreensMainMenuEn._(_root);
}

// Path: mobileScreens.paymentsHistory
class _TranslationsMobileScreensPaymentsHistoryEn extends _TranslationsMobileScreensPaymentsHistoryRu {
	_TranslationsMobileScreensPaymentsHistoryEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'History';
	@override String get filterButton => 'Open filter';
	@override String get noMoreDataMessage => 'No more payments';
	@override String get emptyDataMessage => 'The list is empty.\nUse a filter';
}

// Path: mobileScreens.qrPayment
class _TranslationsMobileScreensQrPaymentEn extends _TranslationsMobileScreensQrPaymentRu {
	_TranslationsMobileScreensQrPaymentEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get generateQrButton => 'Get QR';
	@override String get updateQrButton => 'Update QR';
	@override String get confirmOrderBySMS => 'Confirm SMS';
	@override String get paymentDialogTitle => 'QR payment';
	@override String get historyDialogTitle => 'QR operation';
	@override String get historyDialogMessage => 'Payment canceled';
}

// Path: mobileScreens.paymentsHistoryFilters
class _TranslationsMobileScreensPaymentsHistoryFiltersEn extends _TranslationsMobileScreensPaymentsHistoryFiltersRu {
	_TranslationsMobileScreensPaymentsHistoryFiltersEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Filter';
	@override String get resetButton => 'Reset';
	@override String get periodTitle => 'Period';
	@override late final _TranslationsMobileScreensPaymentsHistoryFiltersDateFromFieldEn dateFromField = _TranslationsMobileScreensPaymentsHistoryFiltersDateFromFieldEn._(_root);
	@override late final _TranslationsMobileScreensPaymentsHistoryFiltersDateToFieldEn dateToField = _TranslationsMobileScreensPaymentsHistoryFiltersDateToFieldEn._(_root);
	@override String get productsTitle => 'Accounts and cards';
	@override String get applyButton => 'Apply';
}

// Path: mobileScreens.products
class _TranslationsMobileScreensProductsEn extends _TranslationsMobileScreensProductsRu {
	_TranslationsMobileScreensProductsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Accounts and cards';
	@override String get addButton => 'Add';
	@override late final _TranslationsMobileScreensProductsMainProductTitleEn mainProductTitle = _TranslationsMobileScreensProductsMainProductTitleEn._(_root);
	@override late final _TranslationsMobileScreensProductsProductsSegmentControlTitleEn productsSegmentControlTitle = _TranslationsMobileScreensProductsProductsSegmentControlTitleEn._(_root);
}

// Path: mobileScreens.payment
class _TranslationsMobileScreensPaymentEn extends _TranslationsMobileScreensPaymentRu {
	_TranslationsMobileScreensPaymentEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Payments';
	@override String get sumText => 'To pay';
	@override String get payButtonMessage => 'This feature is currently unavailable';
	@override String get payButtonTitle => 'Operation rejected';
	@override String get emty => 'The list is empty';
	@override String get details => 'Payment details';
	@override String get requirmentNumber => 'Requirment number';
	@override String get errorMessage => 'Error';
	@override late final _TranslationsMobileScreensPaymentModalEn modal = _TranslationsMobileScreensPaymentModalEn._(_root);
	@override late final _TranslationsMobileScreensPaymentFieldsPageEn fieldsPage = _TranslationsMobileScreensPaymentFieldsPageEn._(_root);
	@override late final _TranslationsMobileScreensPaymentServiceResultPageEn serviceResultPage = _TranslationsMobileScreensPaymentServiceResultPageEn._(_root);
	@override late final _TranslationsMobileScreensPaymentAttrDateEn attrDate = _TranslationsMobileScreensPaymentAttrDateEn._(_root);
}

// Path: mobileScreens.productAdd
class _TranslationsMobileScreensProductAddEn extends _TranslationsMobileScreensProductAddRu {
	_TranslationsMobileScreensProductAddEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Add';
	@override late final _TranslationsMobileScreensProductAddModalEn modal = _TranslationsMobileScreensProductAddModalEn._(_root);
	@override late final _TranslationsMobileScreensProductAddProductSelectorEn productSelector = _TranslationsMobileScreensProductAddProductSelectorEn._(_root);
	@override late final _TranslationsMobileScreensProductAddAccountFormEn accountForm = _TranslationsMobileScreensProductAddAccountFormEn._(_root);
	@override late final _TranslationsMobileScreensProductAddCardFormEn cardForm = _TranslationsMobileScreensProductAddCardFormEn._(_root);
	@override late final _TranslationsMobileScreensProductAddParamDateEn paramDate = _TranslationsMobileScreensProductAddParamDateEn._(_root);
}

// Path: mobileScreens.cardInfo
class _TranslationsMobileScreensCardInfoEn extends _TranslationsMobileScreensCardInfoRu {
	_TranslationsMobileScreensCardInfoEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Card editing';
	@override String get buttonTitle => 'Save';
	@override late final _TranslationsMobileScreensCardInfoPropertiesEn properties = _TranslationsMobileScreensCardInfoPropertiesEn._(_root);
	@override late final _TranslationsMobileScreensCardInfoModalEn modal = _TranslationsMobileScreensCardInfoModalEn._(_root);
	@override late final _TranslationsMobileScreensCardInfoEditNameEn editName = _TranslationsMobileScreensCardInfoEditNameEn._(_root);
	@override String get makeMainButton => 'Make main';
	@override String get deleteButton => 'Delete';
}

// Path: mobileScreens.accountInfo
class _TranslationsMobileScreensAccountInfoEn extends _TranslationsMobileScreensAccountInfoRu {
	_TranslationsMobileScreensAccountInfoEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Account editing';
	@override String get buttonTitle => 'Save';
	@override late final _TranslationsMobileScreensAccountInfoPropertiesEn properties = _TranslationsMobileScreensAccountInfoPropertiesEn._(_root);
	@override late final _TranslationsMobileScreensAccountInfoModalEn modal = _TranslationsMobileScreensAccountInfoModalEn._(_root);
	@override late final _TranslationsMobileScreensAccountInfoEditNameEn editName = _TranslationsMobileScreensAccountInfoEditNameEn._(_root);
	@override String get makeMainButton => 'Make main';
	@override String get deleteButton => 'Delete';
}

// Path: mobileScreens.profile
class _TranslationsMobileScreensProfileEn extends _TranslationsMobileScreensProfileRu {
	_TranslationsMobileScreensProfileEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Profile';
	@override String get editButton => 'Editing';
	@override late final _TranslationsMobileScreensProfileSettingsItemEn settingsItem = _TranslationsMobileScreensProfileSettingsItemEn._(_root);
	@override late final _TranslationsMobileScreensProfileLogOutItemEn logOutItem = _TranslationsMobileScreensProfileLogOutItemEn._(_root);
}

// Path: mobileScreens.profileEdit
class _TranslationsMobileScreensProfileEditEn extends _TranslationsMobileScreensProfileEditRu {
	_TranslationsMobileScreensProfileEditEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Editing';
	@override late final _TranslationsMobileScreensProfileEditModalEn modal = _TranslationsMobileScreensProfileEditModalEn._(_root);
	@override late final _TranslationsMobileScreensProfileEditParamFieldEn paramField = _TranslationsMobileScreensProfileEditParamFieldEn._(_root);
	@override String get saveButton => 'Ready';
}

// Path: mobileScreens.settings
class _TranslationsMobileScreensSettingsEn extends _TranslationsMobileScreensSettingsRu {
	_TranslationsMobileScreensSettingsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Settings';
	@override late final _TranslationsMobileScreensSettingsModalEn modal = _TranslationsMobileScreensSettingsModalEn._(_root);
	@override late final _TranslationsMobileScreensSettingsSectionsEn sections = _TranslationsMobileScreensSettingsSectionsEn._(_root);
	@override late final _TranslationsMobileScreensSettingsAuthWithBiometricsItemEn authWithBiometricsItem = _TranslationsMobileScreensSettingsAuthWithBiometricsItemEn._(_root);
}

// Path: mobileScreens.changePassword
class _TranslationsMobileScreensChangePasswordEn extends _TranslationsMobileScreensChangePasswordRu {
	_TranslationsMobileScreensChangePasswordEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Change password';
	@override String get saveButton => 'Change';
	@override String get loadingTitle => 'Please wait';
	@override late final _TranslationsMobileScreensChangePasswordOldPasswordFieldEn oldPasswordField = _TranslationsMobileScreensChangePasswordOldPasswordFieldEn._(_root);
	@override late final _TranslationsMobileScreensChangePasswordNewPasswordFieldEn newPasswordField = _TranslationsMobileScreensChangePasswordNewPasswordFieldEn._(_root);
	@override late final _TranslationsMobileScreensChangePasswordNewPasswordRepeatFieldEn newPasswordRepeatField = _TranslationsMobileScreensChangePasswordNewPasswordRepeatFieldEn._(_root);
}

// Path: mobileScreens.qrScan
class _TranslationsMobileScreensQrScanEn extends _TranslationsMobileScreensQrScanRu {
	_TranslationsMobileScreensQrScanEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensQrScanFlashButtonEn flashButton = _TranslationsMobileScreensQrScanFlashButtonEn._(_root);
	@override late final _TranslationsMobileScreensQrScanModalEn modal = _TranslationsMobileScreensQrScanModalEn._(_root);
	@override late final _TranslationsMobileScreensQrScanQrCamEn qrCam = _TranslationsMobileScreensQrScanQrCamEn._(_root);
}

// Path: mobileScreens.mdomAccruals
class _TranslationsMobileScreensMdomAccrualsEn extends _TranslationsMobileScreensMdomAccrualsRu {
	_TranslationsMobileScreensMdomAccrualsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Organisations';
	@override String get addButton => '+ Add account';
	@override late final _TranslationsMobileScreensMdomAccrualsAccountItemEn accountItem = _TranslationsMobileScreensMdomAccrualsAccountItemEn._(_root);
	@override late final _TranslationsMobileScreensMdomAccrualsPollItemEn pollItem = _TranslationsMobileScreensMdomAccrualsPollItemEn._(_root);
}

// Path: mobileScreens.mdomNotificationsScreen
class _TranslationsMobileScreensMdomNotificationsScreenEn extends _TranslationsMobileScreensMdomNotificationsScreenRu {
	_TranslationsMobileScreensMdomNotificationsScreenEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Notifications';
	@override String get readAllButton => 'Read all';
	@override String get readButton => 'New';
	@override late final _TranslationsMobileScreensMdomNotificationsScreenSuccessModalEn successModal = _TranslationsMobileScreensMdomNotificationsScreenSuccessModalEn._(_root);
	@override String get loadMore => 'Load more';
	@override String get notificationsListEmpty => 'Notifications list is empty';
}

// Path: mobileScreens.mdomAccountAdd
class _TranslationsMobileScreensMdomAccountAddEn extends _TranslationsMobileScreensMdomAccountAddRu {
	_TranslationsMobileScreensMdomAccountAddEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Adding account';
	@override late final _TranslationsMobileScreensMdomAccountAddSuccessModalEn successModal = _TranslationsMobileScreensMdomAccountAddSuccessModalEn._(_root);
	@override String get addButton => 'Add';
	@override late final _TranslationsMobileScreensMdomAccountAddAccountNumberFieldEn accountNumberField = _TranslationsMobileScreensMdomAccountAddAccountNumberFieldEn._(_root);
	@override late final _TranslationsMobileScreensMdomAccountAddCodeWordFieldEn codeWordField = _TranslationsMobileScreensMdomAccountAddCodeWordFieldEn._(_root);
	@override late final _TranslationsMobileScreensMdomAccountAddSupplierIdFieldEn supplierIdField = _TranslationsMobileScreensMdomAccountAddSupplierIdFieldEn._(_root);
}

// Path: mobileScreens.mdomCompanyChoise
class _TranslationsMobileScreensMdomCompanyChoiseEn extends _TranslationsMobileScreensMdomCompanyChoiseRu {
	_TranslationsMobileScreensMdomCompanyChoiseEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Choose organization';
	@override late final _TranslationsMobileScreensMdomCompanyChoiseSearchFieldEn searchField = _TranslationsMobileScreensMdomCompanyChoiseSearchFieldEn._(_root);
	@override String get selectButton => 'Select';
}

// Path: mobileScreens.mdomCompanySearch
class _TranslationsMobileScreensMdomCompanySearchEn extends _TranslationsMobileScreensMdomCompanySearchRu {
	_TranslationsMobileScreensMdomCompanySearchEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Organization search';
	@override late final _TranslationsMobileScreensMdomCompanySearchSearchFieldEn searchField = _TranslationsMobileScreensMdomCompanySearchSearchFieldEn._(_root);
	@override late final _TranslationsMobileScreensMdomCompanySearchUnpFieldEn unpField = _TranslationsMobileScreensMdomCompanySearchUnpFieldEn._(_root);
	@override late final _TranslationsMobileScreensMdomCompanySearchNameFieldEn nameField = _TranslationsMobileScreensMdomCompanySearchNameFieldEn._(_root);
	@override late final _TranslationsMobileScreensMdomCompanySearchErrorsEn errors = _TranslationsMobileScreensMdomCompanySearchErrorsEn._(_root);
	@override String get selectButton => 'Select';
}

// Path: mobileScreens.mdomAccountInfo
class _TranslationsMobileScreensMdomAccountInfoEn extends _TranslationsMobileScreensMdomAccountInfoRu {
	_TranslationsMobileScreensMdomAccountInfoEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get tilte => 'Account statement';
	@override late final _TranslationsMobileScreensMdomAccountInfoPeriodSectionEn periodSection = _TranslationsMobileScreensMdomAccountInfoPeriodSectionEn._(_root);
	@override late final _TranslationsMobileScreensMdomAccountInfoChargingSectionEn chargingSection = _TranslationsMobileScreensMdomAccountInfoChargingSectionEn._(_root);
	@override late final _TranslationsMobileScreensMdomAccountInfoPaySectionEn paySection = _TranslationsMobileScreensMdomAccountInfoPaySectionEn._(_root);
	@override late final _TranslationsMobileScreensMdomAccountInfoChargingSectionInfoEn chargingSectionInfo = _TranslationsMobileScreensMdomAccountInfoChargingSectionInfoEn._(_root);
	@override late final _TranslationsMobileScreensMdomAccountInfoServiceSectionEn serviceSection = _TranslationsMobileScreensMdomAccountInfoServiceSectionEn._(_root);
	@override late final _TranslationsMobileScreensMdomAccountInfoServiceSectionInfoEn serviceSectionInfo = _TranslationsMobileScreensMdomAccountInfoServiceSectionInfoEn._(_root);
	@override late final _TranslationsMobileScreensMdomAccountInfoRequirementsInfoEn requirementsInfo = _TranslationsMobileScreensMdomAccountInfoRequirementsInfoEn._(_root);
	@override late final _TranslationsMobileScreensMdomAccountInfoPayButtonEn payButton = _TranslationsMobileScreensMdomAccountInfoPayButtonEn._(_root);
	@override String payInfo({required Object amount, required Object currency}) => 'Pay ${amount} ${currency}';
}

// Path: mobileScreens.mdomAccountPaymentInfo
class _TranslationsMobileScreensMdomAccountPaymentInfoEn extends _TranslationsMobileScreensMdomAccountPaymentInfoRu {
	_TranslationsMobileScreensMdomAccountPaymentInfoEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get paymentDate => 'Payment date';
	@override String get paymentCode => 'Payment code';
	@override String get sum => 'Sum';
	@override String get description => 'Description';
}

// Path: mobileScreens.mdomServiceInfo
class _TranslationsMobileScreensMdomServiceInfoEn extends _TranslationsMobileScreensMdomServiceInfoRu {
	_TranslationsMobileScreensMdomServiceInfoEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get doneButton => 'Done';
}

// Path: mobileScreens.mdomPediod
class _TranslationsMobileScreensMdomPediodEn extends _TranslationsMobileScreensMdomPediodRu {
	_TranslationsMobileScreensMdomPediodEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Period';
	@override String get doneButton => 'Select';
}

// Path: mobileScreens.mdomPeriodCustom
class _TranslationsMobileScreensMdomPeriodCustomEn extends _TranslationsMobileScreensMdomPeriodCustomRu {
	_TranslationsMobileScreensMdomPeriodCustomEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Custom period';
	@override late final _TranslationsMobileScreensMdomPeriodCustomDateFieldEn dateField = _TranslationsMobileScreensMdomPeriodCustomDateFieldEn._(_root);
	@override late final _TranslationsMobileScreensMdomPeriodCustomDateFromFieldEn dateFromField = _TranslationsMobileScreensMdomPeriodCustomDateFromFieldEn._(_root);
	@override late final _TranslationsMobileScreensMdomPeriodCustomDateToFieldEn dateToField = _TranslationsMobileScreensMdomPeriodCustomDateToFieldEn._(_root);
	@override String get doneButton => 'Select';
}

// Path: mobileScreens.selectLanguage
class _TranslationsMobileScreensSelectLanguageEn extends _TranslationsMobileScreensSelectLanguageRu {
	_TranslationsMobileScreensSelectLanguageEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Select language';
	@override String get currentLanguageLabel => 'Current';
}

// Path: mobileScreens.mdomPollsList
class _TranslationsMobileScreensMdomPollsListEn extends _TranslationsMobileScreensMdomPollsListRu {
	_TranslationsMobileScreensMdomPollsListEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Polls';
	@override String get filtersButton => 'Filter';
	@override late final _TranslationsMobileScreensMdomPollsListCurrentStatusEn currentStatus = _TranslationsMobileScreensMdomPollsListCurrentStatusEn._(_root);
	@override String get emptyDataMessage => 'The list is empty.\nUse a filter';
	@override String get noMoreDataMessage => 'No more polls.';
	@override late final _TranslationsMobileScreensMdomPollsListPollItemEn pollItem = _TranslationsMobileScreensMdomPollsListPollItemEn._(_root);
}

// Path: mobileScreens.mdomPollsListFilters
class _TranslationsMobileScreensMdomPollsListFiltersEn extends _TranslationsMobileScreensMdomPollsListFiltersRu {
	_TranslationsMobileScreensMdomPollsListFiltersEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Polls';
	@override String get cancelButton => 'Cancel';
	@override String get resetButton => 'Reset';
	@override late final _TranslationsMobileScreensMdomPollsListFiltersStatusPickerEn statusPicker = _TranslationsMobileScreensMdomPollsListFiltersStatusPickerEn._(_root);
	@override late final _TranslationsMobileScreensMdomPollsListFiltersEndDateRangePickerEn endDateRangePicker = _TranslationsMobileScreensMdomPollsListFiltersEndDateRangePickerEn._(_root);
	@override String get applyButton => 'Apply';
}

// Path: mobileScreens.mdomPoll
class _TranslationsMobileScreensMdomPollEn extends _TranslationsMobileScreensMdomPollRu {
	_TranslationsMobileScreensMdomPollEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensMdomPollTitleEn title = _TranslationsMobileScreensMdomPollTitleEn._(_root);
	@override late final _TranslationsMobileScreensMdomPollModalEn modal = _TranslationsMobileScreensMdomPollModalEn._(_root);
	@override String get linkItem => 'Detailed information';
	@override late final _TranslationsMobileScreensMdomPollInfoEn info = _TranslationsMobileScreensMdomPollInfoEn._(_root);
	@override late final _TranslationsMobileScreensMdomPollQuestionsListEn questionsList = _TranslationsMobileScreensMdomPollQuestionsListEn._(_root);
	@override late final _TranslationsMobileScreensMdomPollVoteButtonEn voteButton = _TranslationsMobileScreensMdomPollVoteButtonEn._(_root);
	@override String get editButton => 'Edit answers';
	@override String get pollsStatButtonNoOneVoted => 'No one has voted';
	@override String get pollsStatButtonNoOneVotedYeat => 'No one has voted yet';
	@override String pollStatButton({required num count}) => (_root._cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		one: '${count} people voted',
		other: '${count} peoples voted',
	);
}

// Path: mobileScreens.mdomPollStatistics
class _TranslationsMobileScreensMdomPollStatisticsEn extends _TranslationsMobileScreensMdomPollStatisticsRu {
	_TranslationsMobileScreensMdomPollStatisticsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Questions';
	@override String get votedText => 'Voted';
	@override String get participantsText => 'Participants';
}

// Path: mobileScreens.mdomPollStatisticsQuestion
class _TranslationsMobileScreensMdomPollStatisticsQuestionEn extends _TranslationsMobileScreensMdomPollStatisticsQuestionRu {
	_TranslationsMobileScreensMdomPollStatisticsQuestionEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get votedText => 'Total votes';
	@override String get errorMessage => 'Error';
	@override late final _TranslationsMobileScreensMdomPollStatisticsQuestionAnswersTitleEn answersTitle = _TranslationsMobileScreensMdomPollStatisticsQuestionAnswersTitleEn._(_root);
}

// Path: models.paramType
class _TranslationsModelsParamTypeEn extends _TranslationsModelsParamTypeRu {
	_TranslationsModelsParamTypeEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get error => 'Incorrect value';
}

// Path: models.period
class _TranslationsModelsPeriodEn extends _TranslationsModelsPeriodRu {
	_TranslationsModelsPeriodEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Personal account';
	@override late final _TranslationsModelsPeriodNamesEn names = _TranslationsModelsPeriodNamesEn._(_root);
	@override late final _TranslationsModelsPeriodSelectedNamesEn selectedNames = _TranslationsModelsPeriodSelectedNamesEn._(_root);
}

// Path: models.pollStatus
class _TranslationsModelsPollStatusEn extends _TranslationsModelsPollStatusRu {
	_TranslationsModelsPollStatusEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get all => 'All';
	@override String get publication => 'Publication';
	@override String get inProgress => 'In progress';
	@override String get completed => 'Completed';
}

// Path: models.pollAnswer
class _TranslationsModelsPollAnswerEn extends _TranslationsModelsPollAnswerRu {
	_TranslationsModelsPollAnswerEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsModelsPollAnswerActiveEn active = _TranslationsModelsPollAnswerActiveEn._(_root);
	@override late final _TranslationsModelsPollAnswerVotedEn voted = _TranslationsModelsPollAnswerVotedEn._(_root);
}

// Path: widgets.refreshHeader
class _TranslationsWidgetsRefreshHeaderEn extends _TranslationsWidgetsRefreshHeaderRu {
	_TranslationsWidgetsRefreshHeaderEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get idle => 'Pull down to refresh';
}

// Path: widgets.refreshFooter
class _TranslationsWidgetsRefreshFooterEn extends _TranslationsWidgetsRefreshFooterRu {
	_TranslationsWidgetsRefreshFooterEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsWidgetsRefreshFooterStatusesEn statuses = _TranslationsWidgetsRefreshFooterStatusesEn._(_root);
}

// Path: widgets.emailField
class _TranslationsWidgetsEmailFieldEn extends _TranslationsWidgetsEmailFieldRu {
	_TranslationsWidgetsEmailFieldEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsWidgetsEmailFieldErrorsEn errors = _TranslationsWidgetsEmailFieldErrorsEn._(_root);
}

// Path: widgets.fioField
class _TranslationsWidgetsFioFieldEn extends _TranslationsWidgetsFioFieldRu {
	_TranslationsWidgetsFioFieldEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsWidgetsFioFieldErrorsEn errors = _TranslationsWidgetsFioFieldErrorsEn._(_root);
}

// Path: widgets.passwordField
class _TranslationsWidgetsPasswordFieldEn extends _TranslationsWidgetsPasswordFieldRu {
	_TranslationsWidgetsPasswordFieldEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Password';
	@override late final _TranslationsWidgetsPasswordFieldErrorsEn errors = _TranslationsWidgetsPasswordFieldErrorsEn._(_root);
}

// Path: modal.pinSetup
class _TranslationsModalPinSetupEn extends _TranslationsModalPinSetupRu {
	_TranslationsModalPinSetupEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsModalPinSetupTitleEn title = _TranslationsModalPinSetupTitleEn._(_root);
	@override String get cancelButton => 'Cancel';
	@override String get localizedReason => 'Authorization in the application';
}

// Path: modal.pinVerify
class _TranslationsModalPinVerifyEn extends _TranslationsModalPinVerifyRu {
	_TranslationsModalPinVerifyEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Repeat PIN';
	@override String get cancelButton => 'Cancel';
	@override String get biometricReason => 'Authorization in the application';
}

// Path: modal.biometricSetup
class _TranslationsModalBiometricSetupEn extends _TranslationsModalBiometricSetupRu {
	_TranslationsModalBiometricSetupEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get biometricDescription => 'biometrics';
	@override String title({required Object biometricDescription}) => 'Use ${biometricDescription} to login to app?';
	@override String get confirmButton => 'Yes';
	@override String get cancelButton => 'No';
}

// Path: modal.decisionMessage
class _TranslationsModalDecisionMessageEn extends _TranslationsModalDecisionMessageRu {
	_TranslationsModalDecisionMessageEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Attention';
	@override String get confirmButton => 'Ok';
	@override String get cancelButton => 'Cancel';
}

// Path: modal.logOut
class _TranslationsModalLogOutEn extends _TranslationsModalLogOutRu {
	_TranslationsModalLogOutEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Are you sure you want to leave?';
	@override String get message => 'Your authorized data will be deleted from the device';
	@override String get confirmButton => 'Exit';
	@override String get cancelButton => 'Stay';
}

// Path: general.errorModal
class _TranslationsGeneralErrorModalEn extends _TranslationsGeneralErrorModalRu {
	_TranslationsGeneralErrorModalEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Error';
}

// Path: exceptions.changePasswordBloc
class _TranslationsExceptionsChangePasswordBlocEn extends _TranslationsExceptionsChangePasswordBlocRu {
	_TranslationsExceptionsChangePasswordBlocEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get wrongOldPassword => 'Old password is wrong';
}

// Path: exceptions.paymentBloc
class _TranslationsExceptionsPaymentBlocEn extends _TranslationsExceptionsPaymentBlocRu {
	_TranslationsExceptionsPaymentBlocEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get unknownService => 'Failed to get service information';
}

// Path: exceptions.qrErip
class _TranslationsExceptionsQrEripEn extends _TranslationsExceptionsQrEripRu {
	_TranslationsExceptionsQrEripEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get verifyCheckSum => 'Invalid checksum';
}

// Path: mobileScreens.authPasswordReset.errors
class _TranslationsMobileScreensAuthPasswordResetErrorsEn extends _TranslationsMobileScreensAuthPasswordResetErrorsRu {
	_TranslationsMobileScreensAuthPasswordResetErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Required field';
}

// Path: mobileScreens.registration.passwordRepeatField
class _TranslationsMobileScreensRegistrationPasswordRepeatFieldEn extends _TranslationsMobileScreensRegistrationPasswordRepeatFieldRu {
	_TranslationsMobileScreensRegistrationPasswordRepeatFieldEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Confirm password';
	@override late final _TranslationsMobileScreensRegistrationPasswordRepeatFieldErrorsEn errors = _TranslationsMobileScreensRegistrationPasswordRepeatFieldErrorsEn._(_root);
}

// Path: mobileScreens.registration.smsSwitch
class _TranslationsMobileScreensRegistrationSmsSwitchEn extends _TranslationsMobileScreensRegistrationSmsSwitchRu {
	_TranslationsMobileScreensRegistrationSmsSwitchEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get tilte => 'Send verification code via SMS';
}

// Path: mobileScreens.registration.phoneField
class _TranslationsMobileScreensRegistrationPhoneFieldEn extends _TranslationsMobileScreensRegistrationPhoneFieldRu {
	_TranslationsMobileScreensRegistrationPhoneFieldEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Phone number';
	@override late final _TranslationsMobileScreensRegistrationPhoneFieldErrorsEn errors = _TranslationsMobileScreensRegistrationPhoneFieldErrorsEn._(_root);
}

// Path: mobileScreens.registrationCode.codeField
class _TranslationsMobileScreensRegistrationCodeCodeFieldEn extends _TranslationsMobileScreensRegistrationCodeCodeFieldRu {
	_TranslationsMobileScreensRegistrationCodeCodeFieldEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensRegistrationCodeCodeFieldTitleEn title = _TranslationsMobileScreensRegistrationCodeCodeFieldTitleEn._(_root);
	@override late final _TranslationsMobileScreensRegistrationCodeCodeFieldErrorsEn errors = _TranslationsMobileScreensRegistrationCodeCodeFieldErrorsEn._(_root);
}

// Path: mobileScreens.registrationParams.paramDateField
class _TranslationsMobileScreensRegistrationParamsParamDateFieldEn extends _TranslationsMobileScreensRegistrationParamsParamDateFieldRu {
	_TranslationsMobileScreensRegistrationParamsParamDateFieldEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensRegistrationParamsParamDateFieldErrorsEn errors = _TranslationsMobileScreensRegistrationParamsParamDateFieldErrorsEn._(_root);
}

// Path: mobileScreens.registrationParams.paramField
class _TranslationsMobileScreensRegistrationParamsParamFieldEn extends _TranslationsMobileScreensRegistrationParamsParamFieldRu {
	_TranslationsMobileScreensRegistrationParamsParamFieldEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensRegistrationParamsParamFieldErrorsEn errors = _TranslationsMobileScreensRegistrationParamsParamFieldErrorsEn._(_root);
}

// Path: mobileScreens.main.menu
class _TranslationsMobileScreensMainMenuEn extends _TranslationsMobileScreensMainMenuRu {
	_TranslationsMobileScreensMainMenuEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get history => 'History';
	@override String get userGuide => 'Guide';
	@override String get products => 'Products';
	@override String get accruals => 'Organisations';
	@override String get claims => 'Сlaims';
	@override String get payments => 'Payments';
	@override String get profile => 'Profile';
	@override String get scanQr => 'Scanner';
	@override String get qrPayment => 'My QR';
}

// Path: mobileScreens.paymentsHistoryFilters.dateFromField
class _TranslationsMobileScreensPaymentsHistoryFiltersDateFromFieldEn extends _TranslationsMobileScreensPaymentsHistoryFiltersDateFromFieldRu {
	_TranslationsMobileScreensPaymentsHistoryFiltersDateFromFieldEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get tilte => 'from';
	@override late final _TranslationsMobileScreensPaymentsHistoryFiltersDateFromFieldErrorsEn errors = _TranslationsMobileScreensPaymentsHistoryFiltersDateFromFieldErrorsEn._(_root);
}

// Path: mobileScreens.paymentsHistoryFilters.dateToField
class _TranslationsMobileScreensPaymentsHistoryFiltersDateToFieldEn extends _TranslationsMobileScreensPaymentsHistoryFiltersDateToFieldRu {
	_TranslationsMobileScreensPaymentsHistoryFiltersDateToFieldEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get tilte => 'to';
	@override late final _TranslationsMobileScreensPaymentsHistoryFiltersDateToFieldErrorsEn errors = _TranslationsMobileScreensPaymentsHistoryFiltersDateToFieldErrorsEn._(_root);
}

// Path: mobileScreens.products.mainProductTitle
class _TranslationsMobileScreensProductsMainProductTitleEn extends _TranslationsMobileScreensProductsMainProductTitleRu {
	_TranslationsMobileScreensProductsMainProductTitleEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get account => 'Main account';
	@override String get card => 'Main card';
}

// Path: mobileScreens.products.productsSegmentControlTitle
class _TranslationsMobileScreensProductsProductsSegmentControlTitleEn extends _TranslationsMobileScreensProductsProductsSegmentControlTitleRu {
	_TranslationsMobileScreensProductsProductsSegmentControlTitleEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get account => 'Accounts';
	@override String get card => 'Cards';
}

// Path: mobileScreens.payment.modal
class _TranslationsMobileScreensPaymentModalEn extends _TranslationsMobileScreensPaymentModalRu {
	_TranslationsMobileScreensPaymentModalEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensPaymentModalErrorEn error = _TranslationsMobileScreensPaymentModalErrorEn._(_root);
}

// Path: mobileScreens.payment.fieldsPage
class _TranslationsMobileScreensPaymentFieldsPageEn extends _TranslationsMobileScreensPaymentFieldsPageRu {
	_TranslationsMobileScreensPaymentFieldsPageEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensPaymentFieldsPageParamFieldEn paramField = _TranslationsMobileScreensPaymentFieldsPageParamFieldEn._(_root);
	@override String get nextButton => 'Further';
}

// Path: mobileScreens.payment.serviceResultPage
class _TranslationsMobileScreensPaymentServiceResultPageEn extends _TranslationsMobileScreensPaymentServiceResultPageRu {
	_TranslationsMobileScreensPaymentServiceResultPageEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get nextButton => 'Pay';
}

// Path: mobileScreens.payment.attrDate
class _TranslationsMobileScreensPaymentAttrDateEn extends _TranslationsMobileScreensPaymentAttrDateRu {
	_TranslationsMobileScreensPaymentAttrDateEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensPaymentAttrDateErrorsEn errors = _TranslationsMobileScreensPaymentAttrDateErrorsEn._(_root);
}

// Path: mobileScreens.productAdd.modal
class _TranslationsMobileScreensProductAddModalEn extends _TranslationsMobileScreensProductAddModalRu {
	_TranslationsMobileScreensProductAddModalEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensProductAddModalSuccessEn success = _TranslationsMobileScreensProductAddModalSuccessEn._(_root);
}

// Path: mobileScreens.productAdd.productSelector
class _TranslationsMobileScreensProductAddProductSelectorEn extends _TranslationsMobileScreensProductAddProductSelectorRu {
	_TranslationsMobileScreensProductAddProductSelectorEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get account => 'Account';
	@override String get card => 'Card';
}

// Path: mobileScreens.productAdd.accountForm
class _TranslationsMobileScreensProductAddAccountFormEn extends _TranslationsMobileScreensProductAddAccountFormRu {
	_TranslationsMobileScreensProductAddAccountFormEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensProductAddAccountFormAccountNumberFieldEn accountNumberField = _TranslationsMobileScreensProductAddAccountFormAccountNumberFieldEn._(_root);
	@override late final _TranslationsMobileScreensProductAddAccountFormParamFieldEn paramField = _TranslationsMobileScreensProductAddAccountFormParamFieldEn._(_root);
	@override String get addButton => 'Add account';
}

// Path: mobileScreens.productAdd.cardForm
class _TranslationsMobileScreensProductAddCardFormEn extends _TranslationsMobileScreensProductAddCardFormRu {
	_TranslationsMobileScreensProductAddCardFormEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensProductAddCardFormCardNumberFieldEn cardNumberField = _TranslationsMobileScreensProductAddCardFormCardNumberFieldEn._(_root);
	@override late final _TranslationsMobileScreensProductAddCardFormExpiryFieldEn expiryField = _TranslationsMobileScreensProductAddCardFormExpiryFieldEn._(_root);
	@override late final _TranslationsMobileScreensProductAddCardFormCvvFieldEn cvvField = _TranslationsMobileScreensProductAddCardFormCvvFieldEn._(_root);
	@override late final _TranslationsMobileScreensProductAddCardFormParamFieldEn paramField = _TranslationsMobileScreensProductAddCardFormParamFieldEn._(_root);
	@override String get addButton => 'Add a card';
}

// Path: mobileScreens.productAdd.paramDate
class _TranslationsMobileScreensProductAddParamDateEn extends _TranslationsMobileScreensProductAddParamDateRu {
	_TranslationsMobileScreensProductAddParamDateEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensProductAddParamDateErrorsEn errors = _TranslationsMobileScreensProductAddParamDateErrorsEn._(_root);
}

// Path: mobileScreens.cardInfo.properties
class _TranslationsMobileScreensCardInfoPropertiesEn extends _TranslationsMobileScreensCardInfoPropertiesRu {
	_TranslationsMobileScreensCardInfoPropertiesEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get number => 'Card number';
	@override String get expirationDate => 'Validaty';
}

// Path: mobileScreens.cardInfo.modal
class _TranslationsMobileScreensCardInfoModalEn extends _TranslationsMobileScreensCardInfoModalRu {
	_TranslationsMobileScreensCardInfoModalEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensCardInfoModalDeleteProductEn deleteProduct = _TranslationsMobileScreensCardInfoModalDeleteProductEn._(_root);
	@override late final _TranslationsMobileScreensCardInfoModalSuccesProductDeleteEn succesProductDelete = _TranslationsMobileScreensCardInfoModalSuccesProductDeleteEn._(_root);
}

// Path: mobileScreens.cardInfo.editName
class _TranslationsMobileScreensCardInfoEditNameEn extends _TranslationsMobileScreensCardInfoEditNameRu {
	_TranslationsMobileScreensCardInfoEditNameEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensCardInfoEditNameParamFieldEn paramField = _TranslationsMobileScreensCardInfoEditNameParamFieldEn._(_root);
	@override String get doneButton => 'Done';
}

// Path: mobileScreens.accountInfo.properties
class _TranslationsMobileScreensAccountInfoPropertiesEn extends _TranslationsMobileScreensAccountInfoPropertiesRu {
	_TranslationsMobileScreensAccountInfoPropertiesEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get number => 'Account number';
}

// Path: mobileScreens.accountInfo.modal
class _TranslationsMobileScreensAccountInfoModalEn extends _TranslationsMobileScreensAccountInfoModalRu {
	_TranslationsMobileScreensAccountInfoModalEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensAccountInfoModalDeleteProductEn deleteProduct = _TranslationsMobileScreensAccountInfoModalDeleteProductEn._(_root);
	@override late final _TranslationsMobileScreensAccountInfoModalSuccesProductDeleteEn succesProductDelete = _TranslationsMobileScreensAccountInfoModalSuccesProductDeleteEn._(_root);
}

// Path: mobileScreens.accountInfo.editName
class _TranslationsMobileScreensAccountInfoEditNameEn extends _TranslationsMobileScreensAccountInfoEditNameRu {
	_TranslationsMobileScreensAccountInfoEditNameEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensAccountInfoEditNameParamFieldEn paramField = _TranslationsMobileScreensAccountInfoEditNameParamFieldEn._(_root);
	@override String get doneButton => 'Done';
}

// Path: mobileScreens.profile.settingsItem
class _TranslationsMobileScreensProfileSettingsItemEn extends _TranslationsMobileScreensProfileSettingsItemRu {
	_TranslationsMobileScreensProfileSettingsItemEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Settings';
}

// Path: mobileScreens.profile.logOutItem
class _TranslationsMobileScreensProfileLogOutItemEn extends _TranslationsMobileScreensProfileLogOutItemRu {
	_TranslationsMobileScreensProfileLogOutItemEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Exit';
}

// Path: mobileScreens.profileEdit.modal
class _TranslationsMobileScreensProfileEditModalEn extends _TranslationsMobileScreensProfileEditModalRu {
	_TranslationsMobileScreensProfileEditModalEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensProfileEditModalSuccessEn success = _TranslationsMobileScreensProfileEditModalSuccessEn._(_root);
}

// Path: mobileScreens.profileEdit.paramField
class _TranslationsMobileScreensProfileEditParamFieldEn extends _TranslationsMobileScreensProfileEditParamFieldRu {
	_TranslationsMobileScreensProfileEditParamFieldEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensProfileEditParamFieldErrorsEn errors = _TranslationsMobileScreensProfileEditParamFieldErrorsEn._(_root);
}

// Path: mobileScreens.settings.modal
class _TranslationsMobileScreensSettingsModalEn extends _TranslationsMobileScreensSettingsModalRu {
	_TranslationsMobileScreensSettingsModalEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensSettingsModalChangePinSuccessEn changePinSuccess = _TranslationsMobileScreensSettingsModalChangePinSuccessEn._(_root);
}

// Path: mobileScreens.settings.sections
class _TranslationsMobileScreensSettingsSectionsEn extends _TranslationsMobileScreensSettingsSectionsRu {
	_TranslationsMobileScreensSettingsSectionsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensSettingsSectionsAccessEn access = _TranslationsMobileScreensSettingsSectionsAccessEn._(_root);
	@override late final _TranslationsMobileScreensSettingsSectionsAccountEn account = _TranslationsMobileScreensSettingsSectionsAccountEn._(_root);
	@override late final _TranslationsMobileScreensSettingsSectionsDeleteAccountEn deleteAccount = _TranslationsMobileScreensSettingsSectionsDeleteAccountEn._(_root);
}

// Path: mobileScreens.settings.authWithBiometricsItem
class _TranslationsMobileScreensSettingsAuthWithBiometricsItemEn extends _TranslationsMobileScreensSettingsAuthWithBiometricsItemRu {
	_TranslationsMobileScreensSettingsAuthWithBiometricsItemEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get biometricDescription => 'biometrics';
	@override String message({required Object biometricDescription}) => 'Enter with ${biometricDescription}';
}

// Path: mobileScreens.changePassword.oldPasswordField
class _TranslationsMobileScreensChangePasswordOldPasswordFieldEn extends _TranslationsMobileScreensChangePasswordOldPasswordFieldRu {
	_TranslationsMobileScreensChangePasswordOldPasswordFieldEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Old password';
	@override late final _TranslationsMobileScreensChangePasswordOldPasswordFieldErrorsEn errors = _TranslationsMobileScreensChangePasswordOldPasswordFieldErrorsEn._(_root);
}

// Path: mobileScreens.changePassword.newPasswordField
class _TranslationsMobileScreensChangePasswordNewPasswordFieldEn extends _TranslationsMobileScreensChangePasswordNewPasswordFieldRu {
	_TranslationsMobileScreensChangePasswordNewPasswordFieldEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'New password';
	@override late final _TranslationsMobileScreensChangePasswordNewPasswordFieldErrorsEn errors = _TranslationsMobileScreensChangePasswordNewPasswordFieldErrorsEn._(_root);
}

// Path: mobileScreens.changePassword.newPasswordRepeatField
class _TranslationsMobileScreensChangePasswordNewPasswordRepeatFieldEn extends _TranslationsMobileScreensChangePasswordNewPasswordRepeatFieldRu {
	_TranslationsMobileScreensChangePasswordNewPasswordRepeatFieldEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Confirm new password';
	@override late final _TranslationsMobileScreensChangePasswordNewPasswordRepeatFieldErrorsEn errors = _TranslationsMobileScreensChangePasswordNewPasswordRepeatFieldErrorsEn._(_root);
}

// Path: mobileScreens.qrScan.flashButton
class _TranslationsMobileScreensQrScanFlashButtonEn extends _TranslationsMobileScreensQrScanFlashButtonRu {
	_TranslationsMobileScreensQrScanFlashButtonEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get turnOn => 'Turn on flash';
	@override String get turnOff => 'Turn off flash';
}

// Path: mobileScreens.qrScan.modal
class _TranslationsMobileScreensQrScanModalEn extends _TranslationsMobileScreensQrScanModalRu {
	_TranslationsMobileScreensQrScanModalEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensQrScanModalErrorEn error = _TranslationsMobileScreensQrScanModalErrorEn._(_root);
}

// Path: mobileScreens.qrScan.qrCam
class _TranslationsMobileScreensQrScanQrCamEn extends _TranslationsMobileScreensQrScanQrCamRu {
	_TranslationsMobileScreensQrScanQrCamEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensQrScanQrCamPermissionsEn permissions = _TranslationsMobileScreensQrScanQrCamPermissionsEn._(_root);
	@override String get providePermissionButton => 'Provide permission';
	@override String get scanMessage => 'Point your camera at the QR code';
}

// Path: mobileScreens.mdomAccruals.accountItem
class _TranslationsMobileScreensMdomAccrualsAccountItemEn extends _TranslationsMobileScreensMdomAccrualsAccountItemRu {
	_TranslationsMobileScreensMdomAccrualsAccountItemEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Account number';
	@override String get underConsideration => 'Under consideration';
	@override String get waitingRegistration => 'Waiting for client registration';
}

// Path: mobileScreens.mdomAccruals.pollItem
class _TranslationsMobileScreensMdomAccrualsPollItemEn extends _TranslationsMobileScreensMdomAccrualsPollItemRu {
	_TranslationsMobileScreensMdomAccrualsPollItemEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Polls';
	@override String get newLabel => 'new';
}

// Path: mobileScreens.mdomNotificationsScreen.successModal
class _TranslationsMobileScreensMdomNotificationsScreenSuccessModalEn extends _TranslationsMobileScreensMdomNotificationsScreenSuccessModalRu {
	_TranslationsMobileScreensMdomNotificationsScreenSuccessModalEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Success';
}

// Path: mobileScreens.mdomAccountAdd.successModal
class _TranslationsMobileScreensMdomAccountAddSuccessModalEn extends _TranslationsMobileScreensMdomAccountAddSuccessModalRu {
	_TranslationsMobileScreensMdomAccountAddSuccessModalEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Successfully';
	@override String get text => 'Account added';
}

// Path: mobileScreens.mdomAccountAdd.accountNumberField
class _TranslationsMobileScreensMdomAccountAddAccountNumberFieldEn extends _TranslationsMobileScreensMdomAccountAddAccountNumberFieldRu {
	_TranslationsMobileScreensMdomAccountAddAccountNumberFieldEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Account number';
	@override late final _TranslationsMobileScreensMdomAccountAddAccountNumberFieldErrorsEn errors = _TranslationsMobileScreensMdomAccountAddAccountNumberFieldErrorsEn._(_root);
}

// Path: mobileScreens.mdomAccountAdd.codeWordField
class _TranslationsMobileScreensMdomAccountAddCodeWordFieldEn extends _TranslationsMobileScreensMdomAccountAddCodeWordFieldRu {
	_TranslationsMobileScreensMdomAccountAddCodeWordFieldEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Code word';
	@override late final _TranslationsMobileScreensMdomAccountAddCodeWordFieldErrorsEn errors = _TranslationsMobileScreensMdomAccountAddCodeWordFieldErrorsEn._(_root);
}

// Path: mobileScreens.mdomAccountAdd.supplierIdField
class _TranslationsMobileScreensMdomAccountAddSupplierIdFieldEn extends _TranslationsMobileScreensMdomAccountAddSupplierIdFieldRu {
	_TranslationsMobileScreensMdomAccountAddSupplierIdFieldEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Organization ID';
	@override late final _TranslationsMobileScreensMdomAccountAddSupplierIdFieldErrorsEn errors = _TranslationsMobileScreensMdomAccountAddSupplierIdFieldErrorsEn._(_root);
}

// Path: mobileScreens.mdomCompanyChoise.searchField
class _TranslationsMobileScreensMdomCompanyChoiseSearchFieldEn extends _TranslationsMobileScreensMdomCompanyChoiseSearchFieldRu {
	_TranslationsMobileScreensMdomCompanyChoiseSearchFieldEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get hint => 'Search';
}

// Path: mobileScreens.mdomCompanySearch.searchField
class _TranslationsMobileScreensMdomCompanySearchSearchFieldEn extends _TranslationsMobileScreensMdomCompanySearchSearchFieldRu {
	_TranslationsMobileScreensMdomCompanySearchSearchFieldEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get hint => 'Search';
}

// Path: mobileScreens.mdomCompanySearch.unpField
class _TranslationsMobileScreensMdomCompanySearchUnpFieldEn extends _TranslationsMobileScreensMdomCompanySearchUnpFieldRu {
	_TranslationsMobileScreensMdomCompanySearchUnpFieldEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'PAN';
	@override late final _TranslationsMobileScreensMdomCompanySearchUnpFieldErrorsEn errors = _TranslationsMobileScreensMdomCompanySearchUnpFieldErrorsEn._(_root);
}

// Path: mobileScreens.mdomCompanySearch.nameField
class _TranslationsMobileScreensMdomCompanySearchNameFieldEn extends _TranslationsMobileScreensMdomCompanySearchNameFieldRu {
	_TranslationsMobileScreensMdomCompanySearchNameFieldEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Name of company';
	@override late final _TranslationsMobileScreensMdomCompanySearchNameFieldErrorsEn errors = _TranslationsMobileScreensMdomCompanySearchNameFieldErrorsEn._(_root);
}

// Path: mobileScreens.mdomCompanySearch.errors
class _TranslationsMobileScreensMdomCompanySearchErrorsEn extends _TranslationsMobileScreensMdomCompanySearchErrorsRu {
	_TranslationsMobileScreensMdomCompanySearchErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Organization not found';
}

// Path: mobileScreens.mdomAccountInfo.periodSection
class _TranslationsMobileScreensMdomAccountInfoPeriodSectionEn extends _TranslationsMobileScreensMdomAccountInfoPeriodSectionRu {
	_TranslationsMobileScreensMdomAccountInfoPeriodSectionEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get tilte => 'Period';
}

// Path: mobileScreens.mdomAccountInfo.chargingSection
class _TranslationsMobileScreensMdomAccountInfoChargingSectionEn extends _TranslationsMobileScreensMdomAccountInfoChargingSectionRu {
	_TranslationsMobileScreensMdomAccountInfoChargingSectionEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get tilte => 'Charging statistics';
}

// Path: mobileScreens.mdomAccountInfo.paySection
class _TranslationsMobileScreensMdomAccountInfoPaySectionEn extends _TranslationsMobileScreensMdomAccountInfoPaySectionRu {
	_TranslationsMobileScreensMdomAccountInfoPaySectionEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get tilte => 'Payment statistics';
}

// Path: mobileScreens.mdomAccountInfo.chargingSectionInfo
class _TranslationsMobileScreensMdomAccountInfoChargingSectionInfoEn extends _TranslationsMobileScreensMdomAccountInfoChargingSectionInfoRu {
	_TranslationsMobileScreensMdomAccountInfoChargingSectionInfoEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get remainder => 'Carryover';
	@override String get fine => 'Fine';
	@override String get paid => 'Paid';
	@override String get total => 'Total accrued';
}

// Path: mobileScreens.mdomAccountInfo.serviceSection
class _TranslationsMobileScreensMdomAccountInfoServiceSectionEn extends _TranslationsMobileScreensMdomAccountInfoServiceSectionRu {
	_TranslationsMobileScreensMdomAccountInfoServiceSectionEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get tilte => 'Service statistics';
	@override late final _TranslationsMobileScreensMdomAccountInfoServiceSectionItemEn item = _TranslationsMobileScreensMdomAccountInfoServiceSectionItemEn._(_root);
}

// Path: mobileScreens.mdomAccountInfo.serviceSectionInfo
class _TranslationsMobileScreensMdomAccountInfoServiceSectionInfoEn extends _TranslationsMobileScreensMdomAccountInfoServiceSectionInfoRu {
	_TranslationsMobileScreensMdomAccountInfoServiceSectionInfoEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensMdomAccountInfoServiceSectionInfoItemEn item = _TranslationsMobileScreensMdomAccountInfoServiceSectionInfoItemEn._(_root);
}

// Path: mobileScreens.mdomAccountInfo.requirementsInfo
class _TranslationsMobileScreensMdomAccountInfoRequirementsInfoEn extends _TranslationsMobileScreensMdomAccountInfoRequirementsInfoRu {
	_TranslationsMobileScreensMdomAccountInfoRequirementsInfoEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get dateStart => 'Claim start date:';
	@override String get dateEnd => 'Claim end date:';
	@override String get accrued => 'Total amount of payments on demand:';
	@override String get total => 'Amount to pay:';
}

// Path: mobileScreens.mdomAccountInfo.payButton
class _TranslationsMobileScreensMdomAccountInfoPayButtonEn extends _TranslationsMobileScreensMdomAccountInfoPayButtonRu {
	_TranslationsMobileScreensMdomAccountInfoPayButtonEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get noPayments => 'Done';
	@override String needPay({required Object amount, required Object currency}) => 'Pay ${amount} ${currency}';
	@override String noNeedPay({required Object amount, required Object currency}) => 'Overpayment ${amount} ${currency}';
}

// Path: mobileScreens.mdomPeriodCustom.dateField
class _TranslationsMobileScreensMdomPeriodCustomDateFieldEn extends _TranslationsMobileScreensMdomPeriodCustomDateFieldRu {
	_TranslationsMobileScreensMdomPeriodCustomDateFieldEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensMdomPeriodCustomDateFieldErrorsEn errors = _TranslationsMobileScreensMdomPeriodCustomDateFieldErrorsEn._(_root);
}

// Path: mobileScreens.mdomPeriodCustom.dateFromField
class _TranslationsMobileScreensMdomPeriodCustomDateFromFieldEn extends _TranslationsMobileScreensMdomPeriodCustomDateFromFieldRu {
	_TranslationsMobileScreensMdomPeriodCustomDateFromFieldEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get tilte => 'Period beginning';
	@override String get hint => '01/01/2022';
	@override late final _TranslationsMobileScreensMdomPeriodCustomDateFromFieldErrorsEn errors = _TranslationsMobileScreensMdomPeriodCustomDateFromFieldErrorsEn._(_root);
}

// Path: mobileScreens.mdomPeriodCustom.dateToField
class _TranslationsMobileScreensMdomPeriodCustomDateToFieldEn extends _TranslationsMobileScreensMdomPeriodCustomDateToFieldRu {
	_TranslationsMobileScreensMdomPeriodCustomDateToFieldEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get tilte => 'Period end';
	@override String get hint => '01/02/2022';
	@override late final _TranslationsMobileScreensMdomPeriodCustomDateToFieldErrorsEn errors = _TranslationsMobileScreensMdomPeriodCustomDateToFieldErrorsEn._(_root);
}

// Path: mobileScreens.mdomPollsList.currentStatus
class _TranslationsMobileScreensMdomPollsListCurrentStatusEn extends _TranslationsMobileScreensMdomPollsListCurrentStatusRu {
	_TranslationsMobileScreensMdomPollsListCurrentStatusEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Status';
}

// Path: mobileScreens.mdomPollsList.pollItem
class _TranslationsMobileScreensMdomPollsListPollItemEn extends _TranslationsMobileScreensMdomPollsListPollItemRu {
	_TranslationsMobileScreensMdomPollsListPollItemEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensMdomPollsListPollItemVotedTextEn votedText = _TranslationsMobileScreensMdomPollsListPollItemVotedTextEn._(_root);
	@override String startText({required Object date}) => 'Will begin ${date}';
	@override String completedText({required Object date}) => 'Completed ${date}';
	@override String get endingText => 'Ending';
}

// Path: mobileScreens.mdomPollsListFilters.statusPicker
class _TranslationsMobileScreensMdomPollsListFiltersStatusPickerEn extends _TranslationsMobileScreensMdomPollsListFiltersStatusPickerRu {
	_TranslationsMobileScreensMdomPollsListFiltersStatusPickerEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Status';
}

// Path: mobileScreens.mdomPollsListFilters.endDateRangePicker
class _TranslationsMobileScreensMdomPollsListFiltersEndDateRangePickerEn extends _TranslationsMobileScreensMdomPollsListFiltersEndDateRangePickerRu {
	_TranslationsMobileScreensMdomPollsListFiltersEndDateRangePickerEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'End of voting';
	@override String get calendarModalTitle => 'End of voting';
}

// Path: mobileScreens.mdomPoll.title
class _TranslationsMobileScreensMdomPollTitleEn extends _TranslationsMobileScreensMdomPollTitleRu {
	_TranslationsMobileScreensMdomPollTitleEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get expandText => 'show';
	@override String get collapseText => 'hide';
}

// Path: mobileScreens.mdomPoll.modal
class _TranslationsMobileScreensMdomPollModalEn extends _TranslationsMobileScreensMdomPollModalRu {
	_TranslationsMobileScreensMdomPollModalEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get successVote => 'Your answers have been sent';
	@override String get successEdit => 'Your answers have been updated';
}

// Path: mobileScreens.mdomPoll.info
class _TranslationsMobileScreensMdomPollInfoEn extends _TranslationsMobileScreensMdomPollInfoRu {
	_TranslationsMobileScreensMdomPollInfoEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get ending => 'Ending';
}

// Path: mobileScreens.mdomPoll.questionsList
class _TranslationsMobileScreensMdomPollQuestionsListEn extends _TranslationsMobileScreensMdomPollQuestionsListRu {
	_TranslationsMobileScreensMdomPollQuestionsListEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Questions';
	@override String get votedText => 'You voted';
	@override String startText({required Object date}) => 'Will begin ${date}';
	@override String completedText({required Object date}) => 'Completed ${date}';
}

// Path: mobileScreens.mdomPoll.voteButton
class _TranslationsMobileScreensMdomPollVoteButtonEn extends _TranslationsMobileScreensMdomPollVoteButtonRu {
	_TranslationsMobileScreensMdomPollVoteButtonEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get vote => 'Vote';
	@override String get edit => 'Save';
}

// Path: mobileScreens.mdomPollStatisticsQuestion.answersTitle
class _TranslationsMobileScreensMdomPollStatisticsQuestionAnswersTitleEn extends _TranslationsMobileScreensMdomPollStatisticsQuestionAnswersTitleRu {
	_TranslationsMobileScreensMdomPollStatisticsQuestionAnswersTitleEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get yes => 'Yes';
	@override String get no => 'No';
	@override String get abstain => 'Abstained';
}

// Path: models.period.names
class _TranslationsModelsPeriodNamesEn extends _TranslationsModelsPeriodNamesRu {
	_TranslationsModelsPeriodNamesEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get notSet => 'Unknown';
	@override String get month => 'Month';
	@override String get quarter => 'Quarter';
	@override String get year => 'Year';
	@override String get custom => 'Custom period';
}

// Path: models.period.selectedNames
class _TranslationsModelsPeriodSelectedNamesEn extends _TranslationsModelsPeriodSelectedNamesRu {
	_TranslationsModelsPeriodSelectedNamesEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get notSet => 'Select period';
	@override String month({required Object month, required Object year}) => '${month} ${year}';
	@override String quarter({required Object quarter, required Object year}) => '${quarter} quarter ${year}';
	@override String year({required Object year}) => '${year} year';
	@override String custom({required Object startDate, required Object endDate}) => '${startDate} - ${endDate}';
}

// Path: models.pollAnswer.active
class _TranslationsModelsPollAnswerActiveEn extends _TranslationsModelsPollAnswerActiveRu {
	_TranslationsModelsPollAnswerActiveEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get yes => 'Yes';
	@override String get no => 'No';
	@override String get abstain => 'Abstain';
}

// Path: models.pollAnswer.voted
class _TranslationsModelsPollAnswerVotedEn extends _TranslationsModelsPollAnswerVotedRu {
	_TranslationsModelsPollAnswerVotedEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get yes => 'Yes';
	@override String get no => 'No';
	@override String get abstain => 'Abstain';
}

// Path: widgets.refreshFooter.statuses
class _TranslationsWidgetsRefreshFooterStatusesEn extends _TranslationsWidgetsRefreshFooterStatusesRu {
	_TranslationsWidgetsRefreshFooterStatusesEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get noMoreData => 'No more data';
	@override String get idle => 'Load more';
	@override String get failed => 'Server communication error';
	@override String get canLoading => 'Release to load more';
}

// Path: widgets.emailField.errors
class _TranslationsWidgetsEmailFieldErrorsEn extends _TranslationsWidgetsEmailFieldErrorsRu {
	_TranslationsWidgetsEmailFieldErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get incorrect => 'Invalid E-mail format';
	@override String get empty => 'Enter E-mail';
}

// Path: widgets.fioField.errors
class _TranslationsWidgetsFioFieldErrorsEn extends _TranslationsWidgetsFioFieldErrorsRu {
	_TranslationsWidgetsFioFieldErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get incorrect => 'Invalid format';
	@override String get empty => 'Enter credentials';
}

// Path: widgets.passwordField.errors
class _TranslationsWidgetsPasswordFieldErrorsEn extends _TranslationsWidgetsPasswordFieldErrorsRu {
	_TranslationsWidgetsPasswordFieldErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Enter password';
	@override String minLength({required Object minLength}) => 'Minimum password length ${minLength} characters';
}

// Path: modal.pinSetup.title
class _TranslationsModalPinSetupTitleEn extends _TranslationsModalPinSetupTitleRu {
	_TranslationsModalPinSetupTitleEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get first => 'Enter new PIN';
	@override String get repeat => 'Repeat new PIN';
}

// Path: mobileScreens.registration.passwordRepeatField.errors
class _TranslationsMobileScreensRegistrationPasswordRepeatFieldErrorsEn extends _TranslationsMobileScreensRegistrationPasswordRepeatFieldErrorsRu {
	_TranslationsMobileScreensRegistrationPasswordRepeatFieldErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get passwordsNotMatch => 'Passwords do not match';
}

// Path: mobileScreens.registration.phoneField.errors
class _TranslationsMobileScreensRegistrationPhoneFieldErrorsEn extends _TranslationsMobileScreensRegistrationPhoneFieldErrorsRu {
	_TranslationsMobileScreensRegistrationPhoneFieldErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get incorrectFormat => 'Wrong format';
	@override String get empty => 'Required field';
}

// Path: mobileScreens.registrationCode.codeField.title
class _TranslationsMobileScreensRegistrationCodeCodeFieldTitleEn extends _TranslationsMobileScreensRegistrationCodeCodeFieldTitleRu {
	_TranslationsMobileScreensRegistrationCodeCodeFieldTitleEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get email => 'Code from E-mail';
	@override String get sms => 'Code from SMS';
}

// Path: mobileScreens.registrationCode.codeField.errors
class _TranslationsMobileScreensRegistrationCodeCodeFieldErrorsEn extends _TranslationsMobileScreensRegistrationCodeCodeFieldErrorsRu {
	_TranslationsMobileScreensRegistrationCodeCodeFieldErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get incorrectFormat => 'Wrong format';
	@override String get empty => 'Required field';
}

// Path: mobileScreens.registrationParams.paramDateField.errors
class _TranslationsMobileScreensRegistrationParamsParamDateFieldErrorsEn extends _TranslationsMobileScreensRegistrationParamsParamDateFieldErrorsRu {
	_TranslationsMobileScreensRegistrationParamsParamDateFieldErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get general => 'Incorrect date';
}

// Path: mobileScreens.registrationParams.paramField.errors
class _TranslationsMobileScreensRegistrationParamsParamFieldErrorsEn extends _TranslationsMobileScreensRegistrationParamsParamFieldErrorsRu {
	_TranslationsMobileScreensRegistrationParamsParamFieldErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Required field';
	@override String minLength({required Object minLength}) => 'Minimum length ${minLength}';
}

// Path: mobileScreens.paymentsHistoryFilters.dateFromField.errors
class _TranslationsMobileScreensPaymentsHistoryFiltersDateFromFieldErrorsEn extends _TranslationsMobileScreensPaymentsHistoryFiltersDateFromFieldErrorsRu {
	_TranslationsMobileScreensPaymentsHistoryFiltersDateFromFieldErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get dateIsAfter => 'Error';
	@override String get empty => 'Error';
}

// Path: mobileScreens.paymentsHistoryFilters.dateToField.errors
class _TranslationsMobileScreensPaymentsHistoryFiltersDateToFieldErrorsEn extends _TranslationsMobileScreensPaymentsHistoryFiltersDateToFieldErrorsRu {
	_TranslationsMobileScreensPaymentsHistoryFiltersDateToFieldErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get dateIsBefore => 'Error';
	@override String get empty => 'Error';
}

// Path: mobileScreens.payment.modal.error
class _TranslationsMobileScreensPaymentModalErrorEn extends _TranslationsMobileScreensPaymentModalErrorRu {
	_TranslationsMobileScreensPaymentModalErrorEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Error';
	@override String get repeatButton => 'Repeat';
	@override String get doneButton => 'Ok';
}

// Path: mobileScreens.payment.fieldsPage.paramField
class _TranslationsMobileScreensPaymentFieldsPageParamFieldEn extends _TranslationsMobileScreensPaymentFieldsPageParamFieldRu {
	_TranslationsMobileScreensPaymentFieldsPageParamFieldEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensPaymentFieldsPageParamFieldErrorsEn errors = _TranslationsMobileScreensPaymentFieldsPageParamFieldErrorsEn._(_root);
}

// Path: mobileScreens.payment.attrDate.errors
class _TranslationsMobileScreensPaymentAttrDateErrorsEn extends _TranslationsMobileScreensPaymentAttrDateErrorsRu {
	_TranslationsMobileScreensPaymentAttrDateErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get general => 'Incorrect date';
}

// Path: mobileScreens.productAdd.modal.success
class _TranslationsMobileScreensProductAddModalSuccessEn extends _TranslationsMobileScreensProductAddModalSuccessRu {
	_TranslationsMobileScreensProductAddModalSuccessEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Successfully';
	@override late final _TranslationsMobileScreensProductAddModalSuccessMessageEn message = _TranslationsMobileScreensProductAddModalSuccessMessageEn._(_root);
}

// Path: mobileScreens.productAdd.accountForm.accountNumberField
class _TranslationsMobileScreensProductAddAccountFormAccountNumberFieldEn extends _TranslationsMobileScreensProductAddAccountFormAccountNumberFieldRu {
	_TranslationsMobileScreensProductAddAccountFormAccountNumberFieldEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get tilte => 'Account number*';
	@override late final _TranslationsMobileScreensProductAddAccountFormAccountNumberFieldErrorsEn errors = _TranslationsMobileScreensProductAddAccountFormAccountNumberFieldErrorsEn._(_root);
}

// Path: mobileScreens.productAdd.accountForm.paramField
class _TranslationsMobileScreensProductAddAccountFormParamFieldEn extends _TranslationsMobileScreensProductAddAccountFormParamFieldRu {
	_TranslationsMobileScreensProductAddAccountFormParamFieldEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensProductAddAccountFormParamFieldErrorsEn errors = _TranslationsMobileScreensProductAddAccountFormParamFieldErrorsEn._(_root);
}

// Path: mobileScreens.productAdd.cardForm.cardNumberField
class _TranslationsMobileScreensProductAddCardFormCardNumberFieldEn extends _TranslationsMobileScreensProductAddCardFormCardNumberFieldRu {
	_TranslationsMobileScreensProductAddCardFormCardNumberFieldEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get tilte => 'Card number*';
	@override late final _TranslationsMobileScreensProductAddCardFormCardNumberFieldErrorsEn errors = _TranslationsMobileScreensProductAddCardFormCardNumberFieldErrorsEn._(_root);
}

// Path: mobileScreens.productAdd.cardForm.expiryField
class _TranslationsMobileScreensProductAddCardFormExpiryFieldEn extends _TranslationsMobileScreensProductAddCardFormExpiryFieldRu {
	_TranslationsMobileScreensProductAddCardFormExpiryFieldEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get tilte => 'Expiration date*';
	@override late final _TranslationsMobileScreensProductAddCardFormExpiryFieldErrorsEn errors = _TranslationsMobileScreensProductAddCardFormExpiryFieldErrorsEn._(_root);
}

// Path: mobileScreens.productAdd.cardForm.cvvField
class _TranslationsMobileScreensProductAddCardFormCvvFieldEn extends _TranslationsMobileScreensProductAddCardFormCvvFieldRu {
	_TranslationsMobileScreensProductAddCardFormCvvFieldEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensProductAddCardFormCvvFieldErrorsEn errors = _TranslationsMobileScreensProductAddCardFormCvvFieldErrorsEn._(_root);
}

// Path: mobileScreens.productAdd.cardForm.paramField
class _TranslationsMobileScreensProductAddCardFormParamFieldEn extends _TranslationsMobileScreensProductAddCardFormParamFieldRu {
	_TranslationsMobileScreensProductAddCardFormParamFieldEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensProductAddCardFormParamFieldErrorsEn errors = _TranslationsMobileScreensProductAddCardFormParamFieldErrorsEn._(_root);
}

// Path: mobileScreens.productAdd.paramDate.errors
class _TranslationsMobileScreensProductAddParamDateErrorsEn extends _TranslationsMobileScreensProductAddParamDateErrorsRu {
	_TranslationsMobileScreensProductAddParamDateErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get general => 'Incorrect date';
}

// Path: mobileScreens.cardInfo.modal.deleteProduct
class _TranslationsMobileScreensCardInfoModalDeleteProductEn extends _TranslationsMobileScreensCardInfoModalDeleteProductRu {
	_TranslationsMobileScreensCardInfoModalDeleteProductEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Attention';
	@override String get message => 'Are you sure you want to delete the card?';
	@override String get deleteButton => 'Delete';
	@override String get cancelButton => 'No';
}

// Path: mobileScreens.cardInfo.modal.succesProductDelete
class _TranslationsMobileScreensCardInfoModalSuccesProductDeleteEn extends _TranslationsMobileScreensCardInfoModalSuccesProductDeleteRu {
	_TranslationsMobileScreensCardInfoModalSuccesProductDeleteEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Successfully';
	@override String get message => 'Card deleted';
}

// Path: mobileScreens.cardInfo.editName.paramField
class _TranslationsMobileScreensCardInfoEditNameParamFieldEn extends _TranslationsMobileScreensCardInfoEditNameParamFieldRu {
	_TranslationsMobileScreensCardInfoEditNameParamFieldEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensCardInfoEditNameParamFieldErrorsEn errors = _TranslationsMobileScreensCardInfoEditNameParamFieldErrorsEn._(_root);
}

// Path: mobileScreens.accountInfo.modal.deleteProduct
class _TranslationsMobileScreensAccountInfoModalDeleteProductEn extends _TranslationsMobileScreensAccountInfoModalDeleteProductRu {
	_TranslationsMobileScreensAccountInfoModalDeleteProductEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Attention';
	@override String get message => 'Are you sure you want to delete your account?';
	@override String get deleteButton => 'Delete';
	@override String get cancelButton => 'No';
}

// Path: mobileScreens.accountInfo.modal.succesProductDelete
class _TranslationsMobileScreensAccountInfoModalSuccesProductDeleteEn extends _TranslationsMobileScreensAccountInfoModalSuccesProductDeleteRu {
	_TranslationsMobileScreensAccountInfoModalSuccesProductDeleteEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Successfully';
	@override String get message => 'Account deleted';
}

// Path: mobileScreens.accountInfo.editName.paramField
class _TranslationsMobileScreensAccountInfoEditNameParamFieldEn extends _TranslationsMobileScreensAccountInfoEditNameParamFieldRu {
	_TranslationsMobileScreensAccountInfoEditNameParamFieldEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMobileScreensAccountInfoEditNameParamFieldErrorsEn errors = _TranslationsMobileScreensAccountInfoEditNameParamFieldErrorsEn._(_root);
}

// Path: mobileScreens.profileEdit.modal.success
class _TranslationsMobileScreensProfileEditModalSuccessEn extends _TranslationsMobileScreensProfileEditModalSuccessRu {
	_TranslationsMobileScreensProfileEditModalSuccessEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Successfully';
	@override String get message => 'User edited';
}

// Path: mobileScreens.profileEdit.paramField.errors
class _TranslationsMobileScreensProfileEditParamFieldErrorsEn extends _TranslationsMobileScreensProfileEditParamFieldErrorsRu {
	_TranslationsMobileScreensProfileEditParamFieldErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Required field';
	@override String minLength({required Object minLength}) => 'Minimum length ${minLength}';
}

// Path: mobileScreens.settings.modal.changePinSuccess
class _TranslationsMobileScreensSettingsModalChangePinSuccessEn extends _TranslationsMobileScreensSettingsModalChangePinSuccessRu {
	_TranslationsMobileScreensSettingsModalChangePinSuccessEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Successfully';
	@override String get message => 'PIN code changed';
}

// Path: mobileScreens.settings.sections.access
class _TranslationsMobileScreensSettingsSectionsAccessEn extends _TranslationsMobileScreensSettingsSectionsAccessRu {
	_TranslationsMobileScreensSettingsSectionsAccessEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Access';
	@override String get changePin => 'Change PIN';
}

// Path: mobileScreens.settings.sections.account
class _TranslationsMobileScreensSettingsSectionsAccountEn extends _TranslationsMobileScreensSettingsSectionsAccountRu {
	_TranslationsMobileScreensSettingsSectionsAccountEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get tilte => 'Account';
	@override String get language => 'Language';
	@override String get changePassword => 'Change password';
}

// Path: mobileScreens.settings.sections.deleteAccount
class _TranslationsMobileScreensSettingsSectionsDeleteAccountEn extends _TranslationsMobileScreensSettingsSectionsDeleteAccountRu {
	_TranslationsMobileScreensSettingsSectionsDeleteAccountEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Account deleting';
	@override String get text => 'Are you sure you want to delete your account?';
	@override String get success => 'Account successfully deleted';
	@override String get yes => 'Yes';
	@override String get no => 'No';
}

// Path: mobileScreens.changePassword.oldPasswordField.errors
class _TranslationsMobileScreensChangePasswordOldPasswordFieldErrorsEn extends _TranslationsMobileScreensChangePasswordOldPasswordFieldErrorsRu {
	_TranslationsMobileScreensChangePasswordOldPasswordFieldErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get incorrect => 'Wrong old password';
}

// Path: mobileScreens.changePassword.newPasswordField.errors
class _TranslationsMobileScreensChangePasswordNewPasswordFieldErrorsEn extends _TranslationsMobileScreensChangePasswordNewPasswordFieldErrorsRu {
	_TranslationsMobileScreensChangePasswordNewPasswordFieldErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get passwordsNotMatch => 'Passwords do not match';
}

// Path: mobileScreens.changePassword.newPasswordRepeatField.errors
class _TranslationsMobileScreensChangePasswordNewPasswordRepeatFieldErrorsEn extends _TranslationsMobileScreensChangePasswordNewPasswordRepeatFieldErrorsRu {
	_TranslationsMobileScreensChangePasswordNewPasswordRepeatFieldErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get passwordsNotMatch => 'Passwords do not match';
}

// Path: mobileScreens.qrScan.modal.error
class _TranslationsMobileScreensQrScanModalErrorEn extends _TranslationsMobileScreensQrScanModalErrorRu {
	_TranslationsMobileScreensQrScanModalErrorEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Error';
	@override String message({required Object error}) => 'The QR code is invalid. ${error}';
}

// Path: mobileScreens.qrScan.qrCam.permissions
class _TranslationsMobileScreensQrScanQrCamPermissionsEn extends _TranslationsMobileScreensQrScanQrCamPermissionsRu {
	_TranslationsMobileScreensQrScanQrCamPermissionsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get denied => 'You have not granted permission to access the camera';
	@override String get permamentlyDenied => 'Access to the camera is permanently blocked by you or the phone\'s security policy';
}

// Path: mobileScreens.mdomAccountAdd.accountNumberField.errors
class _TranslationsMobileScreensMdomAccountAddAccountNumberFieldErrorsEn extends _TranslationsMobileScreensMdomAccountAddAccountNumberFieldErrorsRu {
	_TranslationsMobileScreensMdomAccountAddAccountNumberFieldErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Enter account number';
}

// Path: mobileScreens.mdomAccountAdd.codeWordField.errors
class _TranslationsMobileScreensMdomAccountAddCodeWordFieldErrorsEn extends _TranslationsMobileScreensMdomAccountAddCodeWordFieldErrorsRu {
	_TranslationsMobileScreensMdomAccountAddCodeWordFieldErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Enter code word';
}

// Path: mobileScreens.mdomAccountAdd.supplierIdField.errors
class _TranslationsMobileScreensMdomAccountAddSupplierIdFieldErrorsEn extends _TranslationsMobileScreensMdomAccountAddSupplierIdFieldErrorsRu {
	_TranslationsMobileScreensMdomAccountAddSupplierIdFieldErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Enter ID';
}

// Path: mobileScreens.mdomCompanySearch.unpField.errors
class _TranslationsMobileScreensMdomCompanySearchUnpFieldErrorsEn extends _TranslationsMobileScreensMdomCompanySearchUnpFieldErrorsRu {
	_TranslationsMobileScreensMdomCompanySearchUnpFieldErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Enter a PAN';
	@override String get length => 'Minimum length 9 characters';
}

// Path: mobileScreens.mdomCompanySearch.nameField.errors
class _TranslationsMobileScreensMdomCompanySearchNameFieldErrorsEn extends _TranslationsMobileScreensMdomCompanySearchNameFieldErrorsRu {
	_TranslationsMobileScreensMdomCompanySearchNameFieldErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Enter a name';
	@override String get length => 'Minimum length 3 characters';
}

// Path: mobileScreens.mdomAccountInfo.serviceSection.item
class _TranslationsMobileScreensMdomAccountInfoServiceSectionItemEn extends _TranslationsMobileScreensMdomAccountInfoServiceSectionItemRu {
	_TranslationsMobileScreensMdomAccountInfoServiceSectionItemEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get count => 'Count';
	@override String get rate => 'Rate';
}

// Path: mobileScreens.mdomAccountInfo.serviceSectionInfo.item
class _TranslationsMobileScreensMdomAccountInfoServiceSectionInfoItemEn extends _TranslationsMobileScreensMdomAccountInfoServiceSectionInfoItemRu {
	_TranslationsMobileScreensMdomAccountInfoServiceSectionInfoItemEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get count => 'Count';
	@override String get units => 'Units';
	@override String get tarif => 'Tarif rub.';
	@override String get accrued => 'Accrued rub.';
	@override String get recalculation => 'Recalculation rub.';
	@override String get benefit => 'Benefit rub.';
	@override String get total => 'Total rub.';
}

// Path: mobileScreens.mdomPeriodCustom.dateField.errors
class _TranslationsMobileScreensMdomPeriodCustomDateFieldErrorsEn extends _TranslationsMobileScreensMdomPeriodCustomDateFieldErrorsRu {
	_TranslationsMobileScreensMdomPeriodCustomDateFieldErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get format => 'Invalid date format';
}

// Path: mobileScreens.mdomPeriodCustom.dateFromField.errors
class _TranslationsMobileScreensMdomPeriodCustomDateFromFieldErrorsEn extends _TranslationsMobileScreensMdomPeriodCustomDateFromFieldErrorsRu {
	_TranslationsMobileScreensMdomPeriodCustomDateFromFieldErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get dateIsAfter => 'Ошибка';
	@override String get empty => 'Error';
}

// Path: mobileScreens.mdomPeriodCustom.dateToField.errors
class _TranslationsMobileScreensMdomPeriodCustomDateToFieldErrorsEn extends _TranslationsMobileScreensMdomPeriodCustomDateToFieldErrorsRu {
	_TranslationsMobileScreensMdomPeriodCustomDateToFieldErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get dateIsBefore => 'Ошибка';
	@override String get empty => 'Error';
}

// Path: mobileScreens.mdomPollsList.pollItem.votedText
class _TranslationsMobileScreensMdomPollsListPollItemVotedTextEn extends _TranslationsMobileScreensMdomPollsListPollItemVotedTextRu {
	_TranslationsMobileScreensMdomPollsListPollItemVotedTextEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get yes => 'You voted';
	@override String get no => 'Not voted';
}

// Path: mobileScreens.payment.fieldsPage.paramField.errors
class _TranslationsMobileScreensPaymentFieldsPageParamFieldErrorsEn extends _TranslationsMobileScreensPaymentFieldsPageParamFieldErrorsRu {
	_TranslationsMobileScreensPaymentFieldsPageParamFieldErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Required field';
	@override String minLength({required Object minLength}) => 'Minimum length ${minLength}';
}

// Path: mobileScreens.productAdd.modal.success.message
class _TranslationsMobileScreensProductAddModalSuccessMessageEn extends _TranslationsMobileScreensProductAddModalSuccessMessageRu {
	_TranslationsMobileScreensProductAddModalSuccessMessageEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get account => 'Account added';
	@override String get card => 'Card added';
}

// Path: mobileScreens.productAdd.accountForm.accountNumberField.errors
class _TranslationsMobileScreensProductAddAccountFormAccountNumberFieldErrorsEn extends _TranslationsMobileScreensProductAddAccountFormAccountNumberFieldErrorsRu {
	_TranslationsMobileScreensProductAddAccountFormAccountNumberFieldErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Enter account number';
	@override String get incorrectFormat => 'Invalid account number format';
}

// Path: mobileScreens.productAdd.accountForm.paramField.errors
class _TranslationsMobileScreensProductAddAccountFormParamFieldErrorsEn extends _TranslationsMobileScreensProductAddAccountFormParamFieldErrorsRu {
	_TranslationsMobileScreensProductAddAccountFormParamFieldErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Required field';
	@override String minLength({required Object minLength}) => 'Minimum length ${minLength}';
}

// Path: mobileScreens.productAdd.cardForm.cardNumberField.errors
class _TranslationsMobileScreensProductAddCardFormCardNumberFieldErrorsEn extends _TranslationsMobileScreensProductAddCardFormCardNumberFieldErrorsRu {
	_TranslationsMobileScreensProductAddCardFormCardNumberFieldErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Enter card number';
	@override String get incorrectFormat => 'Invalid card number format';
}

// Path: mobileScreens.productAdd.cardForm.expiryField.errors
class _TranslationsMobileScreensProductAddCardFormExpiryFieldErrorsEn extends _TranslationsMobileScreensProductAddCardFormExpiryFieldErrorsRu {
	_TranslationsMobileScreensProductAddCardFormExpiryFieldErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Enter expiration date';
	@override String get incorrectFormat => 'Invalid card number format';
}

// Path: mobileScreens.productAdd.cardForm.cvvField.errors
class _TranslationsMobileScreensProductAddCardFormCvvFieldErrorsEn extends _TranslationsMobileScreensProductAddCardFormCvvFieldErrorsRu {
	_TranslationsMobileScreensProductAddCardFormCvvFieldErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Enter CVV';
	@override String get incorrectFormat => 'Invalid CVV format';
}

// Path: mobileScreens.productAdd.cardForm.paramField.errors
class _TranslationsMobileScreensProductAddCardFormParamFieldErrorsEn extends _TranslationsMobileScreensProductAddCardFormParamFieldErrorsRu {
	_TranslationsMobileScreensProductAddCardFormParamFieldErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Required field';
	@override String minLength({required Object minLength}) => 'Minimum length ${minLength}';
}

// Path: mobileScreens.cardInfo.editName.paramField.errors
class _TranslationsMobileScreensCardInfoEditNameParamFieldErrorsEn extends _TranslationsMobileScreensCardInfoEditNameParamFieldErrorsRu {
	_TranslationsMobileScreensCardInfoEditNameParamFieldErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Required field';
	@override String minLength({required Object minLength}) => 'Minimum length ${minLength}';
}

// Path: mobileScreens.accountInfo.editName.paramField.errors
class _TranslationsMobileScreensAccountInfoEditNameParamFieldErrorsEn extends _TranslationsMobileScreensAccountInfoEditNameParamFieldErrorsRu {
	_TranslationsMobileScreensAccountInfoEditNameParamFieldErrorsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Required field';
	@override String minLength({required Object minLength}) => 'Minimum length ${minLength}';
}
