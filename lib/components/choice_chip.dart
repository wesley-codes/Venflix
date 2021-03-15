import 'package:flutter/material.dart';

import 'constants.dart';





class ChoiceChips extends StatelessWidget {
  final String title;

  const ChoiceChips({this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: ChoiceChip(
        label: Padding(
          padding:
              const EdgeInsets.only(bottom: 5, top: 5, left: 10, right: 10),
          child: Text(
            title,
            style: kChoiceChipsText,
          ),
        ),
        selected: false,
      ),
    );
  }
}