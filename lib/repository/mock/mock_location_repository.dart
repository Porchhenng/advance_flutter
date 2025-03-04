import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/repository/locationRepository.dart';
import 'package:week_3_blabla_project/repository/ride_preferences_repository.dart';

import '../../dummy_data/dummy_data.dart';

class MockLocationRepository extends LocationRepository {


  @override
  List<Location> getLocation() {
    // TODO: implement getLocation
    return [
      Location(name: "Phnom Penh", country: Country.cambodia),
      Location(name: "Siem Reap", country: Country.cambodia),
      Location(name: "Battambang", country: Country.cambodia),
      Location(name: "Sihannoukvile", country: Country.cambodia),
      Location(name: "Kampot", country: Country.cambodia),
    ];
  }


}
