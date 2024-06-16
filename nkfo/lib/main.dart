

import 'package:dartx/dartx.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:web_cabinet_nkfo/route_helper.dart';
import 'package:web_cabinet_nkfo/styles.dart';

import 'blocs/bloc_observer.dart';
import 'blocs/blocs.dart';
import 'config.dart';
import 'data/data.dart';
import 'injection_component.dart';
import 'models/models.dart';
import 'navigation.dart';
import 'screens/screens.dart';
import 'utils/utils.dart';

Future<void> main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();

  if (!AppConfig.isUrlHashStrategy) setPathUrlStrategy();

  RouteHelper(
    isHashStrategy: AppConfig.isUrlHashStrategy,
    urlAppend: AppConfig.urlAppend
  );

  await InjectionComponent.run();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<SettingsBloc>(
        create: (context) => SettingsBloc()..add(SettingsInit()),
      ),
      BlocProvider<IntroMessageBloc>(
        create: (context) => IntroMessageBloc(),
      ),
      BlocProvider<ChangePasswordBloc>(
        create: (context) => ChangePasswordBloc(),
      ),
      BlocProvider<AuthBloc>(
        create: (context) => AuthBloc()//..add(AuthCheck()),
      ),
      BlocProvider<SuppliersBloc>(
        create: (context) => SuppliersBloc(),
      ),
    ],
    child: NkfoApp(),  
  ));
}

class NkfoApp extends StatelessWidget {
  static const primary = MaterialColor(0xff2B50A1, {
    50: Color(0xff2B50A1),
    100: Color(0xff2B50A1),
    200: Color(0xff2B50A1),
    300: Color(0xff2B50A1),
    400: Color(0xff2B50A1),
    500: Color(0xff2B50A1),
    600: Color(0xff2B50A1),
    700: Color(0xff2B50A1),
    800: Color(0xff2B50A1),
    900: Color(0xff2B50A1)
  });

  static void setPageTitle(BuildContext context, String text) {
    SystemChrome.setApplicationSwitcherDescription(ApplicationSwitcherDescription(
      label: '$text | ${AppConfig.appName}',
      primaryColor:Theme.of(context).primaryColor.value,
    ));
  }
  

  final Map<String, String> _names = {
    '/': SplashScreen.pageName,
    '/auth': AuthScreen.pageName,
    '/organizations': OrganizationsScreen.pageName,
    '/organization' : OrganizationInfoScreen.pageName,
    '/organizations/add':OrganizationAddScreen.pageName,
    '/organization/edit' :OrganizationEditScreen.pageName,
    '/users': UsersScreen.pageName,
    '/users/add': UserAddScreen.pageName,
    '/users/edit': UserEditScreen.pageName,
    '/audit': AuditScreen.pageName,
    '/audit/archive': AuditArchiveScreen.pageName,
    '/messages': MessagesScreen.pageName,
    '/message': MessageScreen.pageName,
    '/messages/add': MessageAddScreen.pageName,
    '/message/edit': MessageEditScreen.pageName,
    '/jobs_manager':JobsManagerScreen.pageName,
    '/job/add': JobAddScreen.pageName,
    '/job/edit': JobEditScreen.pageName,
    '/job_part/add': JobPartAddScreen.pageName,
    '/job_part/edit': JobPartEditScreen.pageName,
    '/job_part/run': JobPartRunParamsScreen.pageName,
    '/job_part_param/add': JobPartParamAddScreen.pageName,
    '/job_part_param/edit': JobPartParamEditScreen.pageName,
    '/settings': SettingsScreen.pageName,
    '/service/add': ServiceAddScreen.pageName,
    '/service/edit': ServiceEditScreen.pageName,
  };
  
  @override
  Widget build(BuildContext context) => MaterialApp(
    
    builder: (context, child) =>  MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child!),
    scrollBehavior: MyCustomScrollBehavior(),
    initialRoute: '/',
    onGenerateRoute: (settings) {

      //TODO AuthLogOut event trigers for every route in stack. 
      // html.window.onBeforeUnload.listen((event) async{ 
      //   log('RouteName ${settings.name}');
      //   context.read<AuthBloc>().add(AuthLogOut());
      // });
      
      final dataManager = InjectionComponent.getDependency<DataManager>();

      final parsed = RouteHelper.parsePath(settings.name ?? '', isHashStrategy: false);
      final path = parsed.key;
      final params = parsed.value;

      setPageTitle(context, _names[path] ?? '404');

      Widget Function(BuildContext)? builder;

      if (path == '/') {
        builder = (context) => SplashScreen();
      } else if (path == '/auth') {
        final next = params['next'];

        builder = (context) => AuthScreen(
          next: next,
        );
      } else if (path == '/organizations') {
        builder = (context) => OrganizationsScreen();
      } else if (path == '/organization') {

        final _getIsAvaliable =  dataManager.userRights.isAvailable(EntityMethod.getM, EntityName.supplier);

        final id = params['id']?.toIntOrNull() ?? -1;
        final args = settings.arguments as OrganizationScreenParams?;

        builder = (context) => BlocProvider<SupplierBloc>(
          create: (context) => SupplierBloc(
            id: id,
            supplier: args?.supplier
          )..add(SupplierInit()),
          child: _getIsAvaliable? OrganizationInfoScreen() : SplashScreen()
        );
      } else if (path == '/organization/edit') {

        final _patchIsAvaliable = dataManager.userRights.isAvailable(EntityMethod.patchM, EntityName.supplier);

        final id = params['id']?.toIntOrNull() ?? -1;
        final args = settings.arguments as OrganizationEditScreenParams?;

        builder = (context) => BlocProvider<SupplierUpdateBloc>(
          create: (context) => SupplierUpdateBloc(
            id: id,
            supplier: args?.supplier
          )..add(SupplierUpdateInit()),
          child: _patchIsAvaliable? OrganizationEditScreen() : SplashScreen()
        );
        return NoAnimationMaterialPageRoute<Supplier>(
          settings: settings,
          builder: builder
        );
      } else if (path == '/organizations/add') {

        final _postIsAvaliable = dataManager.userRights.isAvailable(EntityMethod.postM, EntityName.supplier);

        builder = (context) => BlocProvider<SupplierInsertBloc>(
          create: (context) => SupplierInsertBloc()..add(SupplierInsertInit()),
          child: _postIsAvaliable? OrganizationAddScreen() : SplashScreen()
        );
        return NoAnimationMaterialPageRoute<Supplier>(
          settings: settings,
          builder: builder
        );
      } else if (path == '/service/add') {

        final _postIsAvaliable = dataManager.userRights.isAvailable(EntityMethod.postM, EntityName.supplierAccount);

        final organizationId = params['organizationId']?.toIntOrNull() ?? -1;

        builder = (context) => BlocProvider<ServiceInsertBloc>(
          create: (context) => ServiceInsertBloc(
            supplierId: organizationId
          )..add(ServiceInsertInit()),
          child: _postIsAvaliable? ServiceAddScreen() : SplashScreen()
        );

        return NoAnimationMaterialPageRoute<SupplierAccount>(
          settings: settings,
          builder: builder
        );
      } else if (path == '/service/edit') {

        final _patchIsAvaliable = dataManager.userRights.isAvailable(EntityMethod.patchM, EntityName.supplierAccount);

        final id = params['id']?.toIntOrNull() ?? -1;
        final args = settings.arguments as ServiceEditScreenParams?;

        builder = (context) => BlocProvider<ServiceUpdateBloc>(
          create: (context) => ServiceUpdateBloc(
            id: id,
            service: args?.service
          )..add(ServiceUpdateInit()),
          child: _patchIsAvaliable? ServiceEditScreen() : SplashScreen()
        );
        return NoAnimationMaterialPageRoute<SupplierAccount>(
          settings: settings,
          builder: builder
        );
      } else if (path == '/users') {
        builder = (context) => BlocProvider<UsersBloc>(
          create: (context) => UsersBloc()..add(UsersInit()),
          child:  UsersScreen()
        );
      } else if (path == '/users/add') {

        final _postIsAvaliable = dataManager.userRights.isAvailable(EntityMethod.postM, EntityName.user);

        builder = (context) => BlocProvider<UserInsertBloc>(
          create: (context) => UserInsertBloc()..add(UserInsertInit()),
          child: _postIsAvaliable? UserAddScreen() : SplashScreen()
        );
        return NoAnimationMaterialPageRoute<User>(
          settings: settings,
          builder: builder
        );
      } else if (path == '/users/edit') {

        final _patchIsAvaliable = dataManager.userRights.isAvailable(EntityMethod.patchM, EntityName.user);

        final id =  params['id']?.toIntOrNull() ?? -1;
        final args = settings.arguments as UserEditScreenParams?;

        builder = (context) => BlocProvider<UserUpdateBloc>(
          create: (context) => UserUpdateBloc(
            id: id,
            user: args?.user
          )..add(UserUpdateInit()),
          child: _patchIsAvaliable? UserEditScreen() : SplashScreen()
        );

        return NoAnimationMaterialPageRoute<User>(
          settings: settings,
          builder: builder
        );
      } else if (path == '/audit') {
        builder = (context) => MultiBlocProvider(
          providers: [
            BlocProvider<AuditBloc>(
             create: (context) => AuditBloc()..add(AuditInit())
            ),
            BlocProvider<AuditArchiveBloc>(
             create: (context) => AuditArchiveBloc()..add(AuditArchiveInit()),
            )
          ],
          child: AuditScreen(),
        );
      } else if (path == '/audit/archive') {

        final _archiveIsAvaliableAudit = dataManager.userRights.isAvailable(EntityMethod.postM, EntityName.auditArchive);

        builder = (context) => BlocProvider<AuditArchiveBloc>(
          create: (context) => AuditArchiveBloc()..add(AuditArchiveInit()),
          child: _archiveIsAvaliableAudit? AuditArchiveScreen() : SplashScreen()
        );
      } else if (path == '/messages') {
        builder = (context) => BlocProvider<ServerMessagesBloc>(
          create: (context) => ServerMessagesBloc(), //..add(ServerMessagesInit()),
          child: MessagesScreen()
        );
      } else if (path == '/message') {
        final id = params['id']?.toIntOrNull() ?? -1;
        final args = settings.arguments as MessageScreenParams?;

        builder = (context) => MultiBlocProvider(
          providers: [
            BlocProvider<ServerMessageBloc>(
              create: (context) => ServerMessageBloc(
                id: id,
                message: args?.message
              )..add(ServerMessageInit())
            ),
            BlocProvider<ServerMessagesBloc>(
              create: (context) => ServerMessagesBloc(),
            ),
          ],
          child: MessageScreen(),
        ); 
      } else if (path == '/messages/add') {

        final _postIsAvaliable = dataManager.userRights.isAvailable(EntityMethod.postM, EntityName.serverMessage);

        builder = (context) => BlocProvider<ServerMessageInsertBloc>(
          create: (context) => ServerMessageInsertBloc()..add(ServerMessageInsertInit()),
          child: _postIsAvaliable? MessageAddScreen() : SplashScreen()
        );
        return NoAnimationMaterialPageRoute<ServerMessage>(
          settings: settings,
          builder: builder
        );
      } else if (path == '/message/edit') {

        final _patchIsAvaliable = dataManager.userRights.isAvailable(EntityMethod.patchM, EntityName.serverMessage);

        final id = params['id']?.toIntOrNull() ?? -1;
        final args = settings.arguments as MessageEditScreenParams?;

        builder = (context) => BlocProvider<ServerMessageUpdateBloc>(
          create: (context) => ServerMessageUpdateBloc(
            id: id,
            message: args?.message
          )..add(ServerMessageUpdateInit()),
          child: _patchIsAvaliable? MessageEditScreen() : SplashScreen()
        );

        return NoAnimationMaterialPageRoute<ServerMessage>(
          settings: settings,
          builder: builder
        );
      } else if (path == '/jobs_manager') {
        builder = (context) => MultiBlocProvider(
          providers: [
            BlocProvider<JobsBloc>(
              create: (context) => JobsBloc()..add(const JobsInit()),
            ),
            BlocProvider<JobsPartBloc>(
              create: (context) => JobsPartBloc(),
            ),
            BlocProvider<JobsPartParamBloc>(
              create: (context) => JobsPartParamBloc(),
            ),
          ],
          child: JobsManagerScreen(),

        );   
      } else if (path == '/job/add') { 

        final _postIsAvaliableJob = dataManager.userRights.isAvailable(EntityMethod.postM, EntityName.job);

        builder = (context) => BlocProvider<JobInsertBloc>(
          create: (context) => JobInsertBloc()..add(JobInsertInit()),
          child: _postIsAvaliableJob? JobAddScreen() : SplashScreen()
        );
        return NoAnimationMaterialPageRoute<Job>(
          settings: settings,
          builder: builder
        );
      } else if (path == '/job/edit') {

        final _patchIsAvaliableJob = dataManager.userRights.isAvailable(EntityMethod.patchM, EntityName.job);

        final id = params['id']?.toIntOrNull() ?? -1;
        final args = settings.arguments as JobEditScreenParams?;
        builder = (context) => BlocProvider<JobUpdateBloc>(
          create: (context) => JobUpdateBloc(
            id: id,
            job: args?.job
          )..add(JobUpdateInit()),
          child: _patchIsAvaliableJob? JobEditScreen() : SplashScreen()
        );
        return NoAnimationMaterialPageRoute<Job>(
          settings: settings,
          builder: builder
        );
      } else if (path == '/job_part/add') { 

        final _postIsAvaliableJobPart = dataManager.userRights.isAvailable(EntityMethod.postM, EntityName.jobPart);

        final id = params['id']?.toIntOrNull() ?? -1;
        builder = (context) => BlocProvider<JobPartInsertBloc>(
          create: (context) => JobPartInsertBloc(
            jobId: id
          )..add(JobPartInsertInit()),
          child: _postIsAvaliableJobPart? JobPartAddScreen() : SplashScreen()
        );
        return NoAnimationMaterialPageRoute<JobPart>(
          settings: settings,
          builder: builder
        );
      } else if (path == '/job_part/edit') {
        final _patchIsAvaliableJobPart = dataManager.userRights.isAvailable(EntityMethod.patchM, EntityName.jobPart);

        final id = params['id']?.toIntOrNull() ?? -1;
        final args = settings.arguments as JobPartEditScreenParams?;
        builder = (context) => BlocProvider<JobPartUpdateBloc>(
          create: (context) => JobPartUpdateBloc(
            id: id,
            jobPart: args?.jobPart
          )..add(JobPartUpdateInit()),
          child: _patchIsAvaliableJobPart? JobPartEditScreen() : SplashScreen()
        );
        return NoAnimationMaterialPageRoute<JobPart>(
          settings: settings,
          builder: builder
        );
      } else if (path == '/job_part/run') { 

        final _isJobPartRunIsAvailable = dataManager.userRights.isAvailable(EntityMethod.postM, EntityName.jobPartRun);

        final args = settings.arguments as JobPartEditScreenParams?;

        final paramsIfNull = JobPartEditScreenParams(jobPart: const JobPart(jobPartId: -1, jobId: -1));

        builder = (context) => MultiBlocProvider(
          providers: [
            BlocProvider<JobPartRunBloc>(
              create: (context) => JobPartRunBloc(
                jobPart: (args ?? paramsIfNull).jobPart
              )..add(JobPartInitRunJobPart()),
            ),
            BlocProvider<JobsPartBloc>(
              create: (context) => JobsPartBloc(),
            ),
          ],
          child: _isJobPartRunIsAvailable? JobPartRunParamsScreen() : SplashScreen()
        ); 
        return NoAnimationMaterialPageRoute<String>(
          settings: settings,
          builder: builder
        );
      } else if (path == '/job_part_param/add') { 

        final postIsAvaliableJobPartParam = dataManager.userRights.isAvailable(EntityMethod.postM, EntityName.jobPartParam);

        final jobPartId = params['jobPartId']?.toIntOrNull() ?? -1;
        builder = (context) => BlocProvider<JobPartParamInsertBloc>(
          create: (context) => JobPartParamInsertBloc(
            jobPartId: jobPartId
          ),
          child: postIsAvaliableJobPartParam? JobPartParamAddScreen() : SplashScreen()
        );
        return NoAnimationMaterialPageRoute<JobPartParam>(
          settings: settings,
          builder: builder
        );
      } else if (path == '/job_part_param/edit') {
        final patchIsAvaliableJobPartParam = dataManager.userRights.isAvailable(EntityMethod.patchM, EntityName.jobPartParam);

        final id = params['id']?.toIntOrNull() ?? -1;
        final args = settings.arguments as JobPartParamEditScreenParams?;
        builder = (context) => BlocProvider<JobPartParamUpdateBloc>(
          create: (context) => JobPartParamUpdateBloc(
            id: id,
            jobPartParam: args?.jobPartParam
          )..add(JobPartParamUpdateInit()),
          child: patchIsAvaliableJobPartParam? JobPartParamEditScreen() : SplashScreen()
        );
        return NoAnimationMaterialPageRoute<JobPartParam>(
          settings: settings,
          builder: builder
        );
      } else if (path == '/settings') {
        builder = (context) => SettingsScreen();
      } 
      builder ??= (context) => SplashScreen();

      return NoAnimationMaterialPageRoute<void>(
        settings: settings,
        builder: builder
      );
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
      useMaterial3: false,
      fontFamily: 'Roboto',
      scaffoldBackgroundColor: AppStyles.scaffoldColor,
      appBarTheme: AppBarTheme(
        color: AppStyles.scaffoldColor,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarBrightness:Brightness.light), 
        elevation: 0,
        iconTheme: Theme.of(context)
            .primaryIconTheme
            .copyWith(color: AppStyles.mainTextColor),
      ),
      primarySwatch: primary,
      secondaryHeaderColor: Colors.black,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
  );
}


class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => { 
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}