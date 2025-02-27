import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';

class NewsDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String publishAt;
  final String source;
  final String content;
  const NewsDetailPage(
      {super.key,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.publishAt,
      required this.source,
      required this.content});

  @override
  Widget build(BuildContext context) {
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
            // Image.network('image_url'),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 5),

            Text(
              description,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(height: 10),

            SizedBox(height: 10),
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(10),
            //   child:
            //       // CachedNetworkImage(
            //       //   imageUrl: imageUrl,
            //       //   imageBuilder: (context, imageProvider) => Container(
            //       //     decoration: BoxDecoration(
            //       //       image: DecorationImage(
            //       //           image: imageProvider,
            //       //           fit: BoxFit.cover,
            //       //           colorFilter:
            //       //               ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
            //       //     ),
            //       //   ),
            //       //   placeholder: (context, url) => CircularProgressIndicator(),
            //       //   errorWidget: (context, url, error) => Icon(Icons.error),
            //       // ),

            //       Image.network(
            //     imageUrl,
            //     height: 200,
            //     width: double.infinity,
            //     fit: BoxFit.fill,
            //   ),
            // ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage, // Add a local placeholder image
                image: imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error,
                      size: 50, color: Colors.red); // Show an error icon
                },
              ),
            ),
            SizedBox(height: 10),

            Row(
              children: [
                Text('Publish at: ',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700])),
                Spacer(),
                Text(publishAt,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700])),
              ],
            ),
            SizedBox(height: 10),

            Text(
              "Description: ",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),

            Text(
              content,
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
