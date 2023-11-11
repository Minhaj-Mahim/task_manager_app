import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/edit_profile_screen.dart';

class ProfileSummaryCard extends StatelessWidget {
  const ProfileSummaryCard({
    super.key,
    this.enableOnTap = true,
  });

  final bool enableOnTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (enableOnTap) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EditProfileScreen()),
          );
        }
      },
      leading: CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(
        'Rabbil Hasan',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(
        'rabbil@gmail.com',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      trailing: enableOnTap
          ? Icon(
              Icons.arrow_forward,
              color: Colors.white,
            )
          : null,
      tileColor: Colors.green,
    );
  }
}
