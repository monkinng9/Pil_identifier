import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({required this.child});
  final Widget child;
  // final void Function() onPressed;

  @override
  Widget build(BuildContext context) => OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.deepPurpleAccent),
        ),
        // onPressed: onPressed,
        onPressed: () {},
        child: child,
      );
}
