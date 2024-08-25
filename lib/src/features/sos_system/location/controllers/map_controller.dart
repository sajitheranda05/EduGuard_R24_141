import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduguard/src/data/repositories/authentication_repository.dart';
import 'package:eduguard/src/utils/popups/snackbars.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapController extends GetxController {

  Rx<GoogleMapController?> mapController = Rx<GoogleMapController?>(null);
  Rx<LatLng> currentLocation = Rx<LatLng>(LatLng(0, 0));
  RxSet<Marker> markers = RxSet<Marker>();
  RxBool isLocationSharingEnabled = false.obs;

  Map<String, LatLng> contactLocationsCache ={};
  RxList<String> contactIds = RxList<String>();
  RxMap<String, LatLng> contactLocations = RxMap<String, LatLng>();

  final Location _location = Location();

  final CameraPosition initialPosition = const CameraPosition(
    target: LatLng(0, 0),
    zoom: 14.0,
  );

  @override
  void onInit() {
    super.onInit();
    _getCurrentLocation();
    _fetchContactsAndLocations();
    _periodicUpdate();
  }

  // Fetch Location data of emergency Contacts
  Future<void> _fetchContactsAndLocations() async {
    try {
      await fetchAndCacheEmergencyContactIds();

      for (String contactId in contactIds) {
        var locationData = await getEmergencyContactLocation(contactId);

        // Check if location data is valid before storing it
        if (locationData != null && locationData['latitude'] != null && locationData['longitude'] != null) {
          contactLocations[contactId] = LatLng(locationData['latitude'], locationData['longitude']);
        } else {
          print('Skipping contact $contactId - location data not available');
          AppSnackBars.warningSnackBar(
              title: 'Not available',
              message: 'Emergency contact loaction data not available...'
          );
        }
      }
    } catch (e) {
      AppSnackBars.errorSnackBar(
          title: 'Error',
          message: 'Fetching Emergency Contact Locations failed...'
      );
    }
  }


  //Time interval for Fetching location data
  Future<void> _periodicUpdate() async {
    Timer.periodic(const Duration(minutes: 5), (timer) async {
      await _fetchContactsAndLocations();
    });
  }

  //fetch the location of authenticated user
  Future<void> _getCurrentLocation() async {
    final hasPermission = await _location.hasPermission();
    if (hasPermission == PermissionStatus.granted) {
      try {
        final locationData = await _location.getLocation();
        print('Location Data: Latitude: ${locationData.latitude}, Longitude: ${locationData.longitude}');

        if (locationData.latitude != null && locationData.longitude != null) {
          currentLocation.value = LatLng(locationData.latitude!, locationData.longitude!);
          _updateMapLocation();
        } else {
          print('Location data is null or invalid');
        }
      } catch (e) {
        print('Error fetching location: $e');
      }
    } else {
      final permissionStatus = await _location.requestPermission();
      if (permissionStatus == PermissionStatus.granted) {
        _getCurrentLocation();
      } else {
        print('Location permission denied');
      }
    }
  }

  //Initialize Map
  void onMapCreated(GoogleMapController controller) {
    mapController.value = controller;
    _updateMapLocation();
  }

  //Update the map location to authenticated user's location
  void _updateMapLocation() {
    if (mapController.value != null) {
      mapController.value!.animateCamera(
        CameraUpdate.newLatLng(currentLocation.value),
      );
      markers.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position: currentLocation.value,
          infoWindow: const InfoWindow(title: 'You are here'),
        ),
      );
    }
  }

  //Update the map location to emergency contact locations
  void updateMapWithLocation(LatLng location, GoogleMapController mapController) {
    mapController.animateCamera(
      CameraUpdate.newLatLng(location),
    );
    addMarker(location);
  }

  //Add the markers in map
  void addMarker(LatLng position) {
    markers.add(
      Marker(
        markerId: MarkerId(position.toString()),
        position: position,
        infoWindow: InfoWindow(title: 'New Marker'),
      ),
    );
  }

  //Location sharing toggle
  void toggleLocationSharing(bool value) async {
    isLocationSharingEnabled.value = value;
    if (value) {
      await storeUserLocation();
    } else {
      await removeUserLocation();
    }
  }

  //Store the Authenticated users location in firestore
  Future<void> storeUserLocation() async {
    try {
      LocationData locationData = await _location.getLocation();
      FirebaseFirestore.instance
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection('Location')
          .doc('latest')
          .set({
        'latitude': locationData.latitude,
        'longitude': locationData.longitude,
        'timestamp': FieldValue.serverTimestamp(),
      });

      AppSnackBars.successSnackBar(
          duration: 5,
          title: 'You have enabled location sharing...',
          message: 'Your location will be visible to your emergency contacts while location sharing is enabled.'
      );

    } catch (e) {

      AppSnackBars.errorSnackBar(
          duration: 5,
          title: 'Error',
          message: 'Location storing failed'
      );

    }
  }

  //Get emergency contact locations
  Future<Map<String, dynamic>?> getEmergencyContactLocation(String contactId) async {
    if (contactLocationsCache.containsKey(contactId)) {
      return {
        'latitude': contactLocationsCache[contactId]?.latitude,
        'longitude': contactLocationsCache[contactId]?.longitude,
      };
    }

    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(contactId)
        .collection('Location')
        .doc('latest')
        .get();

    if (snapshot.exists) {
      var data = snapshot.data() as Map<String, dynamic>;
      contactLocationsCache[contactId] = LatLng(data['latitude'], data['longitude']);
      return data;
    } else {
      return null;
    }
  }

  //fetch emergency contact ids
  Future<void> fetchAndCacheEmergencyContactIds() async {
    try {
      if (contactIds.isEmpty) {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('EmergencyContacts')
            .doc(AuthenticationRepository.instance.authUser?.uid)
            .collection('Contacts')
            .get();

        contactIds.value = querySnapshot.docs.map((doc) => doc.id).toList();

        AppSnackBars.successSnackBar(
            title: 'Success',
            message: 'Emergency Contacts fetched Successfully...'
        );
      }
    } catch (e) {
      AppSnackBars.errorSnackBar(
          title: 'Error',
          message: 'Fetching Emergency Contact Ids Failed.'
      );
    }
  }

  Future<void> removeUserLocation() async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection('Location')
          .doc('latest')
          .delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
