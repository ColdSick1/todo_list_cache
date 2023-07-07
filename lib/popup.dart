import 'package:flutter/material.dart';
import 'package:riverpod_test_project/custom_text_field.dart';

class PopupWidget extends StatelessWidget {
  const PopupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => showDialog(
        context: context,
        builder: (context) {
          return const Dialog(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Введите название дела'),
                    CustomTextField(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      child: const Text('tap'),
    );
  }
}
