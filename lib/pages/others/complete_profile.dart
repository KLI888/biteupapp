// Add these dependencies to pubspec.yaml:
// geolocator: ^10.1.0
// geocoding: ^2.1.1

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class DeliveryAddressScreen extends StatefulWidget {
  @override
  _DeliveryAddressScreenState createState() => _DeliveryAddressScreenState();
}

class _DeliveryAddressScreenState extends State<DeliveryAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _showAltPhone = false;
  bool _showLandmark = false;
  String _selectedAddressType = 'Home';

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _altPhoneController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _building1Controller = TextEditingController();
  TextEditingController _building2Controller = TextEditingController();
  TextEditingController _landmarkController = TextEditingController();

  Future<void> _getCurrentLocation() async {
    try {
      // Request location permission
      LocationPermission permission = await Geolocator.requestPermission();
      
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location permission denied')),
        );
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Get address from coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          _pincodeController.text = place.postalCode ?? '';
          _stateController.text = place.administrativeArea ?? '';
          _cityController.text = place.locality ?? '';
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error getting location: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Color(0xFFE91E63),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add delivery address',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter Name*',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter name' : null,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Phone Number*',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter phone number' : null,
                ),
                SizedBox(height: 8),

                if (!_showAltPhone)
                  TextButton.icon(
                    icon: Icon(Icons.add, color: Color(0xFFE91E63)),
                    label: Text(
                      'Add alternate phone number',
                      style: TextStyle(color: Color(0xFFE91E63)),
                    ),
                    onPressed: () => setState(() => _showAltPhone = true),
                  ),

                if (_showAltPhone) ...[
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _altPhoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Alternate Phone Number',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ],

                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _pincodeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Pincode*',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'Please enter pincode' : null,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.location_on),
                        label: Text('Use my Location'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Color(0xFFE91E63),
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: _getCurrentLocation,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _stateController,
                        decoration: InputDecoration(
                          hintText: 'State*',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'Please enter state' : null,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _cityController,
                        decoration: InputDecoration(
                          hintText: 'City*',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'Please enter city' : null,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),
                TextFormField(
                  controller: _building1Controller,
                  decoration: InputDecoration(
                    hintText: 'House No., Building Name*',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter building details' : null,
                ),

                SizedBox(height: 16),
                TextFormField(
                  controller: _building2Controller,
                  decoration: InputDecoration(
                    hintText: 'Road name, Area, Colony',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),

                if (!_showLandmark)
                  TextButton.icon(
                    icon: Icon(Icons.add, color: Color(0xFFE91E63)),
                    label: Text(
                      'Add nearby famous Shop/Mall/Landmark',
                      style: TextStyle(color: Color(0xFFE91E63)),
                    ),
                    onPressed: () => setState(() => _showLandmark = true),
                  ),

                if (_showLandmark) ...[
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _landmarkController,
                    decoration: InputDecoration(
                      hintText: 'Landmark',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ],

                SizedBox(height: 16),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Home',
                      groupValue: _selectedAddressType,
                      onChanged: (value) =>
                          setState(() => _selectedAddressType = value!),
                      activeColor: Color(0xFFE91E63),
                    ),
                    Text('Home'),
                    SizedBox(width: 16),
                    Radio<String>(
                      value: 'Office',
                      groupValue: _selectedAddressType,
                      onChanged: (value) =>
                          setState(() => _selectedAddressType = value!),
                      activeColor: Color(0xFFE91E63),
                    ),
                    Text('Office'),
                  ],
                ),

                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text(
                      'Save Address',
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color(0xFFE91E63),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // Handle form submission
                        // You can access all the form data through the controllers
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _altPhoneController.dispose();
    _pincodeController.dispose();
    _stateController.dispose();
    _cityController.dispose();
    _building1Controller.dispose();
    _building2Controller.dispose();
    _landmarkController.dispose();
    super.dispose();
  }
}