import 'package:flutter/material.dart';

class ButtonCommon extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Color color;

  ButtonCommon({
    required this.onPressed,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: color,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.00))
                )
            ),
            onPressed: onPressed,
            child: Text(label,
              style: TextStyle(
                  fontSize: 18.0
              ),)),
      ),
    );
  }
}
