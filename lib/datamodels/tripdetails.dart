import 'package:google_maps_flutter/google_maps_flutter.dart';

class TripDetails {
  String? carDetails;
  String? createdAt;
  LatLng? destination;
  String? destinationAddress;
  String? driverId;
  LatLng? driverLocation;
  String? driverName;
  String? driverPhone;
  String? fares;
  LatLng? location;
  String? paymentMethod;
  String? pickupAddress;
  String? riderName;
  String? riderPhone;
  String? status;
  String? rideID;

  TripDetails(
      {this.carDetails,
      this.createdAt,
      this.destination,
      this.destinationAddress,
      this.driverId,
      this.driverLocation,
      this.driverName,
      this.driverPhone,
      this.fares,
      this.location,
      this.paymentMethod,
      this.pickupAddress,
      this.riderName,
      this.riderPhone,
      this.status});

  TripDetails.fromJson(Map<String, dynamic> json) {
    carDetails = json['car_details'];
    createdAt = json['created_at'];
    destination = json['destination'] != null
        ? LatLng.fromJson(json['destination'])
        : null;
    destinationAddress = json['destination_address'];
    driverId = json['driver_id'];
    driverLocation = json['driver_location'] != null
        ? LatLng.fromJson(json['driver_location'])
        : null;
    driverName = json['driver_name'];
    driverPhone = json['driver_phone'];
    fares = json['fares'];
    location =
        json['location'] != null ? LatLng.fromJson(json['location']) : null;
    paymentMethod = json['payment_method'];
    pickupAddress = json['pickup_address'];
    riderName = json['rider_name'];
    riderPhone = json['rider_phone'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['car_details'] = carDetails;
    data['created_at'] = createdAt;
    if (destination != null) {
      data['destination'] = destination!.toJson();
    }
    data['destination_address'] = destinationAddress;
    data['driver_id'] = driverId;
    if (driverLocation != null) {
      data['driver_location'] = driverLocation!.toJson();
    }
    data['driver_name'] = driverName;
    data['driver_phone'] = driverPhone;
    data['fares'] = fares;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['payment_method'] = paymentMethod;
    data['pickup_address'] = pickupAddress;
    data['rider_name'] = riderName;
    data['rider_phone'] = riderPhone;
    data['status'] = status;
    return data;
  }
}

class Destination {
  String? latitude;
  String? longitude;

  Destination({this.latitude, this.longitude});

  Destination.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
