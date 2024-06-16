class SelectedData<T> {
  bool? isSelected;
  T? selectedObject;

  SelectedData({
    this.isSelected,
    this.selectedObject,
  });  

  factory SelectedData.empty()=> SelectedData(isSelected: false, selectedObject: null);

  @override
  String toString() => 'SelectedDataNew(isSelected: $isSelected, selectedObject: $selectedObject)';
}
