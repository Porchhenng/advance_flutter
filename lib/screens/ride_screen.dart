import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/ride.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/service/rides_service.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/utils/date_time_util.dart';
import 'package:week_3_blabla_project/widgets/inputs/bla_button.dart';

class RideScreen extends StatefulWidget {
  const RideScreen({super.key, required this.initRidePref});

  final RidePref initRidePref;

  @override
  State<RideScreen> createState() => _RideScreenState();
}

class _RideScreenState extends State<RideScreen> {
  late RidePref ridePref;
  List<Ride> foundRides = [];

  String get prefTitle =>
      "${ridePref.departure.name} → ${ridePref.arrival.name}";

  String get prefSubTitle =>
      "${DateTimeUtils.formatDateTime(ridePref.departureDate)}, ${ridePref.requestedSeats} passenger${ridePref.requestedSeats > 1 ? "s" : ""}";
  @override
  void initState() {
    super.initState();
    ridePref = widget.initRidePref;
    findRides();
    super.initState();
  }

  void findRides() {
    foundRides = RidesService.getRides(ridePref);
    debugPrint(foundRides.toString());
  }

  void onFilterPressed() {}

  void onRidePrefPressed() {}

  void onBackPressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(BlaSpacings.m),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: BlaSpacings.m,
                vertical: BlaSpacings.s,
              ),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(),
                borderRadius: BorderRadius.circular(BlaSpacings.radius),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: onBackPressed,
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: BlaColors.iconNormal,
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: onRidePrefPressed,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            prefTitle,
                            style: BlaTextStyles.label.copyWith(
                              color: BlaColors.textNormal,
                            ),
                          ),
                          Text(
                            prefSubTitle,
                            style: BlaTextStyles.label.copyWith(
                              color: BlaColors.textLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: BlaButton(
                      Text("Filter"),
                      onPressed: onFilterPressed,
                      isPrimary: false,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: foundRides.length,
                itemBuilder: (ctx, index) =>
                    RideTile(ride: foundRides[index], onTap: () {}),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RideTile extends StatelessWidget {
  final Ride ride;

  final void Function() onTap;

  const RideTile({super.key, required this.ride, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: SizedBox(
          width: double.infinity,
          height: 100,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Departure: ${ride.departureLocation.name}'),
              Text('Arrival: ${ride.arrivalLocation.name}'),
              Text('Time: ${DateTimeUtils.formatDateTime(ride.departureDate)}'),
              Text('Seats: ${ride.availableSeats}'),
            ],
          ),
        ),
      ),
    );
  }
}
