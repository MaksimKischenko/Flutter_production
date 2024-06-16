class SelectableListItem<T> {
  final bool isSelected;
  final T data;

  const SelectableListItem(
    this.data,
    {this.isSelected = false}
  );

}