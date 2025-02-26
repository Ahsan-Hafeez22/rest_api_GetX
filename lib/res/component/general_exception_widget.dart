import 'package:flutter/material.dart';
import 'package:rest_api_project/res/component/round_button.dart';

class GeneralException extends StatelessWidget {
  final VoidCallback onpress;

  const GeneralException({super.key, required this.onpress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_off,
              color: Colors.red,
              size: 50,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
            Center(
              child: Text(
                'Something went wrong, please try again later.',
                style: TextStyle(
                  color: Colors.grey[800],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .07,
            ),
            RoundButton(title: 'Retry', onPress: onpress)
          ],
        ),
      ),
    );
  }
}
