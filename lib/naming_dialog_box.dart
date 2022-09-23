import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

Future namingDialogBox(
    {required BuildContext context,
    required String newRequest,
    String currentText = '', bool youTube = false, bool uniqueCode = false}) async {
  TextEditingController controller = TextEditingController()
    ..text = currentText;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(newRequest),
        content: TextField(
          maxLength: uniqueCode? 24 : youTube == false ? 20 : 50,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          controller: controller,
        ),
        actions: [
          Transform.rotate(
            angle: pi / 4,
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Icon(
                CupertinoIcons.add_circled_solid,
                color: Colors.red,
                size: 40,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            child: const Icon(
              CupertinoIcons.checkmark_circle_fill,
              color: Color(0xff258029),
              size: 40,
            ),
          ),
        ],
      );
    },
  );
}
