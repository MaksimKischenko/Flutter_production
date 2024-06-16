class ModalActionItem {
  final String text;
  final dynamic value;
  final bool isDestructive;

  const ModalActionItem({
    required this.text,
    required this.value,
    this.isDestructive = false
  });
}