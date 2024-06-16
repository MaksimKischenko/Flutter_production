import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/domain/use_cases/use_cases.dart';
import 'package:uuid/uuid.dart';

part 'search_payment_event.dart';
part 'search_payment_state.dart';

class SearchPaymentBloc extends Bloc<SearchPaymentEvent, SearchPaymentState> {
  final PaymentsUseCase useCase;
  SearchPaymentBloc() 
  : useCase = PaymentsUseCase(),
  super(SearchPaymentActualInfo(
    initialState: true,
    payments: const [],
    requestData: SearchPaymentData.empty(),
    paymentLoadedLimit: PaymentLoadedLimit.small
  )) {
    on<SearchPaymentEvent>(_onEvent);
  }

  String? _uuidCode;
  final List<Payment> _payments = [];
  SearchPaymentData? data;
  bool isActiveNextLoaded = false;
  PaymentLoadedLimit paymentLoadedLimit = PaymentLoadedLimit.small;
  SearchPaymentMethod? _searchPaymentMethod;
  Future<void>? _onEvent(
    SearchPaymentEvent event,
    Emitter<SearchPaymentState> emit,
  ) {
    if (event is SearchPaymentSaveLimits) return _onSearchPaymentSaveLimits(event, emit);
    if (event is SearchPaymentInitialize) return _onSearchPaymentInit(event, emit);
    if (event is SearchPaymentRun) return _onSearchPaymentRun(event, emit);
    if (event is SearchPaymentSort) return _onSearchPaymentSort(event, emit);
    if (event is SearchPaymentClearData) return _onSearchPaymentClearData(event, emit);
    return null;
  }


  Future<void> _onSearchPaymentSaveLimits(
    SearchPaymentSaveLimits event,
    Emitter<SearchPaymentState> emit,   
  ) async {

    emit(SearchPaymentLoading());
    
    paymentLoadedLimit = event.paymentLoadedLimit;

    emit(SearchPaymentActualInfo(
      initialState: false,
      payments: _payments,
      requestData: data ?? SearchPaymentData.empty(),
      paymentLoadedLimit: paymentLoadedLimit,
      isActiveNextLoaded: isActiveNextLoaded
    ));    
  }


  Future<void> _onSearchPaymentInit(
    SearchPaymentInitialize event,
    Emitter<SearchPaymentState> emit,   
  ) async {

    emit(SearchPaymentLoading());

    const _uuid = Uuid();
    _uuidCode = _uuid.v1();
    data = event.searchPaymentBody;
    if(_searchPaymentMethod != event.searchPaymentMethod) {
      _payments.clear();
    }
    _searchPaymentMethod = event.searchPaymentMethod;

    final result = await useCase.prepearInstances(
      request: event.searchPaymentBody.
      copyWith(
        uuid: _uuidCode, 
        sourceId: useCase.dataManager.tokendata?.sources?.first, 
        limit: paymentLoadedLimit.count,
        searchPaymentMethod: _searchPaymentMethod
      ), 
      searchPaymentMethod: event.searchPaymentMethod
    );
  
    await result.fold((failure) {
      emit(SearchPaymentNetworkError(error: failure.message));
      emit(SearchPaymentActualInfo(
        initialState: true,
        payments: const [],
        requestData: SearchPaymentData.empty(),
        paymentLoadedLimit: PaymentLoadedLimit.small
      ));      
    }, (right) async {});
  }

  Future<void> _onSearchPaymentRun(
    SearchPaymentRun event,
    Emitter<SearchPaymentState> emit,   
  ) async {

    isActiveNextLoaded  = false;

    if(_uuidCode == event.webSocketData?.payloadId) {
      final result = await useCase.getInstances(request: FinalSearchPaymentRequest(uuid: _uuidCode));

      await result.fold((failure) {
        emit(SearchPaymentNetworkError(error: failure.message));
        emit(SearchPaymentActualInfo(
          initialState: true,
          payments: const [],
          requestData: SearchPaymentData.empty(),
          paymentLoadedLimit: PaymentLoadedLimit.small
        ));          
      }, (right) async {
          _payments.addAll(right.data);

          if(right.data.isNotEmpty) {
            isActiveNextLoaded  = true;
            if(right.data.length < paymentLoadedLimit.count) {
              isActiveNextLoaded  = false;
            } 
          } else {
            isActiveNextLoaded  = false;
          }

          emit(SearchPaymentPartLoaded(
            nextLoadedPayments: right.data,
          ));     
      });
    }
    emit(SearchPaymentActualInfo(
      initialState: false,
      payments: _payments,
      requestData: data ?? SearchPaymentData.empty(),
      paymentLoadedLimit: paymentLoadedLimit,
      isActiveNextLoaded: isActiveNextLoaded
    ));
  }

  Future<void> _onSearchPaymentClearData(
    SearchPaymentClearData event,
    Emitter<SearchPaymentState> emit,   
  ) async {
    _payments.clear();

    emit(SearchPaymentActualInfo(
      initialState: true,
      payments: const [],
      requestData: SearchPaymentData.empty(),
      paymentLoadedLimit: paymentLoadedLimit,
      isActiveNextLoaded: isActiveNextLoaded
    ));
  }

  Future<void> _onSearchPaymentSort(
    SearchPaymentSort event,
    Emitter<SearchPaymentState> emit,   
  ) async {

    useCase.sortValues(
      payments: _payments,
      ascending: event.ascending,
      sortIndex: event.sortIndex
    );

    emit(SearchPaymentActualInfo(
      initialState: false,
      payments: _payments,
      requestData: data ?? SearchPaymentData.empty(),
      paymentLoadedLimit: paymentLoadedLimit,
      isActiveNextLoaded: isActiveNextLoaded
    ));
  }
}
