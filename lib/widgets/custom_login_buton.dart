import 'package:firebasesample/utils/utilities.dart';
import 'package:flutter/material.dart';

class CustomLoginButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool isLoading;
  final VoidCallback onPressed;
  const CustomLoginButton(
      {Key? key,
      required this.child,
      required this.color,
      required this.isLoading,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = Utilities().screenSize();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        fixedSize: Size(
          screen.width * .5,
          40,
        ),
      ),
      onPressed: onPressed,
      child: !isLoading
          ? child
          : const Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: CircularProgressIndicator(
                  color: Colors.green,
                ),
            ),
          ),
    );
  }
}
