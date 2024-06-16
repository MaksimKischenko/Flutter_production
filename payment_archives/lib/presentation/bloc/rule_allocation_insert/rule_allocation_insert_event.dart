part of 'rule_allocation_insert_bloc.dart';

abstract class RuleAllocationInsertEvent extends Equatable {
  const RuleAllocationInsertEvent();

  @override
  List<Object?> get props => [];
}



class RuleAllocationInsertInit extends RuleAllocationInsertEvent {}

class RuleAllocationInsertRun extends RuleAllocationInsertEvent {
  
  final RuleAllocationInsertRequest ruleAllocationInsertBody;

  const RuleAllocationInsertRun(this.ruleAllocationInsertBody);

  @override
  List<Object?> get props => [ruleAllocationInsertBody];
}
