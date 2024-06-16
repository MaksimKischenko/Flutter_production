import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_payform_app/blocs/popular_services/popular_services_bloc.dart';
import 'package:helppay_payform_app/screens/init_helppay_services/widgets/popular_services_list/widget.dart';
import 'package:helppay_payform_app/utils/request_util.dart';
import 'package:helppay_payform_app/widgets/widgets.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PopularServicesListWidget extends StatefulWidget {
  final SizingInformation sizingInformation;
  final double horizontalPaddingValue;

  const PopularServicesListWidget({
    Key? key,
    required this.sizingInformation,
    required this.horizontalPaddingValue,
  }) : super(key: key);

  @override
  State<PopularServicesListWidget> createState() =>
      _PopularServicesListWidgetState();
}

class _PopularServicesListWidgetState extends State<PopularServicesListWidget> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<PopularServicesBloc>().add(PopularServicesInit()),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularServicesBloc, PopularServicesState>(
      builder: (context, state) {
        Widget body = Container();

        if (state is PopularServicesLoading) {
          body = SizedBox.shrink();
          // Center(
          //   child: LoadingIndicator(),
          // );
        } else if (state is PopularServicesLoaded) {
          body = PopularServicesListBody(
            state: state,
            sizingInformation: widget.sizingInformation,
            horizontalPaddingValue: widget.horizontalPaddingValue,
          );
        } else if (state is PopularServicesError) {
          body = PageError(
            message: RequestUtil.kNetworkError,
            onRepeatTap: () =>
                context.read<PopularServicesBloc>().add(PopularServicesInit()),
          );
        } else if (state is PopularServicesErrorKomplat) {
          body = PageError(
            message: state.errorText ?? 'Неизвестная ошибка',
            onRepeatTap: () =>
                context.read<PopularServicesBloc>().add(PopularServicesInit()),
          );
        }
        return body;
      },
    );
  }
}
