import 'package:flutter/material.dart';
import 'package:process/core/global/entities/user.dart';
import 'package:process/features/profile/presentation/widgets/profile/profile_bottom_sheet_widget.dart';

class ProfileDataSectionWidget extends StatelessWidget {
  final User? user;

  const ProfileDataSectionWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.red[100],
                    child: Icon(
                      Icons.account_circle_outlined,
                      color: Colors.red[900],
                      size: 36,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user!.firstName} ${user!.lastName}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      user!.phoneNumber,
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 14),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit_outlined, size: 22),
              ),
            ),
          ],
        ),
      );
    } else {
      return Material(
        elevation: 1.5,
        shadowColor: Colors.grey.withOpacity(0.3),
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () {
            StaticBottomSheet.authShow(context);
          },
          splashColor: Colors.black,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.grey[200],
                        child: Icon(
                          Icons.account_circle_outlined,
                          color: Colors.grey[700],
                          size: 36,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Вы не вошли в аккаунт',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(Icons.chevron_right, size: 26, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
