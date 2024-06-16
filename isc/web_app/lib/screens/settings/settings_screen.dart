import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isc_web_app/blocs/blocs.dart';
import 'package:isc_web_app/models/models.dart';
import 'package:isc_web_app/styles.dart';
import 'package:isc_web_app/widgets/widgets.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_ui/responsive_ui.dart';



@RoutePage()
class SettingsScreen extends StatefulWidget {
  static const pageRoute = '/settings';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppStyles.backgroundColor,
    appBar: AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: const CabinetMenu(selectedIndex: 6),
    ),        
    body: Padding(
      padding: const EdgeInsets.all(40),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Настройка полей',
              style: TextStyle(
                color: AppStyles.mainTextColor,
                fontSize: 24,
                fontWeight: FontWeight.w400,
                letterSpacing: -1.4,
              ),
            ),
            const SizedBox(height: 24),                  
            Expanded(
              child: BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, state) {
                  if (state is SettingsInitial) {
                    return SingleChildScrollView(
                      child: ResponsiveBuilder(
                        builder: (context, sizingInformation) {
                          var width = 800.0;
                          if (sizingInformation.isMobile || sizingInformation.isTablet) {
                            width = sizingInformation.screenSize.width;
                          }
                          return SizedBox(
                            width: width,
                            child: Responsive(
                              runSpacing: 16,
                              children: [
                                _fieldsGroup<String>(
                                  name: 'Требования',
                                  selectedList: state.claimItems,
                                  fullList: ClaimsTableColumns.values.map((e) => e.columnName).toList(),
                                  onChanged: (item, value) => context.read<SettingsBloc>().add(SettingsChanged(
                                    claimItem: item,
                                    value: value
                                  )),
                                  itemNameBuilder: (item) => item
                                ),
                                _fieldsGroup<String>(
                                  name: 'Платежи',
                                  selectedList: state.paymnetItems,
                                  fullList: PaymentsTableColumns.values.map((e) => e.columnName).toList(),
                                  onChanged: (item, value) => context.read<SettingsBloc>().add(SettingsChanged(
                                    paymentItem: item,
                                    value: value
                                  )),
                                  itemNameBuilder: (item) => item
                                ),
                              ],
                            )
                          );
                        }
                      ),
                    );
                  } else {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 32,
                          height: 32,
                          child: LoadingIndicator()
                        ),
                      ],
                    ); 
                  }
                }
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _fieldsGroup<T>({
    required String name,
    required List<String> selectedList,
    required List<String> fullList,
    required Function(String item, bool value) onChanged,
    required String Function(String item) itemNameBuilder
  }) => Div(
    divison: const Division(
      colL: 6,
      colM: 12,      
    ),
    child: Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Text(
          name, 
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          )
        ),
        children: fullList.map((e) {
          final value = selectedList.contains(e);
          return CheckboxListTile(
            activeColor: AppStyles.mainColor,
            value: value,
            onChanged: selectedList.length > 1 || (selectedList.length == 1 && !value) ? (newValue) => onChanged(e, newValue ?? false) : null,
            title: Text(itemNameBuilder(e)),
          );
        }).toList(),
      ),
    ),
  );
}