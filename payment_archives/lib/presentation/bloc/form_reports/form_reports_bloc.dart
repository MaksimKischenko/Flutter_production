import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/domain/use_cases/form_reports/report_factory.dart';


part 'form_reports_event.dart';
part 'form_reports_state.dart';


class FormReportsBloc extends Bloc<FormReportsEvent, FormReportsState> {
  final ReportFactory? reportFactory;
  
  FormReportsBloc():
  reportFactory = ReportFactory(),
  super(FormReportsInitial()) {
    on<FormReportsEvent>(_onEvent);
  }



  Future<void>? _onEvent(
    FormReportsEvent event,
    Emitter<FormReportsState> emit,
  ) {
    if (event is FormReportsInit) return _onReportsInit(event, emit);
    return null;
  }


  Future<void> _onReportsInit(
    FormReportsInit event,
    Emitter<FormReportsState> emit,
  ) async {

    final reportGenerator = reportFactory?.createReportGenerator(event.reportsType);
    final result = await reportGenerator?.generateReports(event);
    result?.fold(
      (left) => emit(FormReportsError(error: left.message)), 
      (right) => emit(FormReportsSuccess())
    );
  }
}
