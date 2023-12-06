import 'package:flutter/material.dart';
import 'package:renomateworker/theme.dart';
import 'package:renomateworker/utils/event_card.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyTimeLineTile extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final eventCard;
  const MyTimeLineTile(
      {super.key,
      required this.isFirst,
      required this.isLast,
      required this.isPast,
      required this.eventCard});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 200,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle:
            LineStyle(color: isPast ? MyTheme.button1 : MyTheme.accent),
        indicatorStyle: IndicatorStyle(
            color: isPast ? MyTheme.button1 : MyTheme.accent,
            width: 28,
            iconStyle: IconStyle(
                iconData: Icons.done,
                color: isPast ? MyTheme.background : Colors.transparent)),
        endChild: EventCard(isPast: isPast, child: eventCard),
      ),
    );
  }
}
