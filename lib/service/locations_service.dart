import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/repository/locationRepository.dart';
import '../dummy_data/dummy_data.dart';

/// This service handles:
/// - The list of available rides (locations)
class LocationsService {
  static LocationsService? _instance;

  // Access to location repository
  final LocationRepository repository;

  ///
  /// Private constructor
  ///
  LocationsService._internal(this.repository);

  ///
  /// Initialize the service with a LocationRepository
  ///
  static void initialize(LocationRepository repository) {
    if (_instance == null) {
      _instance = LocationsService._internal(repository);
    } else {
      throw Exception("LocationsService is already initialized.");
    }
  }

  ///
  /// Singleton accessor
  ///
  static LocationsService get instance {
    if (_instance == null) {
      throw Exception("LocationsService is not initialized. Call initialize() first.");
    }
    return _instance!;
  }

  List<Location> get allLocations => repository.getLocation();
  

  /// Retrieve the list of available locations
  /// First, try to load from the repository; if no data is returned,
  /// fallback to dummy data.

}
