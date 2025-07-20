import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:readytogo/Constants/constants.dart';
import '../Model/filter_search_model.dart';
import '../Model/professional_profile_model.dart';
import '../Model/search_model.dart';
import '../Repositories/login_repository.dart';
import '../widgets/boxDecorationWidget.dart';
import '../widgets/customscfaffold_widget.dart';
import 'filters_search_screen.dart';
import 'login/bloc/login_event.dart';
import 'package:readytogo/Features/login/bloc/login_bloc.dart';

import 'login/bloc/login_state.dart';

// Assume imports are already handled

class FindProvidersScreen extends StatefulWidget {
  const FindProvidersScreen({super.key});

  @override
  State<FindProvidersScreen> createState() => _FindProvidersScreenState();
}

class _FindProvidersScreenState extends State<FindProvidersScreen> {
  final TextEditingController _searchController = TextEditingController();

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(38.7946, -106.5348),
    zoom: 1.5,
  );

  late GoogleMapController _mapController;
  late Future<void> _delayedMapLoad;
  Set<Marker> _markers = {};
  BitmapDescriptor? _customMarkerIcon;

  SearchModel? _selectedProvider;
  FilterSearchModel? _selectedFilterProvider;
  Location? _selectedFilterLocation;

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
    });
  }

  void _updateMarkers(List<SearchModel> searchResults) {
    final Set<Marker> newMarkers = {};

    for (int i = 0; i < searchResults.length; i++) {
      final model = searchResults[i];
      if (model.locations.isNotEmpty) {
        final location = model.locations.first;
        final LatLng position =
            LatLng(location.latitude ?? 0.0, location.longitude ?? 0.0);

        newMarkers.add(Marker(
          markerId: MarkerId('marker_$i'),
          position: position,
          icon: _customMarkerIcon ?? BitmapDescriptor.defaultMarker,
          onTap: () {
            setState(() {
              _selectedMarkerPosition = position;
              _selectedProvider = model;
              _selectedFilterProvider = null;
              _showInfoWindow = true;
            });
          },
        ));
      }
    }

    setState(() {
      _markers = newMarkers;
    });
  }

  void _updateMarkersFilters(List<FilterSearchModel> filteredProviders) {
    final Set<Marker> newMarkers = {};

    for (int i = 0; i < filteredProviders.length; i++) {
      final provider = filteredProviders[i];
      for (int j = 0; j < provider.locations.length; j++) {
        final location = provider.locations[j];
        final latitude = location.latitude;
        final longitude = location.longitude;

        if (latitude != null && longitude != null) {
          final marker = Marker(
            markerId:
                MarkerId('filter_marker_${provider.userId}_${location.id}'),
            position: LatLng(latitude, longitude),
            icon: _customMarkerIcon ?? BitmapDescriptor.defaultMarker,
            onTap: () {
              setState(() {
                _selectedMarkerPosition = LatLng(latitude, longitude);
                _selectedFilterProvider = provider;
                _selectedProvider = null;
                _selectedFilterLocation = location;
                _showInfoWindow = true;
              });
            },
          );

          newMarkers.add(marker);
        }
      }
    }

    setState(() {
      _markers = newMarkers;
    });
  } //10@Testing

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (prev, curr) =>
          prev.searchStatus != curr.searchStatus ||
          prev.filterSearchStatus != curr.filterSearchStatus,
      listener: (context, state) {
        if (state.searchStatus == SearchStatus.searchSuccess &&
            state.searchResults != null) {
          _updateMarkers(state.searchResults!);
        } else if (state.filterSearchStatus ==
                FilterSearchStatus.filtersearchSuccess &&
            state.filterSearchResults != null) {
          _updateMarkersFilters(state.filterSearchResults!);
        }
      },
      child: CustomScaffoldWidget(
        showNotificationIcon: false,
        isDrawerRequired: true,
        appbartitle: 'Find Providers',
        body: DecoratedBox(
          decoration: boxDecoration(),
          child: Column(
            children: [
              _buildSearchBar(context),
              const SizedBox(height: 10),
              Expanded(child: _buildMapView()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
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
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 1.5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        final services = _searchController.text;
                        if (services.isNotEmpty) {
                          setState(() {
                            _selectedFilterProvider == null;
                          });
                          context
                              .read<LoginBloc>()
                              .add(SearchFunctionality(services: services));
                        }
                      },
                      child: _circleButton("assets/search.png"),
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
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: FilterBottomSheet(),
                          ),
                        );
                      },
                      child: _circleButton("assets/Filters.png"),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleButton(String assetPath) {
    return Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Image.asset(assetPath),
    );
  }

  Widget _buildMapView() {
    return Stack(
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
                return const Center(child: CircularProgressIndicator());
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
                    setState(() => _showInfoWindow = false);
                  },
                ),
              );
            },
          ),
        ),
        if (_showInfoWindow && _selectedMarkerPosition != null)
          Positioned(
            bottom: 40,
            left: 16,
            right: 16,
            child: _selectedProvider != null
                ? _buildCustomInfoWindow(_selectedProvider!)
                : _buildCustomInfoWindowFilters(
                    _selectedFilterProvider!), // Optional: Add filter info window
          ),
      ],
    );
  }

  /* Widget _buildCustomInfoWindow(SearchModel model) {
    final String imageUrl = model.profileImageUrl != null
        ? 'http://173.249.27.4:343/${model.profileImageUrl}'
        : 'https://static.vecteezy.com/system/resources/thumbnails/005/544/718/small_2x/profile-icon-design-free-vector.jpg';

    final String fullName =
        '${model.firstName ?? ''} ${model.lastName ?? ''}'.trim();
    final String phone = model.phoneNumber ?? 'N/A';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(imageUrl,
                height: 56, width: 56, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(fullName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                Text(phone,
                    style:
                        TextStyle(fontSize: 14, color: Colors.grey.shade600)),
                const SizedBox(height: 4),
                Text("Distance: ${model.distanceKm} km"),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.phone, color: Colors.blue),
            onPressed: () {}, // Add call functionality
          ),
        ],
      ),
    );
  }*/

  Widget _buildCustomInfoWindowFilters(FilterSearchModel model) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;

        final String imageUrl = model.profileImageUrl != null
            ? 'http://173.249.27.4:343/${model.profileImageUrl}'
            : 'https://static.vecteezy.com/system/resources/thumbnails/005/544/718/small_2x/profile-icon-design-free-vector.jpg'; // fallback image

        final String fullName =
            '${model.firstName ?? ''} ${model.lastName ?? ''}'.trim();

        final String phone = model.phoneNumber ?? 'N/A';

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
                  // Profile image
                  Container(
                    height: 56,
                    width: 56,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.person),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Name and phone
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fullName.isNotEmpty ? fullName : 'N/A',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          phone,
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
                  // Call button
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.phone, color: Colors.blue),
                      onPressed: () {
                        // Add phone call functionality if needed
                      },
                    ),
                  ),
                ],
              ),
              // Responsive layout
              isMobile
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _infoColumn('Service', 'Pediatrician'),
                            _separator(),
                            _infoColumn('Location', 'Distance 3.2 km'),
                            _separator(),
                            _infoColumn('Member', 'Since July 15th'),
                          ],
                        ),
                        //  _infoRow(), // You can update _infoRow if needed
                        const SizedBox(height: 16),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _infoColumn(
                            'Location', 'Distance ${model.distanceKm} km'),
                        _separator(),
                        _infoColumn('Member', 'Sinc ${model.memberSince}'),
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }

  /* Widget _buildCustomInfoWindowFilters(FilterSearchModel model) {
    final String imageUrl = model.profileImageUrl != null
        ? 'http://173.249.27.4:343/${model.profileImageUrl}'
        : 'https://static.vecteezy.com/system/resources/thumbnails/005/544/718/small_2x/profile-icon-design-free-vector.jpg';

    final String fullName =
        '${model.firstName ?? ''} ${model.lastName ?? ''}'.trim();
    final String phone = model.phoneNumber ?? 'N/A';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(imageUrl,
                height: 56, width: 56, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(fullName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                Text(phone,
                    style:
                        TextStyle(fontSize: 14, color: Colors.grey.shade600)),
                const SizedBox(height: 4),
                Text("Distance: ${model.distanceKm} km"),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.phone, color: Colors.blue),
            onPressed: () {}, // Add call functionality
          ),
        ],
      ),
    );
  }*/

  Widget _buildCustomInfoWindow(SearchModel model) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;

        final String imageUrl = model.profileImageUrl != null
            ? 'http://173.249.27.4:343/${model.profileImageUrl}'
            : 'https://via.placeholder.com/64'; // fallback image

        final String fullName =
            '${model.firstName ?? ''} ${model.lastName ?? ''}'.trim();

        final String phone = model.phoneNumber ?? 'N/A';

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
                  // Profile image
                  Container(
                    height: 56,
                    width: 56,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.person),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Name and phone
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fullName.isNotEmpty ? fullName : 'N/A',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          phone,
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
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon:  Icon(Icons.favorite_border_outlined, color: Colors.blue),
                      onPressed: () {
                        setState(() {
  model.add(newItem);
});
                      },
                    ),
                  ),
                  // Call button
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.phone, color: Colors.blue),
                      onPressed: () {
                        // Add phone call functionality if needed
                      },
                    ),
                  ),
                ],
              ),
              // Responsive layout
              isMobile
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _infoColumn('Service', 'Pediatrician'),
                            _separator(),
                            _infoColumn('Location', 'Distance 3.2 km'),
                            _separator(),
                            _infoColumn('Member', 'Since July 15th'),
                          ],
                        ),
                        //  _infoRow(), // You can update _infoRow if needed
                        const SizedBox(height: 16),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _infoColumn(
                            'Location', 'Distance ${model.distanceKm} km'),
                        _separator(),
                        _infoColumn('Member', 'Sinc ${model.memberSince}'),
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }

  /* Widget _buildCustomInfoWindow() {
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
  }*/

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
}
