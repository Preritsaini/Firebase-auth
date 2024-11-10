
import 'package:authenticate/controllers/incrementController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncrementPage extends StatelessWidget {
  IncrementPage({super.key});

  final IncrementController incrementController =
      Get.put(IncrementController());
  void increment() {
    incrementController.counter++;
  }
  void reset(){
    incrementController.counter.value = 0;
  }

  void decrement() {
    if (incrementController.counter > 0) {
      incrementController.counter--;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() => Text(incrementController.counter.toString())),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    increment();
                  },
                  child: Icon(Icons.add)),
              SizedBox(width: 30),
              ElevatedButton(
                  onPressed: () {
                    decrement();
                  },
                  child: Icon(Icons.minimize)),
              SizedBox(width: 20),
              ElevatedButton(
                  onPressed: () {
                    reset();
                  },
                  child: Icon(Icons.restart_alt)),
            ],
          )
        ],
      ),
    );
  }
}
