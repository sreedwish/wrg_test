// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:white_rabbit_sreedwish/models/address.dart';
import 'package:latlong2/latlong.dart';
import 'package:white_rabbit_sreedwish/uiResource/colors.dart';
import 'package:white_rabbit_sreedwish/uiResource/styles.dart';
import 'package:white_rabbit_sreedwish/utils/logger.dart';

class MapWidget extends StatefulWidget {
  final Address address;

  const MapWidget({Key? key, required this.address}) : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final MapController _mapController = MapController();
  final double mapMaxZoom = 22;
  final double mapMinZoom = 1;
  final String mapTile = 'http://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}';
  final List<String> subDomain = ['mt0', 'mt1', 'mt2', 'mt3'];

  LatLng pos = LatLng(0, 0);
  final List<Marker> markers = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: MediaQuery.of(context).size.width,
      decoration: ShapeDecoration(
        color: const Color(colorPrimary),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: const BorderSide(color: Colors.black, width: 2)),
      ),
      child: flutterMap(),
    );
  }

  Widget flutterMap() {
    markers.clear();
    markers.add(_marker());
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        controller: _mapController,
        maxZoom: mapMaxZoom,
        minZoom: mapMinZoom,
        allowPanning: false,
        interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
        center: pos,
        zoom: 4.0,
        onTap: (_) {
          double zoom = _mapController.zoom + 1;
          _mapController.move(pos, zoom);
        },
      ),
      layers: [
        TileLayerOptions(urlTemplate: mapTile, subdomains: subDomain),
        MarkerLayerOptions(markers: markers)
      ],
    );
  }

  Marker _marker() {
    Address address = widget.address;

    String name = address.city ?? '';

    double lat = double.parse(address.geo!.lat!);
    double lng = double.parse(address.geo!.lng!);

    setState(() {
      pos = LatLng(lat, lng);
    });

    Logger.printMsg(pos.toString());

    return Marker(
      point: pos,
      width: 140,
      height: 82,
      anchorPos: AnchorPos.align(AnchorAlign.top),
      builder: (ctx) => GestureDetector(
        onTap: () {},
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: ShapeDecoration(
                color: const Color(colorPrimary),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              child: FittedBox(
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  softWrap: true,
                  style: bodyText.copyWith(color: Colors.white),
                ),
              ),
            ),
            const Icon(
              Icons.location_on,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
