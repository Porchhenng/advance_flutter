import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/repository/ride_repository.dart';

import '../dummy_data/dummy_data.dart';
import '../model/ride/ride.dart';

////
///   This service handles:
///   - The list of available rides
///
class RidesService {
  static RidesService? _instance;

  // Access to location repository
  final RideRepository repository;

  ///
  /// Private constructor
  ///
  RidesService._internal(this.repository);

  ///
  /// Initialize the service with a LocationRepository
  ///
  static void initialize(RideRepository repository) {
    if (_instance == null) {
      _instance = RidesService._internal(repository);
    } else {
      throw Exception("RidesService is already initialized.");
    }
  }

  ///
  /// Singleton accessor
  ///
  static RidesService get instance {
    if (_instance == null) {
      throw Exception("RidesService is not initialized. Call initialize() first.");
    }
    return _instance!;
  }

  List<Ride> getRides ({ required RidePreference ridePref, RideFilters? filter }){
    return repository.getRides(ridePref: ridePref, filter: filter);
  }
  

  /// Retrieve the list of available locations
  /// First, try to load from the repository; if no data is returned,
  /// fallback to dummy data.

}
class RideFilters {
  bool acceptPets;
  RideFilters({required this.acceptPets});
}