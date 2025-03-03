import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api_project/data/response/status.dart';
import 'package:rest_api_project/res/route/route_names.dart';
import 'package:rest_api_project/view_model/controller/employee_controller.dart';

class HomeEmployeePage extends StatefulWidget {
  const HomeEmployeePage({super.key});

  @override
  State<HomeEmployeePage> createState() => _HomeEmployeePageState();
}

class _HomeEmployeePageState extends State<HomeEmployeePage> {
  EmployeeController ec = Get.put(EmployeeController());

  @override
  void initState() {
    super.initState();
    ec.getEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Home Screen',
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orangeAccent,
        scrolledUnderElevation: 0.0,
      ),
      body: Obx(
        () {
          switch (ec.rxResponseStatus.value) {
            case Status.LOADING:
              return Center(child: CircularProgressIndicator());
            case Status.COMPLETED:
              final userList = ec.userResponse.value!.users;
              return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  final user = userList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(RoutesName.employeeDetail, arguments: user);
                      },
                      child: Material(
                        color: Colors.grey[200],
                        elevation: 1,
                        borderRadius: BorderRadius.circular(20),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.blue[100],
                                backgroundImage: NetworkImage(user.image),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(text: '${user.firstName} '),
                                        TextSpan(text: user.lastName),
                                      ],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                  Text(user.company.department)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );

            case Status.ERROR:
              return Text('ec.rxResponseError.value');
          }
        },
      ),
    );
  }
}
