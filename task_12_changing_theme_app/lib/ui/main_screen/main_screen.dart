import 'package:flutter/material.dart';
import 'package:task_12_changing_theme_app/assets/colors/app_colors.dart';
import 'package:task_12_changing_theme_app/assets/res/app_images.dart';
import 'package:task_12_changing_theme_app/my_widget/build_bottom_sheet_widget.dart';
import 'package:task_12_changing_theme_app/assets/res/app_strings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppStrings.profile,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        leading: Icon(
          Icons.arrow_back_outlined,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Text(
              AppStrings.save,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            AvatarWidget(),
            SizedBox(height: 20),
            AwardsSection(),
            UserInfoCards(),
            SizedBox(height: 40),
            LogoutButton(),
          ],
        ),
      ),
    );
  }
}

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Stack(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage(AppImages.avatar),
          ),
          Positioned(
            top: 30,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                AppStrings.edit,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.white,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AwardsSection extends StatelessWidget {
  const AwardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.myAwards,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Image.asset(AppImages.medals),
        ),
      ],
    );
  }
}

class UserInfoCards extends StatelessWidget {
  const UserInfoCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _MyCardWidget(
          nameLabel: AppStrings.name,
          defaultName: AppStrings.profileName,
        ),
        const _MyCardWidget(
          nameLabel: AppStrings.emale,
          defaultName: AppStrings.profileEmale,
        ),
        const _MyCardWidget(
          nameLabel: AppStrings.birthday,
          defaultName: AppStrings.profileBirthday,
        ),
        const _MyCardWidget(
          nameLabel: AppStrings.team,
          defaultName: AppStrings.profileTeam,
          isIconButton: true,
        ),
        const _MyCardWidget(
          nameLabel: AppStrings.position,
          defaultName: AppStrings.profilePosition,
          isIconButton: true,
        ),
        _MyCardWidget(
          nameLabel: AppStrings.theme,
          defaultName: AppStrings.profileTheme,
          isIconButton: true,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return const BuildBottomSheetWidget();
              },
            );
          },
        ),
      ],
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        onPressed: () {},
        child: const Text(AppStrings.logOut),
      ),
    );
  }
}

class _MyCardWidget extends StatelessWidget {
  final String nameLabel;
  final String defaultName;
  final bool isIconButton;
  final VoidCallback? onPressed;

  const _MyCardWidget({
    required this.nameLabel,
    required this.defaultName,
    this.isIconButton = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nameLabel,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                Text(
                  defaultName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
            if (isIconButton)
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 15,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: onPressed,
              ),
          ],
        ),
      ),
    );
  }
}
