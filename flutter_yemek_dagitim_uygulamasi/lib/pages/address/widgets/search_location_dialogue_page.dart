import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/controllers/location_controller.dart';
import 'package:flutter_yemek_dagitim_uygulamasi/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/src/places.dart';

class LocationDialogue extends StatelessWidget {
  final GoogleMapController mapController;
  const LocationDialogue({super.key, required this.mapController});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    return Container(
      padding: EdgeInsets.all(Boyutlar.width10),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Boyutlar.radius20 / 2),
        ),
        child: SizedBox(
          width: Boyutlar.screenWidth,
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              controller: _controller,
              textInputAction: TextInputAction.search,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecoration(
                hintText: 'search location',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    style: BorderStyle.none,
                    width: 0,
                  ),
                ),
                hintStyle: Theme.of(context).textTheme.headline2?.copyWith(
                      color: Theme.of(context).disabledColor,
                      fontSize: Boyutlar.font16,
                    ),
              ),
            ),
            onSuggestionSelected: (Prediction suggestion) {
              Get.find<LocationController>().setLocation(suggestion.placeId!, suggestion.description!, mapController);
              Get.back();
            },
            suggestionsCallback: (String pattern) async {
              return await Get.find<LocationController>().searchLocation(context, pattern);
            },
            itemBuilder: (context, Prediction suggestion) {
              return Padding(
                padding: EdgeInsets.all(Boyutlar.width10),
                child: Row(
                  children: [
                    Icon(Icons.location_on),
                    Expanded(
                      child: Text(
                        suggestion.description!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline2?.copyWith(
                              color: Theme.of(context).textTheme.bodyText1?.color,
                              fontSize: Boyutlar.font16,
                            ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
