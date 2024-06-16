import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helppay_payform_app/styles.dart';
import 'package:helppay_payform_app/utils/loger.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:yaml/yaml.dart';

import 'blocs/bloc_observer.dart';
import 'blocs/blocs.dart';
import 'config.dart';
import 'data/data.dart';
import 'injection_component.dart';
import 'models/models.dart';
import 'navigation.dart';
import 'route_helper.dart';
import 'screens/screens.dart';
import 'utils/utils.dart';

int? allServiceCode;
void _log(dynamic message) => Logger.helpPayLog(message, name: 'main');
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final yamlString = await rootBundle.loadString('assets/config.yaml');
  final config = DynamicConfig.fromYaml(loadYaml(yamlString));

  allServiceCode = config.allServicesCode;

  if (!config.isUrlHashStrategy) setPathUrlStrategy();
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  RouteHelper(
      isHashStrategy: config.isUrlHashStrategy, urlAppend: config.urlAppend);
  await InjectionComponent.run(config: config);
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: HydratedStorage.webStorageDirectory);
  Bloc.observer = SimpleBlocObserver();
  Bloc.transformer = sequential<dynamic>();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(
          dataManager: InjectionComponent.getDependency<DataManager>(),
          config: config),
    ),
    BlocProvider<PaymentsBloc>(
      create: (context) => PaymentsBloc(
        dataManager: InjectionComponent.getDependency<DataManager>(),
      ),
    ),
    BlocProvider<ConfirmBloc>(
      create: (context) => ConfirmBloc(
        InjectionComponent.getDependency<DataManager>(),
      ),
    ),
    BlocProvider<ReturnBackBloc>(
      create: (context) => ReturnBackBloc(),
    ),
    BlocProvider<InitHelppayServicesBloc>(
      create: (context) => InitHelppayServicesBloc(
        dataManager: InjectionComponent.getDependency<DataManager>(),
      ),
    ),
    BlocProvider<PopularServicesBloc>(
      create: (context) => PopularServicesBloc(
        dataManager: InjectionComponent.getDependency<DataManager>(),
        config: InjectionComponent.getDependency<DynamicConfig>(),
      ),
    ),
  ], child: HelpPayApp()));
}

class HelpPayApp extends StatelessWidget {
  static const primary = MaterialColor(4283157653, {
    50: Color(0xffebf9f3),
    100: Color(0xffd7f4e8),
    200: Color(0xffb0e8d0),
    300: Color(0xff88ddb9),
    400: Color(0xff60d2a1),
    500: Color(0xff38c78a),
    600: Color(0xff2d9f6e),
    700: Color(0xff227753),
    800: Color(0xff174f37),
    900: Color(0xff0b281c)
  });

  static void setPageTitle(BuildContext context, String text) {
    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label: '$text | ${AppConfig.appName}',
      primaryColor: Theme.of(context).primaryColor.value,
    ));
  }

  final Map<String, String> _names = {
    SplashScreen.pageRoute: SplashScreen.pageName,
    //PaymentsScreen.pageRoute: PaymentsScreen.pageName,
    PopularServicesScreen.pageRoute: PopularServicesScreen.pageName,
    InitHelppayServicesScreen.pageRoute: InitHelppayServicesScreen.pageName,
    //AllServicesScreen.pageRoute: AllServicesScreen.pageName,
    ServicesScreen.pageRoute: ServicesScreen.pageName,
    ServiceScreen.pageRoute: ServiceScreen.pageName,
    CheckScreen.pageRoute: CheckScreen.pageName,
  };

  @override
  Widget build(BuildContext context) => MaterialApp(
        scrollBehavior: CustomScrollBehavior(),
        initialRoute: kDebugMode
            ? '/?SessionToken=33A4F76F2CF5F9BB0B926C91D43BA192&ReturnURI=http%3A%2F%2F192.168.244.126%2Ffake_helppay_entity%2Fconfirm.html&Login=Testttt&Password=c4ea3dc46e93faa500a04a06e1a0c25fa443d3ed9479b6f85c9cb663053d30ff&Mode=DICT&DeviceType=WEBHelpPay&ConfirmUri=http%3A%2F%2F192.168.244.126%3A8085%2Fhelppay_payform%2Ftest%2Fconfirm&PayerId=1&MaxAmount=100'
            : '/',
        onGenerateRoute: (settings) {
          final _dataManager = InjectionComponent.getDependency<DataManager>();
          final parsed = RouteHelper.parsePath(settings.name ?? '',
              isHashStrategy: false, urlAppender: '');
          final path = parsed.key;
          final params = parsed.value;
          print('params - $params');

          setPageTitle(context, _names[path] ?? '404');

          Widget Function(BuildContext)? builder;

          if (path == SplashScreen.pageRoute) {
            final getPaymentsToken = params['SessionToken'];
            final returnUri = params['ReturnURI'];
            final login = params['Login'];
            final password = params['Password'];
            final deviceType = params['DeviceType'];
            final confirmUri = params['ConfirmUri'];
            final payerId = params['PayerId'];
            final mode = params['Mode'];
            final maxAmount = params['MaxAmount']?.toDoubleOrNull();

            _log('Login - $login');
            print('Login - $login');
            print('Login from datamanager - ${_dataManager.login}');

            _dataManager.login = login ?? '';
            _dataManager.password = password ?? '';
            _dataManager.deviceType = deviceType ?? '';
            _dataManager.returnUri = returnUri ?? '';
            _dataManager.confirmUri = confirmUri ?? '';
            _dataManager.payerId = payerId ?? '';
            _dataManager.maxAmount = maxAmount ?? 0;
            _dataManager.mode = mode ?? 'DICT';

            builder = (context) => SplashScreen(
                  token: getPaymentsToken,
                  returnUri: returnUri,
                  maxAmount: maxAmount,
                );
          }

          // else if (path == PaymentsScreen.pageRoute) {
          //   builder = (context) => BlocProvider<ConfirmBloc>(
          //     create: (context) => ConfirmBloc(InjectionComponent.getDependency<DataManager>()),
          //     child: PaymentsScreen()
          //   );
          // }

          else if (path == PopularServicesScreen.pageRoute) {
            builder = (context) => PopularServicesScreen();
          } else if (path == InitHelppayServicesScreen.pageRoute) {
            final diType =
                params['diType']?.toIntOrNull() ?? AppConfig.diTypeNode;
            final args = settings.arguments is NodeScreenParams
                ? settings.arguments as NodeScreenParams
                : null;

            builder = (context) => BlocProvider<PaymentBloc>(
                  create: (context) => PaymentBloc(
                    dataManager:
                        InjectionComponent.getDependency<DataManager>(),
                    diType: diType,
                  ),
                  child: InitHelppayServicesScreen(
                    nodeScreenParams: NodeScreenParams(
                      node: args?.node,
                      nodeId: args?.nodeId,
                      nodeType: args?.nodeType,
                    ),
                  ),
                );
          }

          // KOMDEV-7495
          // else if (path == AllServicesScreen.pageRoute) {
          //   builder = (context) => BlocProvider<AllServicesBloc>(
          //     create: (context) => AllServicesBloc(
          //       dataManager: InjectionComponent.getDependency<DataManager>()
          //     ),
          //     child: const AllServicesScreen(),
          //   );
          // }
          else if (path == ServicesScreen.pageRoute) {
            final code = params['code']?.toIntOrNull() ??
                InjectionComponent.getDependency<DynamicConfig>()
                    .allServicesCode;
            final diType =
                params['diType']?.toIntOrNull() ?? AppConfig.diTypeNode;

            builder = (context) => BlocProvider<ServicesBloc>(
                  create: (context) => ServicesBloc(
                      dataManager:
                          InjectionComponent.getDependency<DataManager>(),
                      diType: diType),
                  child: ServicesScreen(code: code),
                );
          } else if (path == ServiceScreen.pageRoute) {
            final code = params['code']?.toIntOrNull() ?? -1;
            final name = params['name'];
            final diType =
                params['diType']?.toIntOrNull() ?? AppConfig.diTypeService;
            final suplierName = params['suplierName'];

            builder = (context) => BlocProvider<PaymentBloc>(
                  create: (context) => PaymentBloc(
                      dataManager:
                          InjectionComponent.getDependency<DataManager>(),
                      diType: diType),
                  child: ServiceScreen(
                    code: code,
                    name: name ?? '',
                    suplierName: suplierName ?? '',
                  ),
                );
          } else if (path == CheckScreen.pageRoute) {
            final id = params['id']?.toIntOrNull() ?? -1;
            final args = settings.arguments is CheckScreenParams
                ? settings.arguments as CheckScreenParams
                : null;
            final checkList = args?.checkList;

            builder = (context) => BlocProvider<CheckBloc>(
                  create: (context) => CheckBloc(
                      InjectionComponent.getDependency<DataManager>(),
                      paymentId: id,
                      code: args?.code ?? 0,
                      name: args?.name ?? '',
                      initialCheckList: checkList ?? []),
                  child: CheckScreen(
                      suplierName: args?.suplierName ?? AttrRecordResponse(),
                      suplierValueName:
                          args?.suplierValueName ?? AttrRecordResponse(),
                      allServiceCode: allServiceCode ?? 0),
                );
          }

          builder ??= (context) => SplashScreen();

          return NoAnimationMaterialPageRoute<void>(
              settings: settings, builder: builder);
        },
        navigatorKey: Navigation.navigatorKey,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          // RefreshLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ru'),
          //const Locale('en'),
        ],
        title: 'Загрузка | ${AppConfig.appName}',
        theme: ThemeData(
          // fontFamily: 'Roboto',
          scaffoldBackgroundColor: AppStyles.scaffoldColor,
          appBarTheme: AppBarTheme(
            color: AppStyles.scaffoldColor,
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.light),
            elevation: 0,
            iconTheme: Theme.of(context)
                .primaryIconTheme
                .copyWith(color: AppStyles.mainTextColor),
          ),
          primarySwatch: primary,
          secondaryHeaderColor: Colors.black,
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme.apply(
                  bodyColor: AppStyles.mainTextColor,
                ),
          ),
          primaryTextTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).primaryTextTheme.apply(
                  bodyColor: AppStyles.mainTextColor,
                ),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      );
}
