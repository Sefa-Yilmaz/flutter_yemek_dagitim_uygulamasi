import 'package:flutter/material.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/base/custom_app_bar.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/auth_contoller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/location_controller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/user_contoller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/models/address_model.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/models/user_model.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/pages/address/pick_address_map.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/routes/route_helper.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/colors.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/dimensions.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/app_icon.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/app_text_field.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/widgets/buyuk_baslik.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition = CameraPosition(target: LatLng(45.51563, -122.677433), zoom: 17);
  late LatLng _initialPosition = LatLng(45.51563, -122.677433);

  @override
  void initState() {
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if (_isLogged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      if (Get.find<LocationController>().getUserAddressFromLocalStorage() == '') {
        Get.find<LocationController>().saveUserAddress(Get.find<LocationController>().addressList.last);
      }
      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(
          target: LatLng(
        double.parse(Get.find<LocationController>().getAddress['latitude']),
        double.parse(Get.find<LocationController>().getAddress['langitude']),
      ));
      _initialPosition = LatLng(
        double.parse(Get.find<LocationController>().getAddress['latitude']),
        double.parse(Get.find<LocationController>().getAddress['langitude']),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Address'),
      body: GetBuilder<UserController>(
        builder: (userController) {
          if (userController.userModel != null && _contactPersonName.text.isEmpty) {
            _contactPersonName.text = '${userController.userModel.name}';
            _contactPersonName.text = '${userController.userModel.phone}';
            if (Get.find<LocationController>().addressList.isNotEmpty) {
              _addressController.text = Get.find<LocationController>().getUserAddress().address;
            }
          }
          return GetBuilder<LocationController>(
            builder: (locationController) {
              _addressController.text = '${locationController.placemark.name ?? ''}'
                  '${locationController.placemark.locality ?? ''}'
                  '${locationController.placemark.postalCode ?? ''}'
                  '${locationController.placemark.country ?? ''}';
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 140,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          width: 2,
                          color: AppColors.mainColor,
                        ),
                      ),
                      child: Stack(
                        children: [
                          GoogleMap(
                            initialCameraPosition: CameraPosition(target: _initialPosition, zoom: 17),
                            onTap: (latlng) {
                              Get.toNamed(RouteHelper.getPickAddressPage(),
                                  arguments: PickAddressMap(
                                    fromSignup: false,
                                    fromAddress: true,
                                    googleMapController: locationController.mapController,
                                  ));
                            },
                            zoomControlsEnabled: false,
                            compassEnabled: false,
                            indoorViewEnabled: true,
                            mapToolbarEnabled: false,
                            myLocationEnabled: true,
                            onCameraIdle: () {
                              locationController.updatePosition(_cameraPosition, true);
                            },
                            onCameraMove: ((position) => _cameraPosition = position),
                            onMapCreated: (GoogleMapController controller) {
                              locationController.setMapController(controller);
                              if (Get.find<LocationController>().addressList.isEmpty) {
                                //asdas
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Boyutlar.width20, top: Boyutlar.height20),
                      child: SizedBox(
                        height: 50,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: locationController.addressTypeList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  locationController.setAddressTypeIndex(index);
                                },
                                child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: Boyutlar.width20, vertical: Boyutlar.height10),
                                    margin: EdgeInsets.only(right: Boyutlar.width10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(Boyutlar.radius20 / 4),
                                        color: Theme.of(context).cardColor,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade200,
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                          )
                                        ]),
                                    child: Icon(
                                      index == 0
                                          ? Icons.home_filled
                                          : index == 1
                                              ? Icons.work
                                              : Icons.location_on,
                                      color: locationController.addressTypeIndex == index ? AppColors.mainColor : Theme.of(context).disabledColor,
                                    )),
                              );
                            }),
                      ),
                    ),
                    SizedBox(height: Boyutlar.height20),
                    Padding(
                      padding: EdgeInsets.only(left: Boyutlar.width20),
                      child: BuyukBaslik(text: 'Delivery address'),
                    ),
                    SizedBox(height: Boyutlar.height10),
                    UygulamaMetinAlani(textController: _addressController, hintText: 'Your address', icon: Icons.map),
                    SizedBox(height: Boyutlar.height20),
                    Padding(
                      padding: EdgeInsets.only(left: Boyutlar.width20),
                      child: BuyukBaslik(text: 'Contact name'),
                    ),
                    SizedBox(height: Boyutlar.height10),
                    UygulamaMetinAlani(textController: _contactPersonName, hintText: 'Your name', icon: Icons.person),
                    SizedBox(height: Boyutlar.height20),
                    Padding(
                      padding: EdgeInsets.only(left: Boyutlar.width20),
                      child: BuyukBaslik(text: 'Your number'),
                    ),
                    SizedBox(height: Boyutlar.height10),
                    UygulamaMetinAlani(textController: _contactPersonNumber, hintText: 'Your number', icon: Icons.phone),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: GetBuilder<LocationController>(
        builder: (locationController) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                //satın alam kısmın boyutlandırma
                height: Boyutlar.height20 * 8,
                padding: EdgeInsets.only(
                  top: Boyutlar.height30,
                  bottom: Boyutlar.height30,
                  right: Boyutlar.width20,
                  left: Boyutlar.width20,
                ),
                decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(Boyutlar.radius20 * 2), topRight: Radius.circular(Boyutlar.radius20 * 2)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //sepete ekleme kısmı
                    GestureDetector(
                      onTap: () {
                        AddressModel _addressModel = AddressModel(
                          addressType: locationController.addressTypeList[locationController.addressTypeIndex],
                          contactPersonName: _contactPersonName.text,
                          contactPersonNumber: _contactPersonNumber.text,
                          address: _addressController.text,
                          latitude: locationController.position.latitude.toString(),
                          longitude: locationController.position.longitude.toString(),
                        );
                        locationController.addAddress(_addressModel).then((response) {
                          if (response.isSuccess) {
                            Get.toNamed(RouteHelper.getInitial());
                            Get.snackbar('Address', 'Added Successfully');
                          } else {
                            Get.snackbar('Address', 'Couldn t save address');
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: Boyutlar.height20, bottom: Boyutlar.height20, left: Boyutlar.width20, right: Boyutlar.width20),
                        child: BuyukBaslik(
                          text: 'Save Address',
                          color: Colors.white,
                          size: 26,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Boyutlar.radius20),
                          color: AppColors.mainColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
