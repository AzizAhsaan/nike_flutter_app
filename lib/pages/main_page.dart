import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nike_app/auth/auth_service.dart';
import 'package:nike_app/components/home_searchbar.dart';
import 'package:nike_app/pages/cart_page.dart';
import 'package:nike_app/pages/favorite_page.dart';
import 'package:nike_app/pages/notification_page.dart';
import 'package:nike_app/providers/shoe_provider.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = ref.watch(pageIndexProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final filteredShoes = ref.watch(filteredShoesProvider);
    final cartNotifier = ref.watch(popularCartProvider.notifier);
    final errorMessage = ref.watch(cartErrorProvider);
    final cartItemCount = ref.watch(cartItemCountProvider);
    final containerSize =
        ref.watch(cartItemCountProvider).toString().length >= 3 ? 30.0 : 25.0;
    if (errorMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showErrorDialog(context, errorMessage);
        ref.read(cartErrorProvider.notifier).state =
            null; // Clear the error after showing dialog
      });
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 242),
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Nike App',
            style: TextStyle(color: Colors.black, fontSize: 28),
          ),
        ),
        backgroundColor: Colors.grey[100],
        iconTheme: const IconThemeData(color: Colors.black, size: 36),
        actions: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.shopping_bag_rounded,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CartPage()));
                  },
                ),
              ),
              Positioned(
                left: cartItemCount.toString().length > 3 ? -20 : -12,
                top: -1,
                child: Container(
                  height: containerSize,
                  width: containerSize,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(child: Text(cartItemCount.toString())),
                ),
              )
            ],
          )
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF0D6EFD),
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(),
              child: Text(
                "Nike App",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(onPressed: () {}, child: const Text('Logout'))
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.home,
                color: pageIndex == 0 ? Colors.blue : Colors.grey,
              ),
              onPressed: () {
                ref.read(pageIndexProvider.notifier).state = 0;
              },
            ),
            IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: pageIndex == 1 ? Colors.blue : Colors.grey,
              ),
              onPressed: () {
                ref.read(pageIndexProvider.notifier).state = 1;
              },
            ),
            const SizedBox(width: 48), // Space for the floating action button
            IconButton(
              icon: Icon(
                Icons.notifications_none,
                color: pageIndex == 2 ? Colors.blue : Colors.grey,
              ),
              onPressed: () {
                ref.read(pageIndexProvider.notifier).state = 2;
              },
            ),
            IconButton(
              icon: Icon(
                Icons.person_outline,
                color: pageIndex == 3 ? Colors.blue : Colors.grey,
              ),
              onPressed: () {
                ref.read(pageIndexProvider.notifier).state = 3;
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CartPage()));
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.shopping_bag, color: Colors.white),
      ),
      body: IndexedStack(
        index: pageIndex,
        children: [
          _buildHomePage(ref, selectedCategory, filteredShoes, context),
          FavoritePage(),
          NotificationPage(),
        ],
      ),
    );
  }

  Widget _buildHomePage(WidgetRef ref, String selectedCategory,
      List<Shoe> filteredShoes, BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            HomeSearchbar(),
            const SizedBox(
              height: 20,
            ),
            _buildCategorySelector(ref, selectedCategory),
            const SizedBox(height: 20),
            _buildPopularShoesHeader(),
            const SizedBox(height: 20),
            _buildPopularShoesList(filteredShoes, ref),
            _buildNewArraivalsHeader(),
            _buildArrivalBanner(context),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

Widget _buildArrivalBanner(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      width: double.infinity,
      height: 120,
      margin: EdgeInsets.symmetric(horizontal: 2, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Summer Sale',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.black)),
                    const SizedBox(
                      height: 2,
                    ),
                    Text('50% OFF',
                        style: TextStyle(
                            fontSize: screenWidth * 0.1,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF674DC5))),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
          Positioned(
            right: 20,
            bottom: 34,
            child: Image.asset(
              'assets/images/NikeLogo3.png',
              height: 130,
              width: 160,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
              bottom: 10,
              left: 10,
              child: Image.asset(
                'assets/images/star.png',
                height: 30,
                width: 30,
                fit: BoxFit.cover,
              )),
          Positioned(
              top: 10,
              right: 140,
              child: Image.asset(
                'assets/images/Group.png',
                height: 30,
                width: 30,
                fit: BoxFit.cover,
              )),
          Positioned(
              top: 10,
              right: 10,
              child: Image.asset(
                'assets/images/star.png',
                height: 30,
                width: 30,
                fit: BoxFit.cover,
              )),
        ],
      ),
    ),
  );
}

Widget _buildNewArraivalsHeader() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('New Arrivals',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text('See all', style: TextStyle(color: Colors.blue)),
      ],
    ),
  );
}

Widget _buildCategorySelector(WidgetRef ref, String selectedCategory) {
  final categories = ['All Shoes', 'Outdoor', 'Tennis'];
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: categories.map((category) {
      final isSelected = selectedCategory == category;
      return GestureDetector(
        onTap: () {
          ref.read(selectedCategoryProvider.notifier).state = category;
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            category,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }).toList(),
  );
}

Widget _buildPopularShoesHeader() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Popular Shoes',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text('See all', style: TextStyle(color: Colors.blue)),
      ],
    ),
  );
}

Widget _buildPopularShoesList(List<Shoe> shoes, WidgetRef ref) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Container(
      height: 330,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.66,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: shoes.length,
        itemBuilder: (context, index) {
          final shoe = shoes[index];
          return Stack(children: [
            Card(
              clipBehavior: Clip.antiAlias,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        color: shoe.isFavorite ? Colors.red : Colors.black,
                        icon: Icon(
                          shoe.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                        ),
                        onPressed: () {
                          ref
                              .read(popularShoesProvider.notifier)
                              .toggleFavorite(shoe);
                        },
                      ),
                    ),
                    Center(
                      child: Image.asset(
                        shoe.imageUrl,
                        fit: BoxFit.cover,
                        height: 90,
                        width: 140,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'BEST SELLER',
                      style: TextStyle(color: Colors.blue, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      shoe.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${shoe.price.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 4,
              bottom: 4,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: IconButton(
                  icon: const Icon(Icons.add, color: Colors.white),
                  onPressed: () {
                    ref.read(popularCartProvider.notifier).addToCart(shoe);

                    // Add to cart or perform action
                  },
                ),
              ),
            ),
          ]);
        },
      ),
    ),
  );
}
