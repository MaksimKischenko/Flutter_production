import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isc_web_app/blocs/blocs.dart';
import 'package:isc_web_app/data/data.dart';
import 'package:isc_web_app/screens/payments/widgets/widgets.dart';
import 'package:isc_web_app/styles.dart';
import 'package:isc_web_app/widgets/widgets.dart';

class PaymentsTable extends StatefulWidget {
  final List<PaymentISC> payments;

  const PaymentsTable({
    Key? key,
    required this.payments,
  }) : super(key: key);

  @override
  State<PaymentsTable> createState() => PaymentsTableState();
}

class PaymentsTableState extends State<PaymentsTable> {
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
            dataListLength: widget.payments.length,
            columns: [
              DataColumn2(
                  size: ColumnSize.S,
                  label: Text(
                    '',
                    style: AppStyles.tableHeaderTextStyle,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
              )),
              ...state.paymnetItems.map((e) => DataColumn2(
                  onSort: (columnIndex, ascending) {
                    context.read<PaymentsBloc>().add(PaymentsSort(
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
              ))),
              DataColumn2(
                  size: ColumnSize.M,
                  label: Text(
                    '',
                    style: AppStyles.tableHeaderTextStyle,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
              )),
            ],
            source: PaymentTableData(
              context: context,
              payments: widget.payments,
              state: state
            ));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
}
