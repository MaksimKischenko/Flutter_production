enum NotificationMethodTypes {
  sms('SMS', 0),
  email('E-mail', 1);


  const NotificationMethodTypes(this.typeName, this.typeCode);
  final String typeName;
  final int typeCode;
}
