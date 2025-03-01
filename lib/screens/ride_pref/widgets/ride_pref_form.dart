import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/utils/date_time_util.dart';
import 'package:week_3_blabla_project/widgets/display/bla_divider.dart';
import 'package:week_3_blabla_project/widgets/inputs/bla_button.dart';

import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      departureDate = widget.initRidePref!.departureDate;
      arrival = widget.initRidePref!.arrival;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      departure = null;
      departureDate = DateTime.now();
      arrival = null;
      requestedSeats = 1;
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
  void swapLocations() {
    setState(() {
      Location? temp = departure;
      departure = arrival;
      arrival = temp;
    });
  }

  void onDepartureTap() {}
  void onArrivalTap() {}
  void onDepartureDateTap() {}
  void onReqTap() {}
  void onSearachTap() {}

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
  Widget baseInput(
    BuildContext context, {
    required Icon icon,
    required String text,
    required Color textColor,
    required void Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: BlaSpacings.m, vertical: BlaSpacings.m),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            icon,
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  Widget departureInput(
    BuildContext context,
  ) {
    String departureLabel;
    Color textColor;

    if (departure == null) {
      departureLabel = 'Leaving From';
      textColor = BlaColors.neutralLight;
    } else {
      departureLabel = departure!.name;
      textColor = Colors.black;
    }
    return InkWell(
      onTap: onDepartureTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: BlaSpacings.m,
          vertical: BlaSpacings.m,
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(
                    Icons.radio_button_off_rounded,
                    color: BlaColors.neutralLight,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    departureLabel,
                    style: TextStyle(
                        color: textColor, fontWeight: FontWeight.w500),
                  ),
                  if (departure != null)
                    InkWell(
                      onTap: swapLocations,
                      child: Icon(
                        Icons.swap_vert_sharp,
                        color: BlaColors.primary,
                      ),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget arrivalInput(BuildContext context) {
    String arrivalLabel;
    Color textColor;
    if (arrival == null) {
      arrivalLabel = 'Going to';
      textColor = BlaColors.neutralLight;
    } else {
      arrivalLabel = arrival!.name;
      textColor = Colors.black;
    }

    return baseInput(context,
        icon: Icon(
          Icons.radio_button_off_rounded,
          color: BlaColors.neutralLight,
        ),
        text: arrivalLabel,
        textColor: textColor,
        onTap: onArrivalTap);
  }

  Widget departureDateInput(BuildContext context) {
    String departureDateLabel = DateTimeUtils.formatDateTime(departureDate);

    return baseInput(context,
        icon: Icon(
          Icons.calendar_month_rounded,
          color: BlaColors.neutralLight,
        ),
        text: departureDateLabel,
        textColor: Colors.black,
        onTap: onDepartureDateTap);
  }

  Widget requestedSeatsInput(BuildContext context) {
    String seatsLabel = requestedSeats.toString();

    return baseInput(
      context,
      icon: Icon(
        Icons.person_outline_rounded,
        color: BlaColors.neutralLight,
      ),
      text: seatsLabel,
      textColor: Colors.black,
      onTap: onDepartureDateTap,
    );
  }

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          departureInput(context),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: BlaSpacings.l),
            child: BlaDivider(),
          ),
          arrivalInput(context),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: BlaSpacings.l),
            child: BlaDivider(),
          ),
          departureDateInput(context),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: BlaSpacings.l),
            child: BlaDivider(),
          ),
          requestedSeatsInput(context),
          BlaButton(
              Text('Search',
                  ), isPrimary: true,
              onPressed: onSearachTap)
        ]);
  }
}
