import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:nike_app/components/custom_dashed.dart';
import 'package:nike_app/components/geolocator.dart';
import 'package:nike_app/components/my_button.dart';
import 'package:nike_app/providers/shoe_provider.dart';

Future<LatLng> fetchLocation() async {
  final location = await getLocation();
  return LatLng(location.latitude, location.longitude);
}

class MapExample extends StatefulWidget {
  const MapExample({Key? key}) : super(key: key);

  @override
  _MapExampleState createState() => _MapExampleState();
}

class _MapExampleState extends State<MapExample> {
  LatLng? currentLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      LatLng location = await fetchLocation();
      setState(() {
        currentLocation = location;
      });
    } catch (e) {
      print('Error fetching location: $e');
    }
  }

  print(currentLocation) {
    // TODO: implement print
    throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Stack(
                  children: [
                    FlutterMap(
                      options: MapOptions(
                        initialCenter: currentLocation ?? LatLng(0, 0),
                        initialZoom: 12.0,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: currentLocation!,
                              width: 160.0,
                              height: 160.0,
                              child: Container(
                                child: const Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                  size: 40,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Center(
                      child: Text(
                        'View Map',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class CheckoutPage extends ConsumerWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    final cartShoes = ref.watch(popularCartProvider);
    print(cartShoes);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
          backgroundColor: Colors.grey[100],
          leading: Container(
            height: 50,
            width: 50,
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          title: Center(
            child: Text("Checkout"),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Contact Information',
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                  color: Color(0xffF8F9FA),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Icon(Icons.mail_outline),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "emmanueloyiboke@gmail.com",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: widthScreen * 0.03),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("Email",
                                    style: TextStyle(
                                        color: Color(0xFF707B81),
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          ],
                        ),
                        Icon(Icons.edit)
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                  color: Color(0xffF8F9FA),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Icon(Icons.phone),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "+234-811-732-5298",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("Phone",
                                    style: TextStyle(
                                        color: Color(0xFF707B81),
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          ],
                        ),
                        Icon(Icons.edit)
                      ],
                    ),
                    SizedBox(
                      height: 200,
                      child: MapExample(),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subtotal',
                        style: TextStyle(fontSize: 18, color: Colors.grey[500]),
                      ),
                      Text(
                        '\$${cartShoes.fold(0.0, (previousValue, element) => previousValue + element.price * element.quantity!).toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery',
                        style: TextStyle(fontSize: 18, color: Colors.grey[500]),
                      ),
                      Text(
                        '\$10',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomDashed(
                    height: 2,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total cost',
                        style: TextStyle(fontSize: 18, color: Colors.grey[500]),
                      ),
                      Text(
                        '\$${cartShoes.fold(0.0, (previousValue, element) => previousValue + element.price * element.quantity!).toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  MyButton(
                      text: Text(
                        "Checkout",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      onTap: () {
                        ref
                            .read(popularNotificationProvider.notifier)
                            .addNotifications(cartShoes);
                        ref.read(popularCartProvider.notifier).clearCart();

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/calebrate.png"),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Your payment is successful",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  MyButton(
                                    text: Text(
                                      "Back to shopping",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
