import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:payment_tracking_module/domain/repositories/repositories.dart';
import 'package:payment_tracking_module/main.dart';
import 'package:retrofit/dio.dart';

class RuleAllocationUseCase {
  final RuleAllocationDataRepository ruleAllocationRepository;
  final DataSourcesRepository dataSourcesRepository;
  final ArchiveLocationsRepository archiveLocationsRepository;

  RuleAllocationUseCase() : 
   ruleAllocationRepository = getIt<RuleAllocationDataRepositoryImpl>(),
   dataSourcesRepository = getIt<DataSourcesRepositoryImpl>(),
   archiveLocationsRepository = getIt<ArchiveLocationsRepositoryImpl>();


  Future<Either<Failure, HttpResponse<List<RuleAllocationData>>>> getRuleAlInstances({int? id}) async => 
  await ruleAllocationRepository.getInstances(id: id);

  Future<Either<Failure, HttpResponse<List<RuleAllocationData>>>> saveInstance(RuleAllocationInsertRequest request) async => 
  await ruleAllocationRepository.saveInstance(request);


  Future<Either<Failure, HttpResponse<List<RuleAllocationData>>>> editInstance({
    required RuleAllocationUpdateRequest request, 
    required int id
  }) async => await ruleAllocationRepository.editInstance(request: request, id: id);

  Future<Either<Failure, HttpResponse<List<RuleAllocationData>>>> deleteInstance({required int id}) async => 
  await ruleAllocationRepository.deleteInstance(id: id);   

  Future<Either<Failure, HttpResponse<List<DataSource>>>> getDataSInstances({int? id}) async => 
  await dataSourcesRepository.getInstances(id: id); 

  Future<Either<Failure, HttpResponse<List<ArchiveLocation>>>> getArchiveAlInstances({int? id}) async => 
   await archiveLocationsRepository.getInstances(id: id); 

  void sortValues({
    required List<RuleAllocationData> ruleAllocations,
    required bool ascending,
    required int sortIndex    
  }) {
      switch (sortIndex) {
        case 0:
          ascending?
          ruleAllocations.sort((b, a) => (a.sourceId ?? 0).compareTo(b.sourceId ?? 0)):
          ruleAllocations.sort((a, b) => (a.sourceId ?? 0).compareTo(b.sourceId ?? 0));
          break;
        case 1:
          ascending?
          ruleAllocations.sort((b, a) => (a.storeYear ?? 0).compareTo(b.storeYear ?? 0)):
          ruleAllocations.sort((a, b) => (a.storeYear ?? 0).compareTo(b.storeYear ?? 0));
          break;         
        case 2:
          ascending?
          ruleAllocations.sort((b, a) => (a.storeMonth ?? 0).compareTo(b.storeMonth ?? 0)):
          ruleAllocations.sort((a, b) => (a.storeMonth ?? 0).compareTo(b.storeMonth ?? 0));
          break;
        case 3:
          ascending?
          ruleAllocations.sort((b, a) => (a.storeDay ?? 0).compareTo(b.storeDay ?? 0)):
          ruleAllocations.sort((a, b) => (a.storeDay ?? 0).compareTo(b.storeDay ?? 0));
          break; 
        case 4:
          ascending?
          ruleAllocations.sort((b, a) => (a.locationId ?? 0).compareTo(b.locationId ?? 0)):
          ruleAllocations.sort((a, b) => (a.locationId ?? 0).compareTo(b.locationId ?? 0));
          break;    
        case 5:
          ascending?
          ruleAllocations.sort((b, a) => (a.storeDate ?? '').compareTo(b.storeDate ?? '')):
          ruleAllocations.sort((a, b) => (a.storeDate ?? '').compareTo(b.storeDate ?? ''));
          break;                                                       
      }
  }   
}


    