part of 'row_selected_bloc.dart';

 class RowSelectedState<T> extends Equatable {
  final SelectedData<T> selectedData;

  const RowSelectedState({
    required this.selectedData
  });
  
  @override
  List<Object?> get props => [selectedData];

  RowSelectedState<T> copyWith({
    SelectedData<T>? selectedData,
  }) => RowSelectedState(
    selectedData: selectedData ?? this.selectedData,
  );
}
