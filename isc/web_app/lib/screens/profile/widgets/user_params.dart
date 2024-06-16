import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isc_web_app/blocs/blocs.dart';
import 'package:isc_web_app/data/data.dart';
import 'package:isc_web_app/styles.dart';

class UserParams extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (prev, next) => next is ProfileInitial,
        builder: (context, state) {
          if (state is ProfileInitial) {
            final filteredUserParams = state.userParams.where(_filter).toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child:  Text(
                    'Об организации',
                    style: AppStyles.aboutOrganizationTextStyle,
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: filteredUserParams.length,
                    itemBuilder: (context, index) =>
                        _buildItem(filteredUserParams[index]),
                    separatorBuilder: (context, _) => const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox.shrink(),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      );


  bool _filter(MdomResponseParam param) {
    if (param.evalue == null || param.evalue!.isEmpty) return false;
    if (param.id == 12 || param.id == 13) return false;
    if (param.id == 14) return false;
    return true;
  }

  Widget _buildItem(MdomResponseParam param) => Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            param.name ?? '',
            style: TextStyle(
                fontSize: 16, color: AppStyles.mainColorDark.withOpacity(0.6)),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            param.evalue ?? '',
            style: const TextStyle(fontSize: 16, color: AppStyles.mainColorDark),
          )
        ],
      ));
}
