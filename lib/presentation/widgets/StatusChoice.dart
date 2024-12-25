import 'package:flutter/material.dart';

class StatusChoice extends StatelessWidget {
  StatusChoice({
    super.key,
    required this.isActive,
    required this.name,
  });

  bool isActive;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color:
            isActive ? Theme.of(context).primaryColor : const Color(0xffF0ECFF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        name.toUpperCase(),
        style: TextStyle(
          color: isActive ? Colors.white : const Color(0xff7C7C80),
          fontSize: 15,
        ),
      ),
    );
  }
}
