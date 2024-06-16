import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/injection_component.dart';
import 'package:bpc/models/claims_filter_data.dart';
import 'package:bpc/screens/new_claim/main_widgets/new_claim_screen_body.dart';
import 'package:bpc/screens/new_claim/main_widgets/new_claim_web_screen_body.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewClaimScreen extends StatelessWidget {
  final Service? initialService;
  final List<Service> servicesList;
  final ClaimsFilterData filtersData;
  // final ScrollController scrollController;

  const NewClaimScreen({
    required this.initialService,
    required this.servicesList,
    required this.filtersData,
    // required this.scrollController,
  });

  @override
  Widget build(BuildContext context) => BlocProvider<NewClaimBloc>(
        create: (context) => NewClaimBloc(
          dataManager: InjectionComponent.getDependency<DataManager>(),
        ),
        child: kIsWeb
            ? NewClaimWebScreenBody(
                initialService: initialService,
                servicesList: servicesList,
                filterData: filtersData,
              )
            : NewClaimScreenBody(
                initialService: initialService,
                servicesList: servicesList,
                filterData: filtersData,
                // scrollController: scrollController,
              ),
      );
}
