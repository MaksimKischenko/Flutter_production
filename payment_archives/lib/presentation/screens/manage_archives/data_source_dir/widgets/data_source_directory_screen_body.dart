import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/screens/manage_archives/data_source_dir/listeners/listeners.dart';
import 'package:payment_tracking_module/presentation/screens/manage_archives/data_source_dir/widgets/widgets.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';


class DataSourceDirectoryScreenBody extends StatefulWidget {
  const DataSourceDirectoryScreenBody({super.key});

  @override
  State<DataSourceDirectoryScreenBody> createState() =>
      _DataSourceDirectoryScreenBodyState();
}

class _DataSourceDirectoryScreenBodyState extends State<DataSourceDirectoryScreenBody> {

  late ScrollController _controller;  

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
    void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    bool? _isSelected;
    DataSource? _dataSource;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text('Справочник источников данных', style: AppStyles.headerStyle)
            ),
            const SizedBox(height: 24),
            BlocConsumer<RowSelectedBloc<DataSource>, RowSelectedState<DataSource>>(
              listener: (context, state) {
                _isSelected = state.selectedData.isSelected;
                _dataSource = state.selectedData.selectedObject;
              },
              builder: (context, state) => DataSourceDirMenu(
                isSelected: _isSelected ?? false,
                dataSource: _dataSource,
              ),
            ),
            BlocConsumer<DataSourceBloc, DataSourceState>(
              listener: (context, state) => DataSourceDirListener.
              fromActions(
                context, 
                state, 
                () => null
              ),
              builder: (context, state) {
                Widget body = const SizedBox();
                if (state is DataSourceLoading) {
                  body = const Expanded(
                    child: Center(child: LoadingIndicator(indicatorsSize: 72)),
                  );
                } else if (state is DataSourceLoaded) {
                    body = Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: RawScrollbar(
                              thumbColor: AppStyles.colorGrey2,
                              thumbVisibility: true,
                              interactive: true,
                              controller: _controller,                                       
                              child: SingleChildScrollView(
                                controller: _controller,                            
                                scrollDirection: Axis.horizontal,                                          
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 1.2,                                             
                                  child: DataSourceDirTable(
                                    dataSources: state.dataSources,
                                  ),
                                ),
                              ),
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
