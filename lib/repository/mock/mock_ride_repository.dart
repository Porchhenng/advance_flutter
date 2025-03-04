import 'package:week_3_blabla_project/dummy_data/dummy_data.dart';
import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/model/ride/ride.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/repository/ride_repository.dart';
import 'package:week_3_blabla_project/service/rides_service.dart';

class MockRideRepository extends RideRepository{
  @override
  List<Ride> getRides({required RidePreference ridePref, RideFilters? filter} ) {

    return battambangRides; }

  
}