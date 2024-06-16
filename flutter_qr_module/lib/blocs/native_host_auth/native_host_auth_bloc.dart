import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_qr_module/config.dart';
import 'package:fl_qr_module/data/data.dart';
import 'package:flutter/services.dart';

part 'native_host_auth_event.dart';
part 'native_host_auth_state.dart';



class NativeHostAuthBloc extends Bloc<NativeHostAuthEvent, NativeHostAuthState> {
  final DataManager dataManager;

  NativeHostAuthBloc({required this.dataManager}) : super(NativeHostAuthInitial()) {
    on<NativeHostAuthEvent>(_onEvent);
  }


  NativeHostAuthData? data;

  Future<void>? _onEvent(NativeHostAuthEvent event, Emitter<NativeHostAuthState> emit) {
    if (event is NativeHostAuthRun) return _onAuthRun(event, emit);
    return null;
  }

  Future<void> _onAuthRun(
    NativeHostAuthRun event, 
    Emitter<NativeHostAuthState> emit) async {
    emit(NativeHostAuthLoading());

    try {
      if(AppConfig.isDebugMode) {
        data = NativeHostAuthData(
          qrScanUrl:'https://qrpay.mdom.by',
          qrPayUrl:'https://qrhelppay.mdom.by',
          terminalId: 'TERM_FIZ_MB', 
          typePan: 'ACCOUNT', 
          pan: 'BY74AEBK30141000019330000465'
        );
        dataManager.nativeHostPayData = data;
      } else {
        const MethodChannel('dataChannel')
            .setMethodCallHandler((call) async{
            if(call.method == 'postArgs') {
            final stringData = await call.arguments as String;
            final args = json.decode(stringData);
            data = NativeHostAuthData.fromJson(args);
            dataManager.nativeHostPayData = data;
          }
        });
      }

      if(await SecureStorageManager.read(SecureStorageKeys.secretKeyPart) == null) {
        await SecureStorageManager.write(SecureStorageKeys.secretKeyPart,
          '707BDCE37B9A7A7B358FFC92E2B002BF37147AFB10D14F049A02F8C7F8A0F78C');
      }     

      emit(NativeHostAuthSuccess(data:data)); 
      
    } catch (error) {
      emit(NativeHostAuthError(error: error));
    }
  }
}
