import 'package:flutter/material.dart';
import 'package:prueba_dvp/features/presentation/pages/user_form_page.dart';

class AddUserFloatingButton extends StatelessWidget {
  const AddUserFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const UserFormPage()),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
