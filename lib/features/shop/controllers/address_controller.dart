import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/address/address_repository.dart';
import 'package:t_store/features/personalization/models/address_model.dart';
import 'package:t_store/utils/popups/loaders.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  final isLoading = false.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final RxList<AddressModel> allUserAddresses = <AddressModel>[].obs;
  final _addressRepository = Get.put(AddressRepository());

  @override
  void onInit() {
    fetchAllUserAddresses();
    super.onInit();
  }

  Future<List<AddressModel>> fetchAllUserAddresses() async {
    try {
      isLoading.value = true;
      final addresses = await _addressRepository.fetchUserAddresses();
      allUserAddresses.assignAll(addresses);
      final selected = addresses.where((a) => a.selectedAddress).toList();
      if (selected.isNotEmpty) selectedAddress.value = selected.first;
      return addresses;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> selectAddress(AddressModel newSelectedAddress) async {
    try {
      for (final address in allUserAddresses) {
        if (address.selectedAddress) {
          await _addressRepository.updateSelectedField(address.id, false);
        }
      }
      await _addressRepository.updateSelectedField(
          newSelectedAddress.id, true);
      selectedAddress.value = newSelectedAddress;
      await fetchAllUserAddresses();
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<void> addNewAddress() async {
    try {
      if (!addressFormKey.currentState!.validate()) return;
      isLoading.value = true;

      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
      );

      final id = await _addressRepository.addAddress(address);
      address.id = id;

      if (allUserAddresses.isEmpty) {
        await _addressRepository.updateSelectedField(id, true);
        selectedAddress.value = address;
      }

      await fetchAllUserAddresses();
      _clearFields();
      TLoaders.successSnackBar(
          title: 'Address saved',
          message: 'Your address has been saved successfully.');
      Get.back();
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void _clearFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
  }

  @override
  void onClose() {
    name.dispose();
    phoneNumber.dispose();
    street.dispose();
    postalCode.dispose();
    city.dispose();
    state.dispose();
    country.dispose();
    super.onClose();
  }
}
