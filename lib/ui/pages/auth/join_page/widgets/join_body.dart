import 'package:flutter/material.dart';
import 'package:flutter_blog/ui/widgets/custom_logo.dart';
import 'join_form.dart';

class JoinBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const CustomLogo("Blog"),
          JoinForm(),
        ],
      ),
    );
  }
}
