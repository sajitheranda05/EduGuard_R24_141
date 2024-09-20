import 'package:eduguard/src/features/sos_system/location/controllers/map_controller.dart';
import 'package:eduguard/src/utils/constants/color_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SOSMapPage extends StatelessWidget {
  final MapController mapController = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Column(
        children: [
          // Switch for location sharing
          SizedBox(
            height: 48.0,
            width: double.infinity,
            child: Obx(
              () => SwitchListTile(
                title: const Text('Enable Location Sharing'),
                value: mapController.isLocationSharingEnabled.value,
                onChanged: (value) {
                  mapController.toggleLocationSharing(value);
                },
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: mapController.cachedContacts.map((contact) {
                  final String contactId= contact.id;
                  // Ensure each button captures its own contactId
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: OutlinedButton(
                      onPressed: () async{
                        await mapController.getEmergencyContactLocation(contactId);
                        LatLng? contactLocation = mapController.contactLocations[contactId];
                        if (contactLocation != null) {
                          print(
                              'Updating map with location: $contactLocation for contactId: $contactId');
                          if (mapController.mapController.value != null) {
                            mapController.updateMapWithLocation(contactLocation,
                                mapController.mapController.value!);
                          } else {
                            print(
                                'Error: GoogleMapController is not initialized.');
                          }
                        } else {
                          print(
                              'Error: Location for contactId $contactId not found.');
                        }
                      },
                      child: Column(
                        children: [
                          Text(contact.name),
                        ],
                      ), // Replace with contact name if available
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Map view
          Expanded(
            child: Obx(
              () => GoogleMap(
                onMapCreated: mapController.onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: mapController.currentLocation.value,
                  zoom: 14.0,
                ),
                markers: mapController.markers.value,
                onTap: (LatLng position) {
                  mapController.addMarker(position);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
