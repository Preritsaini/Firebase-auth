import 'package:authenticate/Screens/pages/increment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/controller.dart';

class NewPage extends StatefulWidget {
  const NewPage({super.key});

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.to(IncrementPage());
                  },
                  child: Text('Next')),
              Obx(
                () => Container(
                  height: 300,
                  width: 200,
                  color:
                      Colors.blue.withOpacity(favoriteController.opacity.value),
                ),
              ),

              Obx(
                () => Slider(
                    value: favoriteController.opacity.value,
                    onChanged: (value) {
                      favoriteController.setOpacity(value);
                    }),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.defaultDialog(
                    title: 'Dialog Box',
                    middleText: 'This dialog box is shown by GetX',
                  );
                },
                child: Text('Open Dialog'),
              ),
              const SizedBox(height: 20), // Spacing between buttons

              // Theme Change Buttons
              ElevatedButton(
                onPressed: () {
                  Get.changeTheme(ThemeData.dark());
                },
                child: Text('Dark Theme'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Get.isDarkMode ? Colors.grey : Colors.blue,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Get.changeTheme(ThemeData.light());
                },
                child: Text('Light Theme'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: !Get.isDarkMode ? Colors.grey : Colors.blue,
                ),
              ),
              const SizedBox(height: 20),

              // Localization / Language Switch
              ListTile(
                title: Text('message'.tr), // Localized message
                subtitle: Text('name'.tr), // Localized name
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Language buttons
                  OutlinedButton(
                    onPressed: () {
                      Get.updateLocale(
                          Locale('en', 'US')); // Changes locale to English
                    },
                    child: Text('English'),
                  ),
                  const SizedBox(
                      width: 10), // Add spacing between language buttons
                  OutlinedButton(
                    onPressed: () {
                      Get.updateLocale(
                          Locale('hi', 'IN')); // Changes locale to Hindi
                    },
                    child: Text('Hindi'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
