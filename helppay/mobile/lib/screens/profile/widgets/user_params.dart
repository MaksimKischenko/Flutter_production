import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/blocs/blocs.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

class UserParams extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (prev, next) => next is ProfileInitial,
        builder: (context, state) {
          if (state is ProfileInitial) {
            final filteredUserParams = state.userParams.where(_filter).toList();
            return ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredUserParams.length,
              itemBuilder: (context, index) =>
                  _buildItem(filteredUserParams[index]),
              separatorBuilder: (context, _) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(
                    color: AppStyles.mainColorDark.withOpacity(0.1), height: 1),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      );

  /// filter visible elements
  bool _filter(MdomResponseParam param) {
    if (param.evalue == null || param.evalue!.isEmpty) return false;
    if (param.id == 12 || param.id == 13) return false;
    if (param.id == 14) return false;
    return true;
  }

  Widget _buildItem(MdomResponseParam param) => Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            param.name,
            style: TextStyle(
                fontSize: 16, color: AppStyles.mainColorDark.withOpacity(0.6)),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            param.alias == 'SOURCECOMMUNICATION'
                ? param.evalue! == 'PHONE'
                    ? 'СМС'
                    : 'Электронная почта'
                : param.evalue!,
            style:
                const TextStyle(fontSize: 18, color: AppStyles.mainColorDark),
          )
        ],
      ));
}
