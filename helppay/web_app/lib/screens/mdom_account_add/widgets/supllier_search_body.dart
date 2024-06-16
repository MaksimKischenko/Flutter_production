import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/screens/mdom_company_search/widgets/widgets.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:helppay_web_app/widgets/widgets.dart';

class SupplierSearchBody extends StatefulWidget {
  final void Function(InfoSupplierResponseCompany? company) selectCompany;
  const SupplierSearchBody({
    super.key,
    required this.selectCompany,
  });

  @override
  State<SupplierSearchBody> createState() => _SupplierSearchBodyState();
}

class _SupplierSearchBodyState extends State<SupplierSearchBody> {
  InfoSupplierResponseCompany? _selectedCompany;

  @override
  Widget build(BuildContext context) =>
    BlocBuilder<InfoSupplierBloc, InfoSupplierState>(
      builder: (context, state) {
        Widget body = const SizedBox.shrink();
        if (state is InfoSupplierInitial) {
          return body;
        } else if (state is InfoSupplierLoading) {
          body = const Padding(
            padding: EdgeInsets.symmetric(vertical: 44),
            child: Center(
              child: LoadingIndicator(),
            ),
          );
        } else if (state is InfoSupplierLoaded) {
          body = SizedBox(
            height: MediaQuery.of(context).size.height * 2,
            child: SingleChildScrollView(
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
          );
        }
        return body;
      },
    );
}
