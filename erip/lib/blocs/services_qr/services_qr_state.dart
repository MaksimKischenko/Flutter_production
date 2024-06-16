part of 'services_qr_bloc.dart';

abstract class ServicesQrState extends Equatable {
  const ServicesQrState();
  
  @override
  List<Object> get props => [];
}

class ServicesQrLoading extends ServicesQrState {}


class ServicesQrInitial extends ServicesQrState {
  final Service selected;
  final List<Service> available;
  final String qrData;

  const ServicesQrInitial({
    required this.selected,
    required this.available,
    required this.qrData
  });

  @override
  List<Object> get props => [selected.code ?? 0, selected.name, available, qrData];
}

class ServicesQrUnavailable extends ServicesQrState {}