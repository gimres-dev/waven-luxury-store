import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/images/t_circular_image.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/personalization/controllers/user_controller.dart';
import 'package:t_store/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      appBar: const TAppBar(showBackArrow: true, title: Text('Profile')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Avatar
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final pic = controller.user.value.profilePicture;
                      return TCircularImage(
                        image: pic.isNotEmpty ? pic : TImages.user,
                        width: 80,
                        height: 80,
                        isNetworkImage: pic.isNotEmpty,
                      );
                    }),
                    TextButton(onPressed: () {}, child: const Text('Change Profile Picture')),
                  ],
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSectionHeading(title: 'Profile Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              Obx(() {
                final user = controller.user.value;
                return Column(
                  children: [
                    TProfileMenu(onPressed: () {}, title: 'Name', value: user.fullName),
                    TProfileMenu(onPressed: () {}, title: 'Username', value: user.username),
                  ],
                );
              }),

              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSectionHeading(title: 'Personal Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              Obx(() {
                final user = controller.user.value;
                return Column(
                  children: [
                    TProfileMenu(onPressed: () {}, title: 'User ID', value: user.id.isNotEmpty ? user.id.substring(0, 8) : '--', icon: Iconsax.copy),
                    TProfileMenu(onPressed: () {}, title: 'E-mail', value: user.email),
                    TProfileMenu(onPressed: () {}, title: 'Phone Number', value: user.phoneNumber.isNotEmpty ? user.phoneNumber : '--'),
                    TProfileMenu(onPressed: () {}, title: 'First Name', value: user.firstName.isNotEmpty ? user.firstName : '--'),
                    TProfileMenu(onPressed: () {}, title: 'Last Name', value: user.lastName.isNotEmpty ? user.lastName : '--'),
                  ],
                );
              }),

              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const EditProfileScreen()),
                  child: const Text('Edit Profile'),
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwItems),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Close Account', style: TextStyle(color: Colors.red)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Edit Profile Screen ──────────────────────────────────────────────────────

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      appBar: const TAppBar(showBackArrow: true, title: Text('Edit Profile')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TextFormField(
                controller: controller.firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  prefixIcon: Icon(Iconsax.user),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              TextFormField(
                controller: controller.lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  prefixIcon: Icon(Iconsax.user),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              TextFormField(
                controller: controller.usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Iconsax.user_edit),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              TextFormField(
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Iconsax.call),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: controller.isSaving.value
                        ? null
                        : () => controller.updateUserProfile(),
                    child: controller.isSaving.value
                        ? const CircularProgressIndicator()
                        : const Text('Save Changes'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
