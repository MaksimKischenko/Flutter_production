import 'package:bpc/data/data.dart';
import 'package:equatable/equatable.dart';

class NewClaimData extends Equatable {
  Service? selectedService;
  String? accNum;
  double? sum;
  DateTime? dueDate;
  String? description;
  /// Имя
  String? firstName;
  /// Фамилия
  String? surname;
  /// Отчество
  String? patronic;
  String? address;
  /// 0 - не уведомлять (or null), 1 - email, 2 - sms, 3 - оба
  int? typeNotification;
  String? email;
  String? phone;
  // Счетчики
  List<Device>? devices;

  NewClaimData({
    this.selectedService,
    this.accNum,
    this.sum,
    this.dueDate,
    this.description,
    this.firstName,
    this.surname,
    this.patronic,
    this.address,
    this.typeNotification,
    this.email,
    this.phone,
    this.devices
  });

  @override
  List<Object?> get props => [
    selectedService,
    accNum,
    sum,
    dueDate,
    description,
    firstName,
    surname,
    patronic,
    address,
    typeNotification,
    email,
    phone,
    devices,
  ];
}
