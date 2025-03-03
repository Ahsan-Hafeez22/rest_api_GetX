import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rest_api_project/res/asset/image.dart';

class NewsDetailPage extends StatelessWidget {
  const NewsDetailPage({
    super.key,
  });

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat(' MMMM dd, yyyy').format(dateTime);
    String formattedTime = DateFormat('hh:mm a').format(dateTime);
    return "$formattedDate, $formattedTime";
  }

  @override
  Widget build(BuildContext context) {
    final data = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            CupertinoIcons.back,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              data["title"],
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 5),
            Text(
              data["description"],
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                placeholder: AssetImage(ImageAssets.placeholderNewsImage),
                image: NetworkImage(data["imageUrl"]),
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.image_not_supported,
                        size: 50, color: Colors.grey),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Publish at: ',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700])),
                Spacer(),
                Text(formatDate(data['publishAt']),
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey[700])),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "Description: ",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            Text(
              data["content"],
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[900],
                  fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}
