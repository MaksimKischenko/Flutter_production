import 'package:bpc/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PollsScreenFiltersAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final bool isResetAvailable;
  final bool showTitle;
  final VoidCallback onResetTap;

  const PollsScreenFiltersAppBar({
    super.key,
    required this.isResetAvailable,
    required this.showTitle,
    required this.onResetTap,
  });

  @override
  Widget build(BuildContext context) => AppBar(
        leadingWidth: 81,
        leading: TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Отмена',
            // TODO
            // context.t.screens.mdomPollsListFilters.cancelButton,
          ),
        ),
        title: showTitle
            ? const Text(
                'Голосования',
                // TODO
                // context.t.screens.mdomPollsListFilters.title,
              )
            : null,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        actions: [
          TextButton(
            onPressed: isResetAvailable ? onResetTap : null,
            child: Text(
              'Сбросить',
              // TODO
              // context.t.screens.mdomPollsListFilters.resetButton,
              style: TextStyle(
                  color: isResetAvailable
                      ? null
                      : AppStyles.mainTextColor.withOpacity(.5)),
            ),
          ),
        ],
      );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
