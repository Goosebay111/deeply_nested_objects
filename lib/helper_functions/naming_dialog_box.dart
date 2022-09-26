import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

Future namingDialogBox({
  required BuildContext context,
  required String newRequest,
  String currentText = '',
  bool youTube = false,
}) async {
  TextEditingController controller = TextEditingController()
    ..text = currentText;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(newRequest),
        content: TextField(
          maxLength: youTube ? 50 : 20,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          controller: controller,
        ),
        actions: [
          Transform.rotate(
            angle: pi / 4,
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Icon(
                Icons.add_circle_outline_outlined,
                color: Colors.red,
                size: 40,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            child: const Icon(
              Icons.check_circle_outline_outlined,
              color: Color(0xff258029),
              size: 40,
            ),
          ),
        ],
      );
    },
  );
}
