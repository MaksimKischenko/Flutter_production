import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_payform_app/blocs/blocs.dart';
import 'package:helppay_payform_app/data/data.dart';
import 'package:helppay_payform_app/models/models.dart';
import 'package:helppay_payform_app/navigation.dart';
import 'package:helppay_payform_app/styles.dart';
import 'package:helppay_payform_app/utils/utils.dart';
import 'package:helppay_payform_app/widgets/widgets.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_ui/responsive_ui.dart';

import 'widgets/widgets.dart';

class AllServicesScreen extends StatefulWidget {
  static const pageName = 'Все услуги';
  static const pageRoute = '/all';

  const AllServicesScreen({Key? key}) : super(key: key);

  @override
  _AllServicesScreenState createState() => _AllServicesScreenState();
}

class _AllServicesScreenState extends State<AllServicesScreen> {
  bool firstLoad = true;

  final _searchController = TextEditingController();
  var _filtersExpanded = false;
  final _filtersFormKey = GlobalKey<FormState>();
  var _filters = <FilterAttrRecord>[];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          const CabinetMenu(selected: MenuAvailableItem.all),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              Widget mainBody = Container();

              if (state is AuthLoading) {
                mainBody = Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(width: double.maxFinite),
                      LoadingIndicator()
                    ],
                  ),
                );
              } else if (state is AuthAuthorized){
                if (firstLoad) {
                  context.read<AllServicesBloc>().add(const AllServicesInit());
                  firstLoad = false;
                }

                mainBody = BlocConsumer<AllServicesBloc, AllServicesState>(
                  listener: (context, state) {
                    if (state is AllServicesLoaded) {
                      _filtersExpanded = false;
                      _filters = state.availableFilters.map((e) => FilterAttrRecord(
                        code: e.code,
                        value: ''
                      )).toList();
                    }
                  },
                  builder: (context, state) {
                    Widget body = Container();

                    if (state is AllServicesLoading) {
                      body = Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            SizedBox(width: double.maxFinite),
                            LoadingIndicator()
                          ],
                        ),
                      );
                    } else if (state is AllServicesLoaded) {
                      body = Expanded(
                        child: Scrollbar(
                          child: SingleChildScrollView(
                            child: PageWidget(
                              // for filters
                              maxWidth: 784,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // const SizedBox(height: 32),
                                  // const Padding(
                                  //   padding: EdgeInsets.symmetric(horizontal: 8),
                                  //   child: PageTitle('Все услуги'),
                                  // ),
                                  const SizedBox(height: 32),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: ResponsiveBuilder(
                                      builder: (context, sizingInformation) {
                                        // if (sizingInformation.isMobile) {
                                        if (sizingInformation.screenSize.width < 700) {
                                          // small
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              NameSearchField(
                                                controller: _searchController,
                                                maxLength: state.nameMaxLength,
                                                isSearchButtonVisible: !_filtersExpanded,
                                                onSearchTap: (value) => context.read<AllServicesBloc>().add(AllServicesInit(
                                                  name: value
                                                ))
                                              ),
                                              if (state.availableFilters.isNotEmpty)
                                              Padding(
                                                padding: const EdgeInsets.only(top: 24),
                                                child: ExpandFiltersButton(
                                                  isExpanded: _filtersExpanded,
                                                  onTap: (value) => setState(() {
                                                    _filtersExpanded = value;
                                                  }),
                                                ),
                                              )
                                            ],
                                          );
                                        } else {
                                          // normal
                                          return Row(
                                            children: [
                                              NameSearchField(
                                                controller: _searchController,
                                                maxLength: state.nameMaxLength,
                                                isSearchButtonVisible: !_filtersExpanded,
                                                onSearchTap: (value) => context.read<AllServicesBloc>().add(AllServicesInit(
                                                  name: value
                                                ))
                                              ),
                                              if (state.availableFilters.isNotEmpty)
                                              Padding(
                                                padding: const EdgeInsets.only(left: 24),
                                                child: ExpandFiltersButton(
                                                  isExpanded: _filtersExpanded,
                                                  onTap: (value) => setState(() {
                                                    _filtersExpanded = value;
                                                  }),
                                                ),
                                              )
                                            ],
                                          );
                                        }
                                      }
                                    )
                                  ),
                                  const SizedBox(height: 24),
                                  if (_filtersExpanded)
                                  // TODO
                                  Form(
                                    key: _filtersFormKey,
                                    child: Responsive(
                                      runSpacing: 16,
                                      children: state.availableFilters.map((e) => Div(
                                        divison: const Division(
                                          colL: 4,
                                          colM: 6,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                          child: FilterItem(
                                            item: e,
                                            initialValue: state.appliedFilters.firstOrNullWhere((applied) => e.code == applied.code)?.value,
                                            onSaved: (code, value) {
                                              final _editedIndex = _filters.indexWhere((e) => e.code == code);
                                              _filters[_editedIndex].value = value;
                                            },
                                            onLogicChange: (code, value) {
                                              final _editedIndex = _filters.indexWhere((e) => e.code == code);
                                              _filters[_editedIndex].value = value == null ? null : value ? '1' : '0';
                                            },
                                          ),
                                        ),
                                      )).toList(),
                                    ),
                                  ),
                                  if (_filtersExpanded)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                                    child: FiltersSearchButton(
                                      onTap: () {
                                        if (_filtersFormKey.currentState?.validate() ?? false) {
                                          _filtersFormKey.currentState?.save();

                                          context.read<AllServicesBloc>().add(AllServicesInit(
                                            name: _searchController.text,
                                            filters: _filters
                                          ));
                                        }
                                      }
                                    ),
                                  ),
                                  if (state.services.isNotEmpty)
                                  ListView.separated(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) => EripServiceItem(
                                      item: state.services[index],
                                      onServiceTap: Navigation.toService,
                                    ),
                                    separatorBuilder: (context, _) => Divider(
                                      height: 1,
                                      color: AppStyles.secondaryTextColor.withOpacity(0.4)
                                    ),
                                    itemCount: state.services.length
                                  ),
                                  if (state.services.isEmpty)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: const [
                                        SizedBox(height: 32),
                                        Text(
                                          'По вашему запросу ничего не найдено',
                                          style: TextStyle(
                                            color: AppStyles.mainTextColor,
                                            fontSize: 16
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if (state is AllServicesError) {
                      body = Expanded(
                        child: PageError(
                          message: RequestUtil.kNetworkError,
                          onRepeatTap: () => context.read<AllServicesBloc>().add(AllServicesInit(
                            name: _searchController.text,
                            filters: _filters
                          )),
                        ),
                      );
                    } else if (state is AllServicesErrorKomplat) {
                      body = Expanded(
                        child: PageError(
                          message: state.errorText ?? 'Неизвестная ошибка',
                          onRepeatTap: () => context.read<AllServicesBloc>().add(AllServicesInit(
                            name: _searchController.text,
                            filters: _filters
                          )),
                        ),
                      );
                    }
                    return body;
                  }
                );
              }

            return mainBody;
            }
          )
        ],
      )
    )
  );
}