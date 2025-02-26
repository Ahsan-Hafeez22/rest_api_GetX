//------------------using http------------------
// Future<List<PostModel>> getApiData() async {
//   final response =
//       await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

//   if (response.statusCode == 200) {
//     List<dynamic> data = jsonDecode(response.body);
//     return data.map((item) => PostModel.fromJson(item as Map<String, dynamic>))
//         .toList();
//   } else {
//     throw Exception("Failed to load data");
//   }
//
//------------------using Dio------------------
// Future<List<PostModel>> getApiData() async {
//   Dio dio = Dio();
//   try {
//     Response response =
//         await dio.get('https://jsonplaceholder.typicode.com/posts');
//     if (response.statusCode == 200) {
//       List<dynamic> data = response.data;
//       return data
//           .map((item) => PostModel.fromJson(item as Map<String, dynamic>))
//           .toList();
//     } else {
//       throw Exception("Failed to load data");
//     }
//   } catch (e) {
//     throw Exception('Error fetching data: $e');
//   }
// }

// Future<List<UserModel>> getUsersApi() async {
//   Dio dio = Dio();
//   try {
//     Response response =
//         await dio.get('https://jsonplaceholder.typicode.com/users');
//     if (response.statusCode == 200) {
//       List<dynamic> data = response.data;
//       // log(response.data.toString());
//       // Convert and log mapped objects
//       List<UserModel> users = data.map((e) {
//         UserModel user = UserModel.fromJson(e as Map<String, dynamic>);
//         log("Mapped User: ${user.toJson()}"); // Log each mapped user
//         return user;
//       }).toList();
//       return users;
//     } else {
//       throw Exception("Failed to load data");
//     }
//   } catch (e) {
//     throw Exception('Error fetching data: $e');
//   }
// }

// Future<List<PhotosModel>> getPhotosApi() async {
//   Dio dio = Dio();
//   try {
//     Response response =
//         await dio.get('https://jsonplaceholder.typicode.com/photos');
//     if (response.statusCode == 200) {
//       List<dynamic> data = response.data;
//       // log(response.data.toString());
//       return data
//           .map(
//             (item) => PhotosModel.fromJson(item as Map<String, dynamic>),
//           )
//           .toList();
//     } else {
//       throw Exception("Failed to load data");
//     }
//   } catch (e) {
//     throw Exception('Error fetching data: $e');
//   }
// }


//ui

 // FutureBuilder(
        //   future: getUsersApi(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     } else if (snapshot.hasError) {
        //       return Center(child: Text("Error: ${snapshot.error}"));
        //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        //       return Center(
        //         child: Text('No data found.'),
        //       );
        //     } else {
        //       return ListView.builder(
        //         itemCount: snapshot.data!.length,
        //         itemBuilder: (context, index) {
        //           var users = snapshot.data![index];
        //           return Card(
        //               elevation: 5,
        //               child: Column(
        //                 children: [
        //                   Padding(
        //                     padding: const EdgeInsets.all(8.0),
        //                     child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                         children: [
        //                           Text('Id'),
        //                           Spacer(),
        //                           Text(users.id.toString())
        //                         ]),
        //                   ),
        //                   Padding(
        //                     padding: const EdgeInsets.all(8.0),
        //                     child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                         children: [
        //                           Text('Name'),
        //                           Spacer(),
        //                           Text(users.name.toString())
        //                         ]),
        //                   ),
        //                   Padding(
        //                     padding: const EdgeInsets.all(8.0),
        //                     child: Row(children: [
        //                       Text('Email'),
        //                       Spacer(),
        //                       Text(users.email.toString())
        //                     ]),
        //                   ),
        //                   Padding(
        //                     padding: const EdgeInsets.all(8.0),
        //                     child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                         children: [
        //                           Text('City'),
        //                           Spacer(),
        //                           Text(users.address!.city ?? "")
        //                         ]),
        //                   ),
        //                   Padding(
        //                     padding: const EdgeInsets.all(8.0),
        //                     child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                         children: [
        //                           Text('Zip Code'),
        //                           Spacer(),
        //                           Text(users.address!.zipcode ?? "")
        //                         ]),
        //                   ),
        //                   Padding(
        //                     padding: const EdgeInsets.all(8.0),
        //                     child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                         children: [
        //                           Text('Phone'),
        //                           Spacer(),
        //                           Text(users.phone ?? "")
        //                         ]),
        //                   ),
        //                   Padding(
        //                     padding: const EdgeInsets.all(8.0),
        //                     child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                         children: [
        //                           Text('Latitude'),
        //                           Spacer(),
        //                           Text(users.address!.geo!.lat ?? "")
        //                         ]),
        //                   ),
        //                 ],
        //               )
        //               //  ListTile(
        //               //   title: Text(users.name.toString()),
        //               //   subtitle: Text(users.email.toString()),
        //               // ),
        //               );
        //         },
        //       );
        //     }
        //   },
        // ),
        // body: FutureBuilder(
        //   future: getPhotosApi(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Center(child: CircularProgressIndicator());
        //     } else if (snapshot.hasError) {
        //       return Center(child: Text("Error: ${snapshot.error}"));
        //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        //       return Center(child: Text('No Data Found!'));
        //     } else {
        //       return ListView.builder(
        //         itemCount: snapshot.data!.length,
        //         itemBuilder: (context, index) {
        //           var photo = snapshot.data![index];
        //           return Card(
        //             child: ListTile(
        //               leading: CircleAvatar(
        //                 backgroundColor: Colors.white,
        //                 child: Icon(Icons.person),
        //               ),
        //               title: Text(photo.title.toString()),
        //             ),
        //           );
        //         },
        //       );
        //     }
        //   },
        // ),
        // FutureBuilder<List<PostModel>>(
        //   future:
        //       getApiData(), // Make sure the function is returning a Future<List<PostModel>>
        //   builder: (context, snapshot) {
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return Center(child: CircularProgressIndicator());
        // } else if (snapshot.hasError) {
        //   return Center(child: Text("Error: ${snapshot.error}"));
        // } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        //   return Center(child: Text('No Data Found!'));
        // } else {
        //       return ListView.builder(
        //         itemCount: snapshot.data!.length,
        //         itemBuilder: (context, index) {
        //           var post = snapshot.data![index];
        //           return Card(
        //             child: ListTile(
        //               title: Text(post.id.toString()),
        //               subtitle: Text(post.title ?? "No Title"),
        //             ),
        //           );
        //         },
        //       );
        //     }
        //   },
        // ),