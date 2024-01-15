import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/controllers/auth_controller.dart';
import 'package:task_manager_app/ui/screens/edit_profile_screen.dart';
import 'package:task_manager_app/ui/screens/login_screen.dart';

class ProfileSummeryCard extends StatefulWidget {
  final bool onTapStatus;

  const ProfileSummeryCard({
    super.key,
    this.onTapStatus = true,
  });

  @override
  State<ProfileSummeryCard> createState() => _ProfileSummeryCardState();
}

class _ProfileSummeryCardState extends State<ProfileSummeryCard> {
  String imageFormat = AuthController.user?.photo ?? '';

  @override
  Widget build(BuildContext context) {
    if (imageFormat.startsWith('data:image')) {
      imageFormat =
          imageFormat.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
    }
    Uint8List imageInBytes = const Base64Decoder().convert(imageFormat);
    return ListTile(
      onTap: () {
        if (widget.onTapStatus == true) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const EditProfileScreen()),
          );
        }
      },
      leading: Visibility(
        visible: imageInBytes.isNotEmpty,
        replacement: const CircleAvatar(
          backgroundColor: Colors.lightGreen,
          child: Icon(Icons.account_circle_outlined),
        ),
        child: CircleAvatar(
          backgroundImage: Image.memory(
            imageInBytes,
            fit: BoxFit.cover,
          ).image,
          backgroundColor: Colors.lightGreen,
        ),
      ),
      title: Text(
        userFullName,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      subtitle: Text(
        AuthController.user?.email ?? '',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      trailing: IconButton(
        onPressed: () async {
          await AuthController.clearAuthData();
          if (mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
                  (route) => false,
            );
          }
        },
        icon: const Icon(Icons.logout),
      ),
    );
  }

  String get userFullName {
    return '${AuthController.user?.firstName ?? ''} ${AuthController.user?.lastName ?? ''}';
  }
}


// import 'dart:convert';
// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:task_manager_app/ui/controllers/auth_controller.dart';
// import 'package:task_manager_app/ui/screens/edit_profile_screen.dart';
// import 'package:task_manager_app/ui/screens/login_screen.dart';
//
// class ProfileSummeryCard extends StatelessWidget {
//   const ProfileSummeryCard({
//     super.key,
//     this.enableOnTap = true,
//   });
//
//   final bool enableOnTap;
//
//   @override
//   Widget build(BuildContext context) {
//     Uint8List imageBytes =
//     const Base64Decoder().convert(AuthController.user?.photo ?? '');
//     return ListTile(
//       onTap: () {
//         if (enableOnTap) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const EditProfileScreen()),
//           );
//         }
//       },
//       leading: CircleAvatar(
//         child: AuthController.user?.photo == null
//             ? const Icon(Icons.person)
//             : ClipRRect(
//           borderRadius: BorderRadius.circular(30),
//           child: Image.memory(
//             imageBytes,
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//       title: Text(
//         fullName,
//         style: const TextStyle(
//           color: Colors.white,
//           fontWeight: FontWeight.w700,
//         ),
//       ),
//       subtitle: Text(
//         AuthController.user?.email ?? '',
//         style: const TextStyle(
//           color: Colors.white,
//           fontWeight: FontWeight.w700,
//         ),
//       ),
//       trailing: IconButton(
//         onPressed: () async {
//           await AuthController.clearAuthData();
//           //ToDo - solve the warning
//           Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(builder: (context) => LoginScreen()),
//                   (route) => false);
//         },
//         icon: const Icon(Icons.logout),
//       ),
//       tileColor: Colors.green,
//     );
//   }
//
//   String get fullName {
//     return '${AuthController.user?.firstName ?? ''} ${AuthController.user?.lastName ?? ')'}';
//   }
// }