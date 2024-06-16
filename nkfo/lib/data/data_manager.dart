import 'package:dio/dio.dart';
import 'package:web_cabinet_nkfo/data/remote_models/user_right_request.dart';
import 'package:web_cabinet_nkfo/data/remote_models/user_right_response.dart';
import 'package:web_cabinet_nkfo/models/models.dart';
import 'package:web_cabinet_nkfo/utils/utils.dart';

import 'data.dart';

class DataManager {
  final EripPostgresApi _eripPostgresApi;

  final Dio dio;

  DataManager(this.dio) : _eripPostgresApi = EripPostgresApi(dio);

  String? token;
  String login = '';
  UserRightsWrapper userRights =  const UserRightsWrapper([]);
  // List<UserRight> userRight = [];

  String get authHeader => 'Bearer $token';

  Future<LoginUserResponse> loginUserRequest({
    required String username,
    required String password,
  }) =>
      _eripPostgresApi.loginUserRequest(LoginUserRequest(
        user: username,
        password: password,
      ));

  Future<void> logoutUserRequest() => _eripPostgresApi.logoutUserRequest(auth: authHeader);


  Future<List<UserRight>> userRightRequest() =>
  _eripPostgresApi.userRightRequest(
    auth: authHeader,
    body: UserRightRequest(
      entityName: '',
      entityType: '',
      dev: false
    )
  );

   //USER ROLES
    Future<List<Role>>getRoleRequest() =>
      _eripPostgresApi.getRoleRequest(
        auth: authHeader,
  );

    Future<List<UserRole>>getUserRoleRequest({
      required String userName
    }) =>
      _eripPostgresApi.getUserRoleRequest(
        auth: authHeader,
        body: UserRoleRequest(
          userName: userName
        )
     );

    Future<String>setUserRoleRequest({
      required String userName,
      required List<int> userIds
    }) =>
      _eripPostgresApi.setUserRoleRequest(
        auth: authHeader,
        body: SetUserRoleRequest(
          userName: userName,
          userRolesIds: userIds
        )
     );
//

  Future<ChangePasswordResponse> changePasswordRequest({
    required String username,
    required String password,
    required String newPassword,
  }) =>
      _eripPostgresApi.changePasswordRequest(
          authHeader,
          ChangePasswordRequest(
            user: username,
            password: password,
            newPassword: newPassword,
          ));


  Future<List<Supplier>> getSuppliersRequest({
    int? count,
    SupplierStatus? status,
    String? unp,
    String? shortName,
    int? offset,
    SuppliersSort? sort,
    bool sortAscending = true,
    String? select,

    /// single select by id
    int? id,

    /// multiple select by ids
    List<int>? ids,
  }) =>
      _eripPostgresApi.getSuppliersRequest(
        auth: authHeader,
        count: count,
        offset: offset,
        status: status != null
            ? status != SupplierStatus.all
                ? 'eq.${status.boolean}'
                : null
            : null,
        // status: status != SupplierStatus.all ? 'eq.${status.boolean}' : null,
        unp: unp?.isNotEmpty ?? false ? 'ilike.*$unp*' : null,
        shortName: shortName?.isNotEmpty ?? false ? 'ilike.*$shortName*' : null,
        order: sort != null
            ? '${sort.DBName}.${sortAscending ? "asc" : "desc"}'
            : null,
        select: select,
        id: id != null ? 'eq.$id' : null,
        ids: ids != null ? 'in.(${ids.join(",")})' : null,
      );

  Future<Supplier> supplierInsertRequest(SupplierInsertRequest request) async =>
      (await _eripPostgresApi.supplierInsertRequest(
              auth: authHeader, body: request))
          .first;

  Future<List<Bank>> getBanksRequest() => _eripPostgresApi.getBanksRequest(
        auth: authHeader,
      );

  Future<List<User>> getUsersRequest(
          {int? count,
          UsersBlockStatus? status,
          UserType? type,
          int? supplierId,
          String? fio,
          int? offset,
          UsersSort? sort,
          bool sortAscending = true,
          int? id}) =>
      _eripPostgresApi.getUsersRequest(
          auth: authHeader,
          count: count,
          order: sort != null
              ? '${sort.DBName}.${sortAscending ? "asc" : "desc"}'
              : null,
          offset: offset,
          status: status != null
              ? status != UsersBlockStatus.all
                  ? 'eq.${status.boolean}'
                  : null
              : null,
          typeId: type != null ? 'eq.${type.id}' : null,
          supplierId: supplierId != null ? 'eq.$supplierId' : null,
          fio: fio?.isNotEmpty ?? false ? 'ilike.*$fio*' : null,
          // single select by id
          id: id != null ? 'eq.$id' : null);

  Future<User> userInsertRequest(UserInsertRequest request) async =>
      (await _eripPostgresApi.userInsertRequest(
              auth: authHeader, body: request))
          .first;

  Future<User> userUpdateRequest({
    required int id,
    required UserUpdateRequest request,
  }) async =>
      (await _eripPostgresApi.userUpdateRequest(
              auth: authHeader, id: 'eq.$id', body: request))
          .first;

  Future<List<User>> usersUpdateRequest({
    required List<int>? ids,
    required UserUpdateRequest request,
  }) async =>
      await _eripPostgresApi.usersUpdateRequest(
              auth: authHeader,
              ids: ids != null ? 'in.(${ids.join(",")})' : null,
              body: request);

  Future<User> userDeleteRequest({required int id}) async =>
      (await _eripPostgresApi.userDeleteRequest(auth: authHeader, id: 'eq.$id'))
          .first;

  Future<User> usersDeleteRequest({required List<int>? ids}) async =>
      (await _eripPostgresApi.usersDeleteRequest(
              auth: authHeader,
              ids: ids != null ? 'in.(${ids.join(",")})' : null))
          .first;

  Future<List<UserType>> getUserTypeRequest() =>
      _eripPostgresApi.getUserTypeRequest(
        auth: authHeader,
      );

  Future<Supplier> supplierUpdateRequest({
    required int id,
    required SupplierUpdateRequest request,
  }) async =>
      (await _eripPostgresApi.supplierUpdateRequest(
              auth: authHeader, id: 'eq.$id', body: request))
          .first;

  Future<Supplier> supplierDeleteRequest({required int id}) async =>
      (await _eripPostgresApi.supplierDeleteRequest(
              auth: authHeader, id: 'eq.$id'))
          .first;

  Future<List<SupplierAccount>> supplierAccountRequest(
          {int? supplierId, int? id}) =>
      _eripPostgresApi.supplierAccountRequest(
        auth: authHeader,
        supplierId: supplierId != null ? 'eq.$supplierId' : null,
        id: id != null ? 'eq.$id' : null,
      );

  Future<SupplierAccount> supplierAccountInsertRequest({
    required SupplierAccountInsertRequest request,
  }) async =>
      (await _eripPostgresApi.supplierAccountInsertRequest(
              auth: authHeader, body: request))
          .first;

  Future<SupplierAccount> supplierAccountDeleteRequest({
    required int id,
  }) async =>
      (await _eripPostgresApi.supplierAccountDeleteRequest(
              auth: authHeader, id: 'eq.$id'))
          .first;

  Future<SupplierAccount> supplierAccountUpdateRequest({
    required int id,
    required SupplierAccountUpdateRequest request,
  }) async =>
      (await _eripPostgresApi.supplierAccountUpdateRequest(
              auth: authHeader, id: 'eq.$id', body: request))
          .first;

  Future<List<ServiceScenario>> getServiceScenarioRequest() =>
      _eripPostgresApi.getServiceScenarioRequest(
        auth: authHeader,
      );

  Future<String> userResetPasswordRequest({required String userLogin}) =>
      _eripPostgresApi.resetPasswordRequest(
          authHeader, ResetPasswordRequest(userLogin: userLogin));

  Future<List<Audit>> getAuditRequest({
          int? count,
          int? offset,
          AuditSort? sort,
          bool sortAscending = true,
          DateTime? dateFrom,
          DateTime? dateTo,
          AuditApplication? application,
          AuditAction? action,
          int? supplierId,
          String? description }) =>
      _eripPostgresApi.getAuditRequest(
        auth: authHeader,
        count: count,
        offset: offset,
        order: sort != null
            ? '${sort.DBName}.${sortAscending ? "asc" : "desc"}'
            : null,
        date: dateFrom != null && dateTo != null
            ? '(op_action_date.gte.${dateFrom.toStringFormattedGetOperationHistory()}-00,op_action_date.lte.${dateTo.add(const Duration(hours: 23, minutes: 59)).toStringFormattedGetOperationHistory()}-00)'
            : null,
        appication: application != null ? 'ilike.${application.name}' : null,
        action: action != null ? 'eq.${action.id}' : null,
        supplierId: supplierId != null ? 'eq.$supplierId' : null,
        description:
            description?.isNotEmpty ?? false ? 'ilike.*$description*' : null,
      );

  Future<List<AuditApplication>> getAuditApplicationsRequest() async =>
      _eripPostgresApi.getAuditApplicationsRequest(
        auth: authHeader,
      );

  Future<List<AuditAction>> getAuditActionRequest() =>
      _eripPostgresApi.getAuditActionRequest(
        auth: authHeader,
      );

  Future<String> auditArchiveRequest(
          {required String actions, required DateTime? dateFrom}) =>
      _eripPostgresApi.audidArchiveRequest(authHeader,
          AuditArchiveRequest(actions: actions, dateFrom: dateFrom));

  Future<List<ServerMessage>> getSupplierServerMessagesRequest({
    int? count,
    int? offset,
    ServerMessageSort? sort,
    bool sortAscending = true,
    DateTime? dateFrom,
    DateTime? dateTo,
    ServerMessageStatus? status,
    ServerMessageStatus? statusName,
    String? heading,
    String? text,
    int? id,
  }) =>
      _eripPostgresApi.getSupplierServerMessages(
        auth: authHeader,
        count: count,
        offset: offset,
        order: sort != null
            ? '${sort.DBName}.${sortAscending ? "asc" : "desc"}'
            : null,
        date: dateFrom != null && dateTo != null
            ? '(message_date.gte.${dateFrom.toStringFormattedGetOperationHistory()}-00,message_date.lte.${dateTo.add(const Duration(hours: 23, minutes: 59)).toStringFormattedGetOperationHistory()}-00)'
            : null,
        //status: status != null ? 'eq.${status.value}' : null,
        statusName: statusName != null
            ? statusName != ServerMessageStatus.all
                ? 'eq.${statusName.naming}'
                : null
            : null,
        heading: heading?.isNotEmpty ?? false ? 'ilike.*$heading*' : null,
        note: text?.isNotEmpty ?? false ? 'ilike.*$text*' : null,
        id: id != null ? 'eq.$id' : null,
      );

  Future<ServerMessage> serverMessageDeleteRequest({required int id}) async =>
      (await _eripPostgresApi.serverMessageDeleteRequest(
              auth: authHeader, id: 'eq.$id'))
          .first;

  Future<ServerMessage> serverMessageInsertRequest(
          ServerMessageInsertRequest request) async =>
      (await _eripPostgresApi.serverMessageInsertRequest(
              auth: authHeader, body: request))
          .first;

  Future<ServerMessage> serverMessageUpdateRequest({
    required int id,
    required ServerMessageUpdateRequest request,
  }) async =>
      (await _eripPostgresApi.serverMessageUpdateRequest(
              auth: authHeader, id: 'eq.$id', body: request))
          .first;

  //JOB

  Future<List<Job>> getJobsRequest({
    int? count,
    String? name,
    int? offset,
    int? id,
    UnassignedTasksSort? sort,
    bool sortAscending = true,
  }) =>
      _eripPostgresApi.getJobsRequest(
        auth: authHeader,
        count: count,
        offset: offset,
        name: name?.isNotEmpty ?? false ? 'ilike.*$name*' : null,
        order: sort != null
            ? '${sort.DBName}.${sortAscending ? "asc" : "desc"}'
            : null,
        id: id != null ? 'eq.$id' : null,
      );

  Future<Job> jobInsertRequest(JobInsertRequest request) async =>
      (await _eripPostgresApi.jobInsertRequest(auth: authHeader, body: request))
          .first;

  Future<List<OutServer>> getOutServerRequest() =>
      _eripPostgresApi.getOutServerRequest(
        auth: authHeader,
      );

  Future<Job> jobUpdateRequest({
    required int id,
    required JobUpdateRequest request,
  }) async =>
      (await _eripPostgresApi.jobUpdateRequest(
              auth: authHeader, id: 'eq.$id', body: request))
          .first;

  Future<Job> jobDeleteRequest({required int id}) async =>
      (await _eripPostgresApi.jobDeleteRequest(auth: authHeader, id: 'eq.$id'))
          .first;

  Future<String> jobRunRequest({
    required int id,
  }) =>
      _eripPostgresApi.jobRunRequest(authHeader, JobRunRequest(id: id));
  //JOB_PART

  Future<List<JobPart>> getJobPartRequest(
          {int? jobId,
          int? id,
          int? count,
          int? offset,
          TasksPartSort? sort,
          bool sortAscending = true,
          ActionType? type,
          PeriodType? periodType}) =>
      _eripPostgresApi.getJobPartRequest(
        auth: authHeader,
        offset: offset,
        order: sort != null
            ? '${sort.DBName}.${sortAscending ? "asc" : "desc"}'
            : null,
        jobId: jobId != null ? 'eq.$jobId' : null,
        id: id != null ? 'eq.$id' : null,
        typeNum: type != null ? 'eq.${type.typeNum}' : null,
        periodType: periodType != null ? 'eq.${periodType.name}' : null,
      );

  Future<JobPart> jobPartInsertRequest({
    required JobPartInsertRequest request,
  }) async =>
      (await _eripPostgresApi.jobPartInsertRequest(
              auth: authHeader, body: request))
          .first;

  Future<List<ActionType>> getActionTypeRequest() =>
      _eripPostgresApi.getActionTypeRequest(
        auth: authHeader,
      );

  Future<List<PeriodType>> getPeriodTypeRequest() =>
      _eripPostgresApi.getPeriodTypeRequest(
        auth: authHeader,
      );

  Future<List<MessageType>> getMessageTypeRequest() =>
      _eripPostgresApi.getMessageTypeRequest(
        auth: authHeader,
      );

  Future<JobPart> jobPartUpdateRequest({
    required int id,
    required JobPartUpdateRequest request,
  }) async =>
      (await _eripPostgresApi.jobPartUpdateRequest(
              auth: authHeader, id: 'eq.$id', body: request))
          .first;

  Future<JobPart> jobPartDeleteRequest({required int id}) async =>
      (await _eripPostgresApi.jobPartDeleteRequest(
              auth: authHeader, id: 'eq.$id'))
          .first;

  Future<String> jobPartRunRequest({
    required int jobId,
    required int jobPartId,
    required List<JobPartRunParam> params,
  }) =>
      _eripPostgresApi.jobPartRunRequest(
          authHeader,
          JobPartRunRequest(
              jobId: jobId, jobPartId: jobPartId, params: params));

  //JOB_PART_PARAM

  Future<List<JobPartParam>> getJobPartParamRequest({
    int? count,
    String? name,
    int? offset,
    int? jobPartId,
    int? id,
    TasksPartParamSort? sort,
    bool sortAscending = true,
  }) =>
      _eripPostgresApi.getJobPartParamRequest(
        auth: authHeader,
        count: count,
        offset: offset,
        name: name?.isNotEmpty ?? false ? 'ilike.*$name*' : null,
        order: sort != null
            ? '${sort.DBName}.${sortAscending ? "asc" : "desc"}'
            : null,
        jobPartId: jobPartId != null ? 'eq.$jobPartId' : null,
        id: id != null ? 'eq.$id' : null,
      );

  Future<List<JobPartRunParam>> getJobPartRunParamRequest({
    int? jobPartId,
    int? id,
  }) =>
      _eripPostgresApi.getJobPartRunParamRequest(
        auth: authHeader,
        jobPartId: jobPartId != null ? 'eq.$jobPartId' : null,
        id: id != null ? 'eq.$id' : null,
      );

  Future<JobPartParam> jobPartParamInsertRequest(
          JobPartParamInsertRequest request) async =>
      (await _eripPostgresApi.jobPartParamInsertRequest(
              auth: authHeader, body: request))
          .first;

  Future<JobPartParam> jobPartParamUpdateRequest({
    required int id,
    required JobPartParamUpdateRequest request,
  }) async =>
      (await _eripPostgresApi.jobPartParamUpdateRequest(
              auth: authHeader, id: 'eq.$id', body: request))
          .first;

  Future<JobPartParam> jobPartParamDeleteRequest({required int id}) async =>
      (await _eripPostgresApi.jobPartParamDeleteRequest(
              auth: authHeader, id: 'eq.$id'))
          .first;




  Future<String> startMessageRequest({
    required String message,
  }) =>
    _eripPostgresApi.startMessageRequest(
      authHeader,
      StartMessageRequest(
        message: message
      )
    );        
}
