import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final double height, width;
  final Color buttonColor, textColor;
  final bool loading;
  const RoundButton(
      {super.key,
      required this.title,
      required this.onPress,
      this.buttonColor = Colors.black,
      this.textColor = Colors.white,
      this.loading = false,
      this.height = 50,
      this.width = 100});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(20.0)),
        child: loading
            ? Center(
                child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.white,
              ))
            : Center(
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: textColor),
                ),
              ),
      ),
    );
  }
}
