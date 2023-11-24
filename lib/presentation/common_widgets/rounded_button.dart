import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final void Function()? onPress;
  final Color backgroundColor;
  final bool invert;
  final bool enabled;
  final bool isLoading;

  const RoundedButton({
    Key? key,
    this.text = 'LOGIN',
    required this.onPress,
    this.backgroundColor = Colors.blue,
    this.invert = false,
    this.enabled = true,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color disabledColor = Colors.grey.shade300;
    Color disabledFontColor = Colors.black54;
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          minimumSize: const Size.fromHeight(0),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          backgroundColor: !enabled
              ? disabledColor
              : invert
                  ? Colors.white
                  : backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: !enabled ? disabledColor : backgroundColor),
          ),
        ),
        onPressed: enabled ? onPress : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: isLoading,
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  color: !enabled
                      ? disabledFontColor
                      : invert
                          ? backgroundColor
                          : Colors.white,
                  //color: !enabled ? disabledFontColor : Colors.white,
                  strokeWidth: 2,
                ),
              ),
            ),
            Visibility(
              visible: isLoading,
              child: const SizedBox(
                width: 10,
              ),
            ),
            Text(
              text,
              style: TextStyle(
                color: !enabled
                    ? disabledFontColor
                    : invert
                        ? backgroundColor
                        : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
