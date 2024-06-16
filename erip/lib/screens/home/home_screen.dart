import 'package:bpc_nkfo/blocs/blocs.dart';
import 'package:bpc_nkfo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/widgets.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) => BlocBuilder<InfoBloc, InfoState>(
    builder: (context, state) {
      Widget body = Container();
      if (state is InfoLoading) {
        body = Scaffold(
          drawer: const BpcDrawer(isInfoSelected: true),
          appBar: AppBar(
            title: const Text('Информация'),
          ),
          body: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.maxFinite,
              ),
              LoadingIndicator()
            ],
          ),
        );
      }
      if (state is InfoLoaded) {
        body = InfoBlock(
          main: state.main,
          contacts: state.contacts,
          services: state.services,
        );
      }
      return body;
    },
  );
}