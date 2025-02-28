import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomAppSelectionCard extends StatelessWidget {
  final String title;
  final String description;
  final Color color;
  final String imageUrl;
  final VoidCallback onTap;
  const CustomAppSelectionCard(
      {super.key,
      required this.title,
      required this.color,
      required this.description,
      required this.imageUrl,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          color: color,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(25)),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Lottie.asset(
                    imageUrl,
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                ),
                Text(title,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    description,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
