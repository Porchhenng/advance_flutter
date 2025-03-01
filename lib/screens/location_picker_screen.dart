import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/service/locations_service.dart';
import 'package:week_3_blabla_project/theme/theme.dart';


class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({
    super.key,
    this.initLocation,
  });
  final Location? initLocation;

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  Location? location;

  List<Location> locationResults = [];

  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  IconData? leftIcon;

  bool get inputIsNotEmpty => controller.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    location = widget.initLocation; // give parameter to the widget to render

    onChange('');
    
  }

  void onLocationTap(Location tapLocation) {
    Navigator.of(context).pop(tapLocation);
  }

  void onBackTap() {
    Navigator.of(context).pop();
  }

  void onClear() {
      controller.clear();
      focusNode.requestFocus();
      onChange('');
  
  }

  void onChange(String updateValue) {
    setState(() {
      locationResults = LocationsService.availableLocations
          .where((location) => location.name.contains(updateValue))
          .toList();
    });
  }

  Widget searchBarInput(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: BlaColors.backgroundAccent,
          borderRadius: BorderRadius.circular(BlaSpacings.s)),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: BlaSpacings.s),
            child: IconButton(
                onPressed: onBackTap,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: BlaColors.iconNormal,
                )),
          ),
          Expanded(
              child: TextField(
            controller: controller,
            focusNode: focusNode,
            onChanged: onChange,
            style: TextStyle(
              color: BlaColors.textNormal,
            ),
            decoration: InputDecoration(
              hintText: 'Sation Road or The Bridge Cafe',
              border: InputBorder.none,
              filled: false,
            ),
          )),
          if (inputIsNotEmpty)
            IconButton(
                onPressed: onClear,
                icon: Icon(Icons.close_rounded, color: BlaColors.iconNormal))
        ],
      ),
    );
  }

  Widget baseTile(BuildContext context,
      {required Location location, required void Function() onTap}) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: BlaSpacings.m),
        child: Row(
          children: [
            if (leftIcon != null)
              Icon(
                leftIcon,
                color: BlaColors.neutral,
              ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            )),
            Icon(
              Icons.arrow_forward_rounded,
              color: BlaColors.neutral,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        searchBarInput(context),
        if (locationResults.isNotEmpty)
          SizedBox(
            height: 500,
            child: ListView.builder(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: locationResults.length,
              itemBuilder: (ctx, index) => baseTile(
                context,
                location: locationResults[index],
                onTap: () => onLocationTap(locationResults[index]),
              ),
            ),
          ),
      ],
    );
  }
}
