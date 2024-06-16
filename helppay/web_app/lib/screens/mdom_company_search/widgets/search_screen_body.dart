import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/routing/routes.gr.dart';
import 'package:helppay_web_app/screens/mdom_company_search/widgets/widgets.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:helppay_web_app/widgets/widgets.dart';

class SearchScreenBody extends StatefulWidget {
  final void Function(InfoSupplierResponseCompany? company) selectCompany;
  final TextEditingController unpSearchController;
  final TextEditingController nameSearchController;
  const SearchScreenBody({
    super.key,
    required this.selectCompany,
    required this.unpSearchController,
    required this.nameSearchController,
  });

  @override
  State<SearchScreenBody> createState() => _SearchScreenBodyState();
}

class _SearchScreenBodyState extends State<SearchScreenBody> {
  InfoSupplierResponseCompany? _selectedCompany;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<InfoSupplierBloc, InfoSupplierState>(
        builder: (context, state) {
          Widget body = const SizedBox();
          if (state is InfoSupplierInitial) {
            return body;
          } else if (state is InfoSupplierLoading) {
            body = const Padding(
              padding: EdgeInsets.symmetric(vertical: 44),
              child: Center(
                child: LoadingIndicator(),
              ),
            );
          } else if (state is InfoSupplierError) {
            body = Error(
              context,
              message: state.error.toString(),
              onRepeatTap: () => context.read<InfoSupplierBloc>().add(
                    InfoSupplierLoad(
                      supplierName: widget.nameSearchController.text,
                      supplierUNN: int.parse(widget.unpSearchController.text),
                    ),
                  ),
            );
          } else if (state is InfoSupplierErrorKomplat) {
            final isTokenError = state.errorCode == 403;

            body = isTokenError
                ? ErrorToken(
                    context,
                    message: state.errorMessage,
                    onRepeatTap: () => context.read<InfoSupplierBloc>().add(
                          InfoSupplierLoad(
                            supplierName: widget.nameSearchController.text,
                            supplierUNN:
                                int.parse(widget.unpSearchController.text),
                          ),
                        ),
                  )
                : Error(
                    context,
                    message: state.errorMessage,
                    onRepeatTap: () => context.read<InfoSupplierBloc>().add(
                          InfoSupplierLoad(
                            supplierName: widget.nameSearchController.text,
                            supplierUNN:
                                int.parse(widget.unpSearchController.text),
                          ),
                        ),
                  );
            if (isTokenError) {
              Future.delayed(
                  const Duration(seconds: 2),
                  () => AutoRouter.of(context).pushAndPopUntil(AuthRoute(),
                      predicate: (route) => false));
            }
          } else if (state is InfoSupplierLoaded) {
            body = Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Column(
                    children: [
                      if (state.companies.isNotEmpty)
                        ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          separatorBuilder: (context, _) => Divider(
                            color: AppStyles.mainColorDark.withOpacity(0.1),
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.companies.length,
                          itemBuilder: (context, index) => CompanyItem(
                            company: state.companies[index],
                            selected:
                                _selectedCompany == state.companies[index],
                            onTap: () => {
                              setState(() {
                                _selectedCompany = state.companies[index];
                              }),
                              widget.selectCompany(state.companies[index]),
                            },
                          ),
                        )
                    ],
                  ),
                ),
              ),
            );
          }
          return body;
        },
      );
}
