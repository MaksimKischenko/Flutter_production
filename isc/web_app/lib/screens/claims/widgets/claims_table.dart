import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isc_web_app/blocs/blocs.dart';
import 'package:isc_web_app/data/data.dart';
import 'package:isc_web_app/screens/claims/widgets/widgets.dart';
import 'package:isc_web_app/styles.dart';
import 'package:isc_web_app/widgets/widgets.dart';

class ClaimsTable extends StatefulWidget {
  final List<Claim> claims;

  const ClaimsTable({
    Key? key,
    required this.claims,
  }) : super(key: key);

  @override
  State<ClaimsTable> createState() => ClaimsTableState();
}

class ClaimsTableState extends State<ClaimsTable> {
  bool sortAscending = false;
  int sortColumnIndex = 1;

  @override
  Widget build(BuildContext context) => BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if(state is SettingsInitial) {
            return TableWrapper(
              headingRowHeight: 60,
              sortAscending: sortAscending,
              dataRowHeight: 40,
              sortColumnIndex: sortColumnIndex,
              dataListLength: widget.claims.length,
              columns: [
                DataColumn2(
                  size: ColumnSize.S,
                  label: Text(
                    '',
                    style: AppStyles.tableHeaderTextStyle,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  )
                ),
                ...state.claimItems.map(
                  (e) => DataColumn2(
                    onSort: (columnIndex, ascending) {
                      context.read<ClaimsBloc>().add(ClaimsSort(
                          ascending: sortAscending,
                          sortIndex: sortColumnIndex));
                      setState(() {
                        sortAscending = !sortAscending;
                        sortColumnIndex = columnIndex;
                      });
                    },
                    size: ColumnSize.L,
                    label: Text(
                      e,
                      style: AppStyles.tableHeaderTextStyle,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                    )),
                ),
                DataColumn2(
                  size: ColumnSize.M,
                  label: Text(
                    '',
                    style: AppStyles.tableHeaderTextStyle,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  )
                ),
              ],
              source: ClaimTableData(
                context: context,
                claims: widget.claims,
                state: state
              ));
          } else {
            return const SizedBox.shrink();
          }
        },
      );
}
