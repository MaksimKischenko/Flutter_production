import 'package:web_cabinet_nkfo/models/models.dart';
import 'package:web_cabinet_nkfo/utils/utils.dart';

// ignore: avoid_classes_with_only_static_members
class AppConfig {
  static const String appName = 'Панель администрирования';

  static String passwordCrypter(String value) => value.toSha256();

  // false - path url strategy
  // true - hash url strategy
  static bool isUrlHashStrategy = true;

  // url appender for path strategy
  // used if application run not at /
  static String urlAppend = '';

  static const int refreshTime  = 180;

  /*
    Suppliers
  */

  static const int suppliersGetLoadCount = 30;

  static const SuppliersSort suppliersDefaultSort = SuppliersSort.unp;
  static const bool suppliersDefaultSortAscending = false;

  /*
    Users
  */

  static const int usersGetLoadCount = 30;

  static const UsersSort usersDefaultSort = UsersSort.name;
  static const bool usersDefaultSortAscending = false;
  
  /*
    Audits
  */

  static const int auditGetLoadCount = 30;

  static const AuditSort auditDefaultSort = AuditSort.date;
  static const bool auditDefaultSortAscending = false;

  /*
    ServerMessages
  */

  static const int serverMessagesGetLoadCount = 30;
  static const ServerMessageSort serverMessagesDefaultSort = ServerMessageSort.title;
  static const bool serverMessagesDefaultSortAscending = false;

  /*
    Jobs
  */

  static const int jobsGetLoadCount = 100;
  static const UnassignedTasksSort jobsDefaultSort = UnassignedTasksSort.name;
  static const bool jobsDefaultSortAscending = false;

  /*
    JobPart
  */

  static const int jobsPartGetLoadCount = 100;
  static const TasksPartSort jobsPartDefaultSort = TasksPartSort.name;
  static const bool jobsPartDefaultSortAscending = false;

  /*
    JobPartParam
  */

  static const int jobsPartParamGetLoadCount = 100;
  static const TasksPartParamSort jobsPartParamDefaultSort = TasksPartParamSort.name;
  static const bool jobsPartParamDefaultSortAscending = false;

  static const String passwordInfo = 'Длина 8-64 символа\nбуквы латинского алфавита\nобязательно наличие прописной буквы\nобязательно наличие цифры\nвозможны специальные символы';

  static const String getIsNotAvaliableSupplier = 'У вас нет прав\n на просмотр организаций';
  static const String postIsNotAvaliableSupplier = 'У вас нет прав\n на добавление организации';
  static const String deleteIsNotAvaliableSupplier = 'У вас нет прав\n на удаление организации';
  static const String patchIsNotAvaliableSupplier = 'У вас нет прав\n на редактирование организации';

  static const String getIsNotAvaliableSupplierAccount = 'У вас нет прав\n на просмотр услуг';
  static const String postIsNotAvaliableSupplierAccount = 'У вас нет прав\n на добавление услуг';
  static const String deleteIsNotAvaliableSupplierAccount = 'У вас нет прав\n на удаление услуг';
  static const String patchIsNotAvaliableSupplierAccount = 'У вас нет прав\n на редактирование услуг';

  static const String getIsNotAvaliableAudit = 'У вас нет прав\n на просмотр журнала аудита';
  static const String getIsNotAvaliableAuditExport = 'У вас нет прав\n на выгрузку журнала аудита';
  static const String archiveIsNotAvaliable = 'У вас нет прав\n на архивацию журнала аудита';

  static const String getIsNotAvaliableUser = 'У вас нет прав\n на просмотр пользователей';
  static const String postIsNotAvaliableUser = 'У вас нет прав\n на добавление пользователей';
  static const String patchIsNotAvaliableUser = 'У вас нет прав\n на редактирование пользователей';
  static const String deleteIsNotAvaliableUser = 'У вас нет прав\n на удаление пользователей';
  static const String resetPasswordIsNotAvaliableUser = 'У вас нет прав\n на сброс пароля пользователей';

  static const String getIsNotAvaliableServerMessage = 'У вас нет прав\n на просмотр рассылок';
  static const String postIsNotAvaliableServerMessage = 'У вас нет прав\n на добавление рассылок';
  static const String deleteIsNotAvaliableServerMessage = 'У вас нет прав\n на удаление рассылок';
  static const String patchIsNotAvaliableServerMessage= 'У вас нет прав\n на редактирование рассылок';

  static const String changePasswordIsNotAvaliable = 'У вас нет прав\n на смену пароля';
  static const String sendMessageIsNotAvaliable = 'У вас нет прав\n на создание сообщения';

  static const String getIsNotAvaliableJob = 'У вас нет прав\n на просмотр назначенных заданий';
  static const String postIsNotAvaliableJob  = 'У вас нет прав\n на добавление назначенных заданий';
  static const String deleteIsNotAvaliableJob  = 'У вас нет прав\n на удаление назначенных заданий';
  static const String patchIsNotAvaliableJob = 'У вас нет прав\n на редактирование назначенных заданий';
  static const String runIsNotAvaliableJob = 'У вас нет прав\n на выполнение назначенных заданий';

  static const String getIsNotAvaliableJobPart = 'У вас нет прав\n на просмотр частей заданий';
  static const String postIsNotAvaliableJobPart  = 'У вас нет прав\n на добавление частей заданий';
  static const String deleteIsNotAvaliableJobPart  = 'У вас нет прав\n на удаление частей заданий';
  static const String patchIsNotAvaliableJobPart = 'У вас нет прав\n на редактирование частей заданий';
  static const String runIsNotAvaliableJobPart = 'У вас нет прав\n на выполнение частей заданий';

  static const String getIsNotAvaliableJobPartParam = 'У вас нет прав\n на просмотр параметров запроса';
  static const String postIsNotAvaliableJobPartParam  = 'У вас нет прав\n на добавление параметров запроса';
  static const String deleteIsNotAvaliableJobPartParam  = 'У вас нет прав\n на удаление параметров запроса';
  static const String patchIsNotAvaliableJobPartParam = 'У вас нет прав\n на редактирование параметров запроса';
} 