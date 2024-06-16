import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/screens/manage_archives/archive_dir/widgets/widgets.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';
import 'package:payment_tracking_module/utils/utils.dart';

class ArchivesDirectoryScreenBody extends StatefulWidget {
  const ArchivesDirectoryScreenBody({super.key});

  @override
  State<ArchivesDirectoryScreenBody> createState() => _ArchivesDirectoryScreenBodyState();
}

class _ArchivesDirectoryScreenBodyState extends State<ArchivesDirectoryScreenBody> {
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
    ArchiveDB? _archiveDB;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text('Справочник архивов', style: AppStyles.headerStyle)
          ),
          const SizedBox(height: 24),          
          BlocConsumer<RowSelectedBloc<ArchiveDB>, RowSelectedState<ArchiveDB>>(
            listener: (context, state) {
              _isSelected = state.selectedData.isSelected;
              _archiveDB = state.selectedData.selectedObject;
            },
            builder: (context, state) => ArchivesDBMenu(
              isSelected: _isSelected ?? false,
              archiveDB: _archiveDB,
            ),
          ),
          BlocConsumer<ArchiveDbBloc, ArchiveDbState>(
            listener: (context, state) {
              _resetSelection();
              if (state is ArchiveDbError) {
                RequestUtil.catchNetworkError(
                  context: context, obj: state.error
                );
              } 
            },
            builder: (context, state) {
              Widget body = const SizedBox();
              if (state is ArchiveDbLoading) {
                body = const Expanded(
                  child: Center(child: LoadingIndicator(indicatorsSize: 72)),
                );
              } else if (state is ArchiveDbLoaded) {
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
                              child: ArchiveDBTable(
                                archives: state.archives,
                              ),
                            ),
                          ),
                        )
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
    );
  }
  void _resetSelection() {
    context.read<RowSelectedBloc<ArchiveDB>>().
      add(RowSelectedRun(selectedData: SelectedData.empty())
    );   
  }      
}
