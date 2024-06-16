import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

class AccountItem extends StatelessWidget {
  final PropertyAccount account;
  final Function(PropertyAccount account) onTap;

  const AccountItem({
    required this.account,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () {
      if (account.account?.isConfirmed == 1) onTap.call(account);
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppStyles.mainColor.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 4)
          )
        ]
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  context.t.mobileScreens.mdomAccruals.accountItem.title,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppStyles.mainTextColor.withOpacity(.5),
                    fontWeight: FontWeight.w400
                  ),
                ),
                Text(
                  account.account?.evalue ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: AppStyles.mainColorDark
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (!(account.account?.isConfirmed == 1))
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffF4F4F4),
              borderRadius: BorderRadius.circular(16)
            ),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            child: Text(
            //  account.account?.isConfirmed == -1?  
            //  context.t.mobileScreens.mdomAccruals.accountItem.waitingRegistration.toUpperCase() : 
             context.t.mobileScreens.mdomAccruals.accountItem.underConsideration.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 10,
                color: AppStyles.mainTextColor.withOpacity(0.9)
              ),
            ),
          ),
          if (account.account?.isConfirmed == 1)
          const Icon(
            Icons.arrow_forward_ios,
            color: Color(0xffC7C7CC),
            size: 20,
          )
        ],
      ),
    ),
  );
}