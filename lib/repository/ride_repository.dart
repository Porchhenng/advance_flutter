import 'package:week_3_blabla_project/model/ride/ride.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/service/rides_service.dart';

abstract class RideRepository {
  List <Ride> getRides({required RidePreference ridePref, RideFilters? filter});
}
