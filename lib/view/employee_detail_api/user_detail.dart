import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api_project/model/user_model.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User user = Get.arguments as User;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Employee Details"),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.image),
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(height: 10),

            // Employee Role & Company
            SectionTitle(title: 'Employee Role & Company'),
            UserDetailsTile(label: "Company", value: user.company.name),
            UserDetailsTile(
                label: "Department", value: user.company.department),
            UserDetailsTile(label: "Job Title", value: user.company.title),

            // Personal Details
            SectionTitle(title: 'Personal Details'),
            UserDetailsTile(
                label: "Name", value: "${user.firstName} ${user.lastName}"),
            UserDetailsTile(label: "Email", value: user.email),
            UserDetailsTile(label: "Phone", value: user.phone),
            UserDetailsTile(
                label: "Gender", value: user.gender.name.toString()),
            UserDetailsTile(label: "Age", value: "${user.age}"),
            UserDetailsTile(label: "Blood Group", value: user.bloodGroup),
            UserDetailsTile(label: "Height", value: "${user.height} cm"),
            UserDetailsTile(label: "Weight", value: "${user.weight} kg"),

            // Address Details
            SectionTitle(title: 'Address'),
            UserDetailsTile(label: "Street", value: user.address.address),
            UserDetailsTile(label: "City", value: user.address.city),
            UserDetailsTile(label: "State", value: user.address.state),
            UserDetailsTile(label: "Country", value: user.address.country.name),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class UserDetailsTile extends StatelessWidget {
  final String label;
  final String value;

  const UserDetailsTile({required this.label, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
              width: 150,
              child: Text(label,
                  style: const TextStyle(fontWeight: FontWeight.bold))),
          Expanded(
              child: Text(value, style: const TextStyle(color: Colors.grey))),
        ],
      ),
    );
  }
}
