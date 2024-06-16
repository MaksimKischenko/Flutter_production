// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';

class UsersTable extends StatefulWidget {
  final List<User> users;

  const UsersTable({
    Key? key,
    required this.users,
  }) : super(key: key);

  @override
  State<UsersTable> createState() => _UsersTableState();
}

class _UsersTableState extends State<UsersTable> {
  bool sortAscending = true;
  int sortColumnIndex = 1;

  @override
  Widget build(BuildContext context) => TableWrapper(
    sortAscending: sortAscending,
    sortColumnIndex: sortColumnIndex,       
    columnWidthRatio: 0.2,
    headingRowHeight: 35,
    dataListLength: widget.users.length,
    columns: [
      ...UserTableColumns.values.map((e) => DataColumn2(
          onSort: (columnIndex, ascending) {
            context.read<UsersBloc>().add(UsersSort(ascending: sortAscending, sortIndex: sortColumnIndex));
            setState(() {
              sortAscending = !sortAscending;
              sortColumnIndex = columnIndex;
            });                  
          },
          size: e.columnSize,
          label: Text(
            e.name,
            style: AppStyles.tableHeaderTextStyle,
            overflow: TextOverflow.ellipsis,
          ))
      ),      
    ],
    source: UserTableData(
      context: context,
      users: widget.users
    ),
  );
}
