import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:readytogo/Constants/constants.dart';
import '../widgets/boxDecorationWidget.dart';
import '../widgets/customscfaffold_widget.dart';
import 'filters_search_screen.dart';

class FindProvidersScreen extends StatefulWidget {
  const FindProvidersScreen({super.key});

  @override
  State<FindProvidersScreen> createState() => _FindProvidersScreenState();
}

class _FindProvidersScreenState extends State<FindProvidersScreen> {
  final TextEditingController _searchController = TextEditingController();

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(38.7946, -106.5348), // Centered over USA region
    zoom: 3.5,
  );

  late GoogleMapController _mapController;
  late Future<void> _delayedMapLoad;

  Set<Marker> _markers = {};
  BitmapDescriptor? _customMarkerIcon;

  // Track if info window visible and which marker is selected
  bool _showInfoWindow = false;
  LatLng? _selectedMarkerPosition;

  @override
  void initState() {
    super.initState();
    _delayedMapLoad = Future.delayed(const Duration(milliseconds: 100));
    _loadCustomMarker();
  }

  Future<void> _loadCustomMarker() async {
    final BitmapDescriptor bitmapDescriptor =
        await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 5.5, size: Size(10.0, 10.0)),
      'assets/pointer.png',
    );

    setState(() {
      _customMarkerIcon = bitmapDescriptor;
      _markers = _createMarkers();
    });
  }

  Set<Marker> _createMarkers() {
    final List<LatLng> locations = [
      LatLng(40.7128, -74.0060), // New York
      LatLng(34.0522, -118.2437), // Los Angeles
      LatLng(41.8781, -87.6298), // Chicago
      LatLng(29.7604, -95.3698), // Houston
      LatLng(33.4484, -112.0740), // Phoenix
      LatLng(39.7392, -104.9903), // Denver
      LatLng(47.6062, -122.3321), // Seattle
      LatLng(38.9072, -77.0369), // Washington, D.C.
      LatLng(25.7617, -80.1918), // Miami
      LatLng(44.9778, -93.2650), // Minneapolis
      LatLng(32.7767, -96.7970), // Dallas
      LatLng(37.7749, -122.4194), // San Francisco
    ];

    return locations.asMap().entries.map((entry) {
      int idx = entry.key;
      LatLng pos = entry.value;
      return Marker(
        markerId: MarkerId('marker_$idx'),
        position: pos,
        icon: _customMarkerIcon ?? BitmapDescriptor.defaultMarker,
        onTap: () {
          setState(() {
            _selectedMarkerPosition = pos;
            _showInfoWindow = true;
          });
        },
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      isDrawerRequired: true,
      appbartitle: 'Find Providers',
      body: DecoratedBox(
        decoration: boxDecoration(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueGrey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'search...',
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1.5),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          children: [
                            Container(
                              height: 44,
                              width: 44,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Image.asset("assets/search.png"),
                            ),
                            const SizedBox(height: 8),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => Padding(
                                    padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom,
                                    ),
                                    child: FilterBottomSheet(),
                                  ),
                                );
                              },
                              child: Container(
                                height: 44,
                                width: 44,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                ),
                                child: Image.asset("assets/Filters.png"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: FutureBuilder(
                      future: _delayedMapLoad,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: GoogleMap(
                            mapType: MapType.normal,
                            initialCameraPosition: _initialCameraPosition,
                            myLocationButtonEnabled: false,
                            zoomControlsEnabled: false,
                            markers: _markers,
                            onMapCreated: (controller) {
                              _mapController = controller;
                              _mapController.setMapStyle(Constants.mapStyle);
                            },
                            onTap: (_) {
                              setState(() {
                                _showInfoWindow = false;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),

                  // Show custom info window only if visible and selected marker is set
                  if (_showInfoWindow && _selectedMarkerPosition != null)
                    Positioned(
                      bottom: 40, // adjust based on your UI needs
                      left: 16,
                      right: 16,
                      child: _buildCustomInfoWindow(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomInfoWindow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Check if the screen width is smaller (e.g., mobile)
        bool isMobile = constraints.maxWidth < 600;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Circular profile picture with border
                  Container(
                    height: 56,
                    width: 56,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        "https://images.unsplash.com/photo-1537368910025-700350fe46c7?auto=format&fit=crop&w=64&q=80",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Text info column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Dr. Faizan (Nutritionist)',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '+0594 56249 5894',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 19),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Phone call icon in rounded background
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.phone, color: Colors.blue),
                      onPressed: () {
                        // Implement call functionality here
                      },
                    ),
                  ),
                ],
              ),
              // Conditional layout for responsiveness
              isMobile
                  ? Column(
                      children: [
                        _infoRow(),
                        const SizedBox(height: 16),
                        // Removed extra _infoRow to avoid repetition
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _infoColumn('Location',
                            'Distance 3.2 km'), // Removed 'Pediatrician'
                        _separator(),
                        _infoColumn('Member', 'Since July 15th'),
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }

  Widget _infoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade400,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            color: Colors.blue,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _infoRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _infoColumn('Service', 'Pediatrician'),
        _separator(),
        _infoColumn('Location', 'Distance 3.2 km'),
        _separator(),
        _infoColumn('Member', 'Since July 15th'),
      ],
    );
  }

  Widget _separator() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.grey,
    );
  }

  /* Widget _buildCustomInfoWindow() {
    return Container(
      height: 140,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Circular profile picture with border
              Container(
                height: 56,
                width: 56,
                // decoration: BoxDecoration(
                //   color: Colors.blue.shade50,
                //   borderRadius: BorderRadius.circular(22),
                // ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    "https://images.unsplash.com/photo-1537368910025-700350fe46c7?auto=format&fit=crop&w=64&q=80",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              /* Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade300, width: 1.5),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    "https://images.unsplash.com/photo-1537368910025-700350fe46c7?auto=format&fit=crop&w=64&q=80",
                    fit: BoxFit.cover,
                  ),
                ),
              ),*/
              const SizedBox(width: 16),
              // Text info column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Dr. Faizan (Nutritionist)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '+0594 56249 5894',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 19),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     _infoColumn('Service', 'Pediatrician'),
                    //     _infoColumn('Location', 'Distance 3.2 km'),
                    //     _infoColumn('Member', 'Since July 15th'),
                    //   ],
                    // ),
                    // _infoColumn('Location', 'Distance 3.2 km'),
                    // _infoColumn('Member', 'Since July 15th'),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Phone call icon in rounded background
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.phone, color: Colors.blue),
                  onPressed: () {
                    // Implement call functionality here
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _infoColumn('Service', 'Pediatrician'),
              Container(
                height: 40, // Height of the separator
                width: 1, // Width of the separator (you can adjust it)
                color: Colors.grey, // Color of the separator
              ),
              // SizedBox(
              //   width: 7,
              // ),
              _infoColumn('Location', 'Distance 3.2 km'),
              Container(
                height: 40, // Height of the separator
                width: 1, // Width of the separator (you can adjust it)
                color: Colors.grey, // Color of the separator
              ),
              // SizedBox(
              //   width: 7,
              // ),
              _infoColumn('Member', 'Since July 15th'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade400,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            color: Colors.blue,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }*/
}


/*class FindProvidersScreen extends StatefulWidget {
  const FindProvidersScreen({super.key});

  @override
  State<FindProvidersScreen> createState() => _FindProvidersScreenState();
}

class _FindProvidersScreenState extends State<FindProvidersScreen> {
  final TextEditingController _searchController = TextEditingController();

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(38.7946, -106.5348), // Centered over USA region
    zoom: 3.5,
  );

  late GoogleMapController _mapController;
  late Future<void> _delayedMapLoad;

  Set<Marker> _markers = {};
  BitmapDescriptor? _customMarkerIcon;

  @override
  void initState() {
    super.initState();
    _delayedMapLoad = Future.delayed(const Duration(milliseconds: 100));
    _loadCustomMarker();
  }

  Future<void> _loadCustomMarker() async {
    final BitmapDescriptor bitmapDescriptor =
        await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 5.5, size: Size(10.0, 10.0)),
      'assets/pointer.png',
    );

    setState(() {
      _customMarkerIcon = bitmapDescriptor;
      _markers = _createMarkers();
    });
  }

  Set<Marker> _createMarkers() {
    final List<LatLng> locations = [
      LatLng(40.7128, -74.0060), // New York
      LatLng(34.0522, -118.2437), // Los Angeles
      LatLng(41.8781, -87.6298), // Chicago
      LatLng(29.7604, -95.3698), // Houston
      LatLng(33.4484, -112.0740), // Phoenix
      LatLng(39.7392, -104.9903), // Denver
      LatLng(47.6062, -122.3321), // Seattle
      LatLng(38.9072, -77.0369), // Washington, D.C.
      LatLng(25.7617, -80.1918), // Miami
      LatLng(44.9778, -93.2650), // Minneapolis
      LatLng(32.7767, -96.7970), // Dallas
      LatLng(37.7749, -122.4194), // San Francisco
    ];

    return locations.asMap().entries.map((entry) {
      int idx = entry.key;
      LatLng pos = entry.value;
      return Marker(
        markerId: MarkerId('marker_$idx'),
        position: pos,
        icon: _customMarkerIcon ?? BitmapDescriptor.defaultMarker,
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      isDrawerRequired: true,
      appbartitle: 'Find Providers',
      body: DecoratedBox(
        decoration: boxDecoration(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueGrey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'search...',
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1.5),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          children: [
                            Container(
                              height: 44,
                              width: 44,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Image.asset("assets/search.png"),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 44,
                              width: 44,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Image.asset("assets/Filters.png"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                clipBehavior: Clip.hardEdge,
                child: FutureBuilder(
                  future: _delayedMapLoad,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: GoogleMap(
                        mapType: MapType.terrain,
                        initialCameraPosition: _initialCameraPosition,
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: false,
                        markers: _markers,
                        onMapCreated: (controller) {
                          _mapController = controller;
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/


/*class FindProvidersScreen extends StatefulWidget {
  const FindProvidersScreen({super.key});

  @override
  State<FindProvidersScreen> createState() => _FindProvidersScreenState();
}

class _FindProvidersScreenState extends State<FindProvidersScreen> {
  final TextEditingController _searchController = TextEditingController();

  int _selectedIndex = 2; // Search tab selected

  // Initial map position (Example: Sacramento, CA)
  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(38.7946, 106.5348),
    zoom: 2.5,
  );

  late GoogleMapController _mapController;
  late Future<void> _delayedMapLoad;

  @override
  void initState() {
    super.initState();
    // Delay to safely load GoogleMap after hot restart
    _delayedMapLoad = Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
        isDrawerRequired: true,
        appbartitle: 'Find Providers',
        body: DecoratedBox(
          decoration: boxDecoration(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // TextField expands to take available space
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'search...',
                                hintStyle: TextStyle(color: Colors.grey[500]),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 1.5),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 10),

                          // Search + Filter Column
                          Column(
                            children: [
                              Container(
                                height: 44,
                                width: 44,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                ),
                                child: Image.asset("assets/search.png"),
                              ),
                              const SizedBox(
                                  height:
                                      8), // spacing between search and filter
                              Container(
                                height: 44,
                                width: 44,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                ),
                                child: Image.asset("assets/Filters.png"),
                              ),
                            ],
                          ),
                        ],
                      ),

                      /*  Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'search...',
                                hintStyle: TextStyle(color: Colors.grey[500]),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 1.5),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                              height: 44,
                              width: 44,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Image.asset("assets/search.png")
                              //Icon(Icons.search, color: Colors.grey[700]),
                              ),
                          const SizedBox(width: 10),
                        ],
                      ),*/
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 295.0),
                      //   child: Container(
                      //       height: 44,
                      //       width: 44,
                      //       decoration: BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         border: Border.all(color: Colors.grey.shade300),
                      //       ),
                      //       child: Image.asset("assets/Filters.png")),
                      // ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Container(
                  // height: MediaQuery.of(context).size.height,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: FutureBuilder(
                    future: _delayedMapLoad,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: GoogleMap(
                          initialCameraPosition: _initialCameraPosition,
                          myLocationButtonEnabled: false,
                          zoomControlsEnabled: false,
                          onMapCreated: (controller) {
                            _mapController = controller;
                          },
                        ),
                      );
                    },
                  ),
                  // GoogleMap(
                  //   initialCameraPosition: _initialCameraPosition,
                  //   myLocationButtonEnabled: false,
                  //   zoomControlsEnabled: false,
                  //   onMapCreated: (controller) {
                  //     _mapController = controller;
                  //   },
                  // ),
                ),
              ),
            ],
          ),
        ));
  }
}
*/