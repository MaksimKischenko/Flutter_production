import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/screens/administration/rule_allocations/listeners/listeners.dart';
import 'package:payment_tracking_module/presentation/screens/administration/rule_allocations/widgets/widgets.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';



class RuleAllocationsScreenBody extends StatelessWidget {
  const RuleAllocationsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    
    bool? _isSelected;
    RuleAllocationData? _ruleAllocation;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text('Правила распределения архивов', style: AppStyles.headerStyle)
            ),    
            const SizedBox(height: 24),                      
            BlocConsumer<RowSelectedBloc<RuleAllocationData>, RowSelectedState<RuleAllocationData>>(
              listener: (context, state) {
                _isSelected = state.selectedData.isSelected;
                _ruleAllocation = state.selectedData.selectedObject;                  
              },
              builder: (context, state) => RuleAllocationMenu(
                  isSelected: _isSelected ?? false,
                  ruleAllocation: _ruleAllocation,
                ),
            ),
            BlocConsumer<RuleAllocationBloc, RuleAllocationState>(
              listener: (context, state) => RuleAllocationsListener.fromActions(context, state, () => null),
              builder: (context, state) {
                Widget body = const SizedBox();
                if (state is RuleAllocationLoading) {
                  body = const Expanded(
                    child: Center(child: LoadingIndicator(indicatorsSize: 72)),
                  );
                } else if (state is RuleAllocationLoaded) {
                  body = Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: RuleAllocationTable(
                            ruleAllocations: state.ruleAllocations,
                          ),
                        ),                        
                      ],
                    ),
                  );
                }
                return body;
              },
            )
          ],
        ),
      ),
    );
  } 
}
