part of 'row_selected_bloc.dart';

abstract class RowSelectedEvent<T> extends Equatable {
  const RowSelectedEvent();

  @override
  List<Object?> get props => [];
}

class RowSelectedRun<T> extends RowSelectedEvent<T> {
  final SelectedData<T>? selectedData;

  const RowSelectedRun({
    required this.selectedData,
  });

  @override
  List<Object?> get props => [selectedData];

}