import 'package:get/get.dart';
import 'package:karaz_driver/datamodels/address/addresses.dart';
import 'package:karaz_driver/datamodels/driver.dart';

Rx<Driver> currentDriverInfo = Driver().obs;
Rx<AddressModel> cureentAddress = AddressModel().obs;
