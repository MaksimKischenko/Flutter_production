import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:payment_tracking_module/domain/repositories/repositories.dart';
import 'package:payment_tracking_module/main.dart';
import 'package:retrofit/retrofit.dart';

class PaymentsUseCase {
  final PaymentsRepositiry paymentsRepositiry;
  final DataManager dataManager;

  PaymentsUseCase() : 
   paymentsRepositiry = getIt<PaymentsRepositiryImpl>(),
   dataManager = getIt<PaymentsRepositiryImpl>().dataManager;

  Future<Either<Failure, HttpResponse<String>>> prepearInstances({required SearchPaymentData request, required SearchPaymentMethod searchPaymentMethod}) async => 
  await paymentsRepositiry.prepearInstances(request: request, searchPaymentMethod: searchPaymentMethod);

  Future<Either<Failure, HttpResponse<List<Payment>>>> getInstances({required FinalSearchPaymentRequest request}) async =>
   await paymentsRepositiry.getInstances(request: request); 

  void sortValues({
    required List<Payment> payments,
    required bool ascending,
    required int sortIndex
    }) {
      switch (sortIndex) {
        case 1:
          ascending?
          payments.sort((b, a) => (a.payerFullName ?? '').compareTo(b.payerFullName ?? '')):
          payments.sort((a, b) => (a.payerFullName ?? '').compareTo(b.payerFullName ?? ''));
          break;
        case 2:
          ascending?
          payments.sort((b, a) => (a.payerAddress ?? '').compareTo(b.payerAddress ?? '')):
          payments.sort((a, b) => (a.payerAddress ?? '').compareTo(b.payerAddress ?? ''));
          break;
        case 3:
          ascending?
          payments.sort((b, a) => (a.fullNameDepositor ?? '').compareTo(b.fullNameDepositor ?? '')):
          payments.sort((a, b) => (a.fullNameDepositor ?? '').compareTo(b.fullNameDepositor ?? ''));
          break;  
        case 4:
          ascending?
          payments.sort((b, a) => (a.depositorAddress ?? '').compareTo(b.depositorAddress ?? '')):
          payments.sort((a, b) => (a.depositorAddress ?? '').compareTo(b.depositorAddress ?? ''));
          break;  
        case 5:
          ascending?
          payments.sort((b, a) => (a.supplierName ?? '').compareTo(b.supplierName ?? '')):
          payments.sort((a, b) => (a.supplierName ?? '').compareTo(b.supplierName ?? ''));
          break;  
        case 6:
          ascending?
          payments.sort((b, a) => (a.serviceName ?? '').compareTo(b.serviceName ?? '')):
          payments.sort((a, b) => (a.serviceName ?? '').compareTo(b.serviceName ?? ''));
          break;  
        case 7:
          ascending?
          payments.sort((b, a) => (a.supplierAccount ?? '').compareTo(b.supplierAccount ?? '')):
          payments.sort((a, b) => (a.supplierAccount ?? '').compareTo(b.supplierAccount ?? ''));
          break;    
        case 8:
          ascending?
          payments.sort((b, a) => (a.bankName ?? '').compareTo(b.bankName ?? '')):
          payments.sort((a, b) => (a.bankName ?? '').compareTo(b.bankName ?? ''));
          break;    
        case 9:
          ascending?
          payments.sort((b, a) => (a.bankBik ?? '').compareTo(b.bankBik ?? '')):
          payments.sort((a, b) => (a.bankBik ?? '').compareTo(b.bankBik ?? ''));
          break;    
        case 10:
          ascending?
          payments.sort((b, a) => (a.budgetCode ?? 0).compareTo(b.budgetCode ?? 0)):
          payments.sort((a, b) => (a.budgetCode ?? 0).compareTo(b.budgetCode ?? 0));
          break;    
        case 11:
          ascending?
          payments.sort((b, a) => (a.paySum ?? 0).compareTo(b.paySum ?? 0)):
          payments.sort((a, b) => (a.paySum ?? 0).compareTo(b.paySum ?? 0));
          break;    
        case 12:
          ascending?
          payments.sort((b, a) => (a.commissionSum ?? 0).compareTo(b.commissionSum ?? 0)):
          payments.sort((a, b) => (a.commissionSum ?? 0).compareTo(b.commissionSum ?? 0));
          break;    
        case 13:
          ascending?
          payments.sort((b, a) => (a.penaltySum ?? 0).compareTo(b.penaltySum ?? 0)):
          payments.sort((a, b) => (a.penaltySum ?? 0).compareTo(b.penaltySum ?? 0));
          break;    
        case 14:
          ascending?
          payments.sort((b, a) => (a.terminalId ?? '').compareTo(b.terminalId ?? '')):
          payments.sort((a, b) => (a.terminalId ?? '').compareTo(b.terminalId ?? ''));
          break;    
        case 15:
          ascending?
          payments.sort((b, a) => (a.terminalDept ?? 0).compareTo(b.terminalDept ?? 0)):
          payments.sort((a, b) => (a.terminalDept ?? 0).compareTo(b.terminalDept ?? 0));
          break;    
        case 16:
          ascending?
          payments.sort((b, a) => (a.deptFilial ?? 0).compareTo(b.deptFilial ?? 0)):
          payments.sort((a, b) => (a.deptFilial ?? 0).compareTo(b.deptFilial ?? 0));
          break;    
        case 17:
          ascending?
          payments.sort((b, a) => (a.terminaLocation ?? '').compareTo(b.terminaLocation ?? '')):
          payments.sort((a, b) => (a.terminaLocation ?? '').compareTo(b.terminaLocation ?? ''));
          break;    
        case 18:
          ascending?
          payments.sort((b, a) => (a.receiptNo ?? '').compareTo(b.receiptNo ?? '')):
          payments.sort((a, b) => (a.receiptNo ?? '').compareTo(b.receiptNo ?? ''));
          break;    
        case 19:
          ascending?
          payments.sort((b, a) => (a.externalSystemPaymentId ?? '').compareTo(b.externalSystemPaymentId ?? '')):
          payments.sort((a, b) => (a.externalSystemPaymentId ?? '').compareTo(b.externalSystemPaymentId ?? ''));
          break;    
        case 20:
          ascending?
          payments.sort((b, a) => (a.payDate ?? DateTime.now()).compareTo(b.payDate ?? DateTime.now())):
          payments.sort((a, b) => (a.payDate ?? DateTime.now()).compareTo(b.payDate ?? DateTime.now()));
          break;   
        case 21:
          ascending?
          payments.sort((b, a) => (a.consolidatedDocDate ?? DateTime.now()).compareTo(b.consolidatedDocDate ?? DateTime.now())):
          payments.sort((a, b) => (a.consolidatedDocDate ?? DateTime.now()).compareTo(b.consolidatedDocDate ?? DateTime.now()));
          break;  
        case 22:
          ascending?
          payments.sort((b, a) => (a.consolidatedDocId ?? 0).compareTo(b.consolidatedDocId ?? 0)):
          payments.sort((a, b) => (a.consolidatedDocId ?? 0).compareTo(b.consolidatedDocId ?? 0));
          break;  
        case 23:
          ascending?
          payments.sort((b, a) => (a.externalSystemPaymentId ?? '').compareTo(b.externalSystemPaymentId ?? '')):
          payments.sort((a, b) => (a.externalSystemPaymentId ?? '').compareTo(b.externalSystemPaymentId ?? ''));
          break;  
        case 24:
          ascending?
          payments.sort((b, a) => (a.consolidatedDocPayString ?? '').compareTo(b.consolidatedDocPayString ?? '')):
          payments.sort((a, b) => (a.consolidatedDocPayString ?? '').compareTo(b.consolidatedDocPayString ?? ''));
          break;  
        case 25:
          ascending?
          payments.sort((b, a) => (a.consolidatedExportFileName ?? '').compareTo(b.consolidatedExportFileName ?? '')):
          payments.sort((a, b) => (a.consolidatedExportFileName ?? '').compareTo(b.consolidatedExportFileName ?? ''));
          break;  
        case 26:
          ascending?
          payments.sort((b, a) => (a.region ?? '').compareTo(b.region ?? '')):
          payments.sort((a, b) => (a.region ?? '').compareTo(b.region ?? ''));
          break;   
        case 27:
          ascending?
          payments.sort((b, a) => (a.cardNumber ?? '').compareTo(b.cardNumber ?? '')):
          payments.sort((a, b) => (a.cardNumber ?? '').compareTo(b.cardNumber ?? ''));
          break;                                                                                                                                                                                                                                                           
      }
  }     
}

