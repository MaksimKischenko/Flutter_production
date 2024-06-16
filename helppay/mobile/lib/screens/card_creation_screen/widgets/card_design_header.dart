// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';
class CardDesignHeader extends StatelessWidget {
  final DataManager? dataManager;
  final String headerText;
  final bool finalPage;

  const CardDesignHeader({
    Key? key,
    required this.headerText,
    this.dataManager,
    this.finalPage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => finalPage? 
    Text(
      headerText,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppStyles.cardDesignTextColor
      ),
    )
  : Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '########',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: Colors.transparent
          ),
        ),
        Text(
          headerText,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppStyles.cardDesignTextColor),
        ),
        BlocBuilder<CardsIssueBloc, CardsIssueState>(
          builder: (context, state) {
            Widget body = Container();
            if(state is CardsIssueLoading) {
              body = const Text(
                '########',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Colors.transparent),
              );
            } else {
                body = GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  context.t.mobileScreens.cardRegistration.cancelButton,
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: AppStyles.mainColor),
                ),
              );
            }
            return body;
          },
        )
      ],
    );
}
