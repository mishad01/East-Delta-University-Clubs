/*
import 'package:edu_clubs_app/view_model/admin/home/banner_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerTestView extends StatelessWidget {
  final BannerController _bannerController = Get.put(BannerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Banner Management"),
      ),
      body: SingleChildScrollView(
        // Wrap the entire body with a SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Banner image display
              Obx(
                () => _bannerController.bannerImage != null
                    ? Image.file(
                        _bannerController.bannerImage!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: Center(child: Text("No banner image selected")),
                      ),
              ),
              SizedBox(height: 20),
              // Pick image button
              ElevatedButton(
                onPressed: () {
                  _bannerController.pickBannerImage();
                },
                child: Text("Pick Banner Image"),
              ),
              SizedBox(height: 20),
              // Banner link input
              TextField(
                decoration: InputDecoration(
                  labelText: "Banner Link",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _bannerController.clearFields();
                },
              ),
              SizedBox(height: 20),
              // Add banner button
              Obx(
                () => _bannerController.inProgress
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          String bannerLink =
                              "https://yourlink.com"; // Replace with the actual input value
                          bool success =
                              await _bannerController.addBanner(bannerLink);
                          if (success) {
                            Get.snackbar(
                                "Success", "Banner added successfully!");
                          }
                        },
                        child: Text("Add Banner"),
                      ),
              ),
              SizedBox(height: 20),
              // Fetch banners button
              ElevatedButton(
                onPressed: () async {
                  await _bannerController.fetchBanners();
                },
                child: Text("Fetch Banners"),
              ),
              SizedBox(height: 20),
              // Display list of banners
              Obx(
                () => _bannerController.banners.isEmpty
                    ? Text("No banners available.")
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: _bannerController.banners.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text("Banner ${index + 1}"),
                            subtitle: Text(
                                _bannerController.banners[index]["bannerLink"]),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
