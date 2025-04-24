import 'dart:developer';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:islamy/core/extensions/padding_extension.dart';
import '../../config/res/constants_manager.dart';
import '../../generated/locale_keys.g.dart';
import '../navifation/go.dart';
import '../shared/models/location.dart';
import '../widgets/confirm_location.dart';
import '../widgets/custom_messages.dart';
import 'cache_service.dart';
import 'check_permission/model.dart';
import 'helpers.dart';

enum NavigationMethod{ push, pop }
enum MapPurpose{detectCurrentUserLocation, viewProviderLocation}

class LocationScreenWithNamed extends StatelessWidget {
  final NavigationMethod method;
  final MapPurpose mapPurpose;
  final LatLng? providerPosition;

  const LocationScreenWithNamed({super.key,
    required this.method,
    required this.mapPurpose,
    this.providerPosition,
  });

  const LocationScreenWithNamed.detectCurrentUserLocation({
    super.key,
    required this.method
  }) : mapPurpose = MapPurpose.detectCurrentUserLocation, providerPosition = null;

  const LocationScreenWithNamed.viewProviderLocation({
    super.key,
    required this.method,
    required this.providerPosition,
  }) : mapPurpose = MapPurpose.viewProviderLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _LocationBodyWithNamed(method: method, mapPurpose: mapPurpose, providerPosition: providerPosition,),
      );
  }
}

class _LocationBodyWithNamed extends StatefulWidget {
  final NavigationMethod method;
  final MapPurpose mapPurpose;
  final LatLng? providerPosition;
  const _LocationBodyWithNamed({
    required this.method,
    required this.mapPurpose,
    this.providerPosition
  });

  @override
  State<_LocationBodyWithNamed> createState() => _LocationBodyState();
}

class _LocationBodyState extends State<_LocationBodyWithNamed> {
  final LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.best,
      distanceFilter: 100,
      timeLimit: Duration(seconds: 30)
  );

  bool isMapsLoading = false;

  Future<void> handleLocationScreen() async {
    await Helpers.checkPermission(
        PermissionProcessModel(
          permissionClient: PermissionClient.location,
          onPermissionGranted: () async => await handleGetLocationProcess(),
          onPermissionDenied: () => Go.back(),
          messageOnDenied: LocaleKeys.cannot_access_location.tr(),
        )
    );
  }

  Future<void> handleGetLocationProcess() async {
    setState(() => isMapsLoading = true);
    await getCurrentLatLng();
    await getLocationBasedLatLng();
    changeCameraPosition();
    setState(() => isMapsLoading = false);


    // await Geolocator.getCurrentPosition();
    // setLocaleIdentifier(Go.navigatorKey.currentContext!.locale.languageCode);
    // List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    // return placemarks.first;
  }

  LatLng currentLatLng = const LatLng(0, 0);

  Future<void> getCurrentLatLng() async {
    late Position position;
    try {
      position = await Geolocator.getCurrentPosition(locationSettings: locationSettings);
    } catch (e) {
      log('error :$e');
    }
    currentLatLng = LatLng(position.latitude, position.longitude);
  }

  Future<void> saveLastLocation() async =>
      await CacheStorage.write(
          CacheConstants.lastLocation,
          locationModel?.toJson()
      );

  LocationModel? locationModel;

  Future<void> getLocationBasedLatLng() async {
    log('reFetching location');
    List<Placemark> locations = await placemarkFromCoordinates(
        currentLatLng.latitude,
        currentLatLng.longitude
    );
    locationModel = LocationModel.fromJson(locations[0].toJson());
    log('street : ${locationModel?.street.toString()}');
  }

  late GoogleMapController mapsController;

  void changeCameraPosition() {
    mapsController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: currentLatLng, zoom: 16),
      ),
    );
  }

  Future<void> getProviderLocation(LatLng providerPosition) async {
    setState(() => currentLatLng = providerPosition);
    changeCameraPosition();
  }

  Future<void> handleLocationScreenWithUserLocationAndProviderLocation({LatLng? providerPosition}) async {
    switch (widget.mapPurpose) {
      case MapPurpose.detectCurrentUserLocation:
        await handleLocationScreen();

      default:
        await getProviderLocation(providerPosition!);
    }
  }

  @override
  void initState() {
    searchController = TextEditingController();
    handleLocationScreenWithUserLocationAndProviderLocation(
        providerPosition: widget.providerPosition
    );
    super.initState();
  }

  @override
  void dispose() {
    mapsController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void changeUserLocation(LatLng newLatLng) async {
    currentLatLng = newLatLng;
    await getLocationBasedLatLng();
    setState(() {});
    log('setState');
  }

  void handleNullCurrentLocation() {
    MessageUtils.showSimpleToast(
        msg: LocaleKeys.cannot_detect_your_location.tr(), color: Colors.red);
  }

  late TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GoogleMap(
            mapType: MapType.terrain,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            onTap: widget.mapPurpose == MapPurpose.detectCurrentUserLocation
                ? changeUserLocation
                : null,
            onMapCreated: (controller) => mapsController = controller,
            initialCameraPosition: const CameraPosition(
                target: LatLng(-100, -100), zoom: 5),

            markers: {
              Marker(markerId: MarkerId(0.toString()), position: currentLatLng)
            },
          ),
          // Visibility(
          //   visible: widget.mapPurpose == MapPurpose.detectCurrentUserLocation,
          //   child: Align(
          //     alignment: Alignment.topCenter,
          //     child: DefaultTextField(
          //       controller: searchController,
          //       contentPadding: const EdgeInsets.all(16),
          //       prefixIcon: SvgPicture.asset(Assets.iconsLocationMarker)
          //           .paddingAll(12),
          //       title: LocaleKeys.searchLocation,
          //       fillColor: Colors.white,
          //       filled: true,
          //     ).paddingAll(10),
          //   ),
          // ),
          Visibility(
            visible: widget.mapPurpose == MapPurpose.detectCurrentUserLocation,
            child: ConfirmLocation(
              location: locationModel?.street ?? '',
              onConfirmLocation: locationModel == null ?
                  () async => handleNullCurrentLocation() :
                  () async {
                // await context.read<LocationCubit>().storeLocation(
                //     StoreLocationModel(
                //       latLng: currentLatLng,
                //       mapDescription: locationModel?.street ??
                //           LocaleKeys.mapDescription,
                //       address: locationModel?.street ?? '',
                //     ));
                //
                // switch (widget.method) {
                //   case NavigationMethod.push:
                //     Go.offAll(const AppBottomBar());
                //
                //   default:
                //     Navigator.pop(context, 'locationChanged');
                // }
                await saveLastLocation();
              },
            ).paddingAll(20),
          )
        ],
      ),
    );
  }
}
