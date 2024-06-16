

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/data/remote_models/start_message_request.dart';
import 'package:web_cabinet_nkfo/data/remote_models/user_right_request.dart';
import 'package:web_cabinet_nkfo/data/remote_models/user_right_response.dart';

part 'erip_postgres_api.g.dart';

@RestApi(baseUrl: 'http://192.168.253.178:3050/ui')
abstract class EripPostgresApi {
  factory EripPostgresApi(Dio dio, {String baseUrl}) = _EripPostgresApi;

  @GET('/supplier')
  Future<List<Supplier>> getSuppliersRequest({
    @Header('Authorization') required String auth,
    @Query('limit') int? count,
    @Query('order') String? order,
    @Query('offset') int? offset,
    @Query('enabled') String? status,
    @Query('supplier_unp') String? unp,
    @Query('supplier_shortname') String? shortName,
    @Query('select') String? select,
    @Query('supplier_id') String? id,
    @Query('supplier_id') String? ids,
  });

  @POST('/supplier')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<List<Supplier>> supplierInsertRequest({
    @Header('Authorization') required String auth,
    @Body() required SupplierInsertRequest body
  });

  @GET('/bank')
  Future<List<Bank>> getBanksRequest({
    @Header('Authorization') required String auth,
  });

  @GET('/user_')
  Future<List<User>> getUsersRequest({
    @Header('Authorization') required String auth,
    @Query('limit') int? count,
    @Query('order') String? order,
    @Query('offset') int? offset,
    @Query('blocked') String? status,
    @Query('type_id') String? typeId,
    @Query('supplier_id') String? supplierId,
    @Query('name') String? fio,
    @Query('user_id') String? id,
  });

  @POST('/user_')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<List<User>> userInsertRequest({
    @Header('Authorization') required String auth,
    @Body() required UserInsertRequest body
  });

  @PATCH('/user_')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<List<User>> userUpdateRequest({
    @Header('Authorization') required String auth,
    @Query('user_id') required String id,
    @Body() required UserUpdateRequest body
  });


  @PATCH('/user_')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<List<User>> usersUpdateRequest({
    @Header('Authorization') required String auth,
    @Query('user_id') required String? ids,
    @Body() required UserUpdateRequest body
  });
  

  @DELETE('/user_')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<List<User>> userDeleteRequest({
    @Header('Authorization') required String auth,
    @Query('user_id') required String id
  });

  @DELETE('/user_')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<List<User>> usersDeleteRequest({
    @Header('Authorization') required String auth,
    @Query('user_id') required String? ids
  });

  @GET('/user_type')
  Future<List<UserType>> getUserTypeRequest({
    @Header('Authorization') required String auth,
  });



  @PATCH('/supplier')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<List<Supplier>> supplierUpdateRequest({
    @Header('Authorization') required String auth,
    @Query('supplier_id') required String id,
    @Body() required SupplierUpdateRequest body
  });

  @DELETE('/supplier')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<List<Supplier>> supplierDeleteRequest({
    @Header('Authorization') required String auth,
    @Query('supplier_id') required String id
  });

  @GET('/supplier_account')
  Future<List<SupplierAccount>> supplierAccountRequest({
    @Header('Authorization') required String auth,
    @Query('supplier_id') String? supplierId,
    @Query('supplier_account_id') String? id
  });

  @POST('/supplier_account')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<List<SupplierAccount>> supplierAccountInsertRequest({
    @Header('Authorization') required String auth,
    @Body() required SupplierAccountInsertRequest body
  });

  @DELETE('/supplier_account')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<List<SupplierAccount>> supplierAccountDeleteRequest({
    @Header('Authorization') required String auth,
    @Query('supplier_account_id') required String id
  });

  @PATCH('/supplier_account')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<List<SupplierAccount>> supplierAccountUpdateRequest({
    @Header('Authorization') required String auth,
    @Query('supplier_account_id') required String id,
    @Body() required SupplierAccountUpdateRequest body
  });

  @GET('/service_scenario')
  Future<List<ServiceScenario>> getServiceScenarioRequest({
    @Header('Authorization') required String auth,
  });

  @POST('/rpc/login_user')
  Future<LoginUserResponse> loginUserRequest(
    @Body() LoginUserRequest body
  );

  @POST('/rpc/logout_user')
  Future<void> logoutUserRequest({
    @Header('Authorization') required String auth,
  });

  @POST('/rpc/user_right')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<List<UserRight>> userRightRequest({
    @Header('Authorization') required String auth,
    @Body() required UserRightRequest body
  });

  //USER ROLES 
  @GET('/role')
  Future<List<Role>> getRoleRequest({
    @Header('Authorization') required String auth,
  });

  @POST('/rpc/user_role')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<List<UserRole>> getUserRoleRequest({
    @Header('Authorization') required String auth,
    @Body() required UserRoleRequest body
  });

  @POST('/rpc/user_role_set')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<String> setUserRoleRequest({
    @Header('Authorization') required String auth,
    @Body() required SetUserRoleRequest body
  });
//


  @GET('/op_audit')
  Future<List<Audit>> getAuditRequest({
    @Header('Authorization') required String auth,
    @Query('limit') int? count,
    @Query('offset') int? offset,
    @Query('order') String? order,
    @Query('and') String? date,
    @Query('action_arm') String? appication,
    @Query('action_id') String? action,
    @Query('supplier_id') String? supplierId,
    @Query('op_descr') String? description,
  });

  @GET('/audit_application')
  Future<List<AuditApplication>> getAuditApplicationsRequest({
    @Header('Authorization') required String auth,
  });

  @GET('/audit_action')
  Future<List<AuditAction>> getAuditActionRequest({
    @Header('Authorization') required String auth,
  });

  @POST('/rpc/op_audit_archive_day')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<String> audidArchiveRequest(
    @Header('Authorization') String auth,
    @Body() AuditArchiveRequest body
  );

  @GET('/supplier_server_message')
  Future<List<ServerMessage>> getSupplierServerMessages({
    @Header('Authorization') required String auth,
    @Query('limit') int? count,
    @Query('order') String? order,
    @Query('offset') int? offset,
    @Query('and') String? date,
    //@Query('status_id') String? status,
    @Query('state_name') String? statusName,
    @Query('heading') String? heading,
    @Query('note') String? note,
    @Query('message_id') String? id,
  });
 
  @DELETE('/supplier_server_message')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<List<ServerMessage>> serverMessageDeleteRequest({
    @Header('Authorization') required String auth,
    @Query('message_id') required String id
  });

  @POST('/supplier_server_message')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<List<ServerMessage>> serverMessageInsertRequest({
    @Header('Authorization') required String auth,
    @Body() required ServerMessageInsertRequest body
  });

  @PATCH('/supplier_server_message')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<List<ServerMessage>> serverMessageUpdateRequest({
    @Header('Authorization') required String auth,
    @Query('message_id') required String id,
    @Body() required ServerMessageUpdateRequest body
  });

  @POST('/rpc/change_password')
  Future<ChangePasswordResponse> changePasswordRequest(
    @Header('Authorization') String auth,
    @Body() ChangePasswordRequest body
  );

  @POST('/rpc/reset_password')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<String> resetPasswordRequest(
    @Header('Authorization') String auth,
    @Body() ResetPasswordRequest body
  );

  
  //JOB
  @GET('/job_config')
  Future<List<Job>> getJobsRequest({
    @Header('Authorization') required String auth,
    @Query('limit') int? count,
    @Query('order') String? order,
    @Query('offset') int? offset,
    @Query('job_id') String? id,
    @Query('job_name') String? name,
    @Query('select') String? select,
  });

  @POST('/job_config')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<List<Job>> jobInsertRequest({
    @Header('Authorization') required String auth,
    @Body() required JobInsertRequest body
  });
  
  @PATCH('/job_config')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<List<Job>> jobUpdateRequest({
    @Header('Authorization') required String auth,
    @Query('job_id') required String id,
    @Body() required JobUpdateRequest body
  });

  @DELETE('/job_config')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<List<Job>> jobDeleteRequest({
    @Header('Authorization') required String auth,
    @Query('job_id') required String id
  });

  
  //OUT SERVER
  @GET('/out_server')
  Future<List<OutServer>> getOutServerRequest({
    @Header('Authorization') required String auth
  });

  //JOB PART
  @GET('/job_part')
  Future<List<JobPart>> getJobPartRequest({
    @Header('Authorization') required String auth,
    @Query('limit') int? count,
    @Query('order') String? order,
    @Query('offset') int? offset,
    @Query('select') String? select,
    @Query('job_id') String? jobId,
    @Query('job_part_id') String? id,
    @Query('action_type') String? typeNum,
    @Query('period_type_name') String? periodType
  });

  @POST('/job_part')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<List<JobPart>> jobPartInsertRequest({
    @Header('Authorization') required String auth,
    @Body() required JobPartInsertRequest body
  });

  @GET('/job_part_action_type')
  Future<List<ActionType>> getActionTypeRequest({
    @Header('Authorization') required String auth,
  });

  @GET('/message_type')
  Future<List<MessageType>> getMessageTypeRequest({
    @Header('Authorization') required String auth,
  });

  @GET('/job_part_period_type')
  Future<List<PeriodType>> getPeriodTypeRequest({
    @Header('Authorization') required String auth,
  });

  @PATCH('/job_part')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<List<JobPart>> jobPartUpdateRequest({
    @Header('Authorization') required String auth,
    @Query('job_part_id') required String id,
    @Body() required JobPartUpdateRequest body
  });

  @DELETE('/job_part')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<List<JobPart>> jobPartDeleteRequest({
    @Header('Authorization') required String auth,
    @Query('job_part_id') required String id
  });

  // JOB PART PARAM
  @GET('/job_part_param')
  Future<List<JobPartParam>> getJobPartParamRequest({
    @Header('Authorization') required String auth,
    @Query('limit') int? count,
    @Query('order') String? order,
    @Query('offset') int? offset,
    @Query('job_part_param_id') String? id,
    @Query('job_part_id') String? jobPartId,
    @Query('param_name') String? name,
    @Query('select') String? select,
  });

  @GET('/job_part_param')
  Future<List<JobPartRunParam>> getJobPartRunParamRequest({
    @Header('Authorization') required String auth,
    @Query('job_part_param_id') String? id,
    @Query('job_part_id') String? jobPartId,
  });

  @POST('/job_part_param')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<List<JobPartParam>> jobPartParamInsertRequest({
    @Header('Authorization') required String auth,
    @Body() required JobPartParamInsertRequest body
  });

  @PATCH('/job_part_param')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<List<JobPartParam>> jobPartParamUpdateRequest({
    @Header('Authorization') required String auth,
    @Query('job_part_param_id') required String id,
    @Body() required JobPartParamUpdateRequest body
  });

  @DELETE('/job_part_param')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<List<JobPartParam>> jobPartParamDeleteRequest({
    @Header('Authorization') required String auth,
    @Query('job_part_param_id') required String id
  });


  @POST('/rpc/job_execute')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<String> jobRunRequest(
    @Header('Authorization') String auth,
    @Body() JobRunRequest body
  );

  @POST('/rpc/job_part_execute')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<String>jobPartRunRequest(
    @Header('Authorization') String auth,
    @Body() JobPartRunRequest body
  );


  @POST('/rpc/start_message_reset')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<String> startMessageRequest(
    @Header('Authorization') String auth,
    @Body() StartMessageRequest body
  );
}


