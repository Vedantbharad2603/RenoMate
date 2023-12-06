import 'package:flutter/material.dart';
import 'package:renomateworker/theme.dart';

class EventCard extends StatelessWidget {
  final bool isPast;
  final child;
  const EventCard({super.key, required this.isPast, required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
          color: isPast ? MyTheme.button1 : MyTheme.accent,
          borderRadius: BorderRadius.circular(20)),
      child: child,
    );
  }
}
