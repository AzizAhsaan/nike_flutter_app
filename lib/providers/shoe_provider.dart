// import 'package:flutter_riverpod/flutter_riverpod.dart';

// // State provider for selected category
// final selectedCategoryProvider = StateProvider<String>((ref) => "All Shoes");

// // State provider for the list of all shoes
// final popularShoesProvider = StateProvider<List<Shoe>>((ref) => [
//       Shoe(
//           name: 'Nike Jordan',
//           price: 302.00,
//           imageUrl: "assets/images/NikeLogo2.png",
//           isFavorite: false,
//           category: 'Outdoor'),
//       Shoe(
//           name: 'Nike Air Max',
//           price: 752.00,
//           imageUrl: 'assets/images/NikeLogo3.png',
//           isFavorite: true,
//           category: 'Tennis'),
//     ]);

// // Provider to filter shoes based on selected category
// final filteredShoesProvider = Provider<List<Shoe>>((ref) {
//   final selectedCategory = ref.watch(selectedCategoryProvider) ?? "All Shoes";
//   final allShoes = ref.watch(popularShoesProvider);

//   if (selectedCategory == 'All Shoes') {
//     return allShoes;
//   } else {
//     return allShoes.where((shoe) => shoe.category == selectedCategory).toList();
//   }
// });

// final toggleIsFavoriteProvider = Provider.autoDispose((ref) {
//   return (Shoe shoe){
//     shoe.isFavorite = !shoe.isFavorite;
//   }
// });

// class Shoe {
//   final String name;
//   final double price;
//   final String imageUrl;
//    bool isFavorite;
//   final String category;
//   Shoe(
//       {required this.name,
//       required this.price,
//       required this.imageUrl,
//       required this.isFavorite,
//       required this.category});
// }

// StateNotifier for managing the list of shoes
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShoeNotifier extends StateNotifier<List<Shoe>> {
  ShoeNotifier()
      : super([
          Shoe(
            name: 'Nike Jordan',
            price: 302.00,
            imageUrl: "assets/images/NikeLogo2.png",
            isFavorite: false,
            category: 'Outdoor',
            quantity: 0,
          ),
          Shoe(
              name: 'Nike Air Max',
              price: 752.00,
              imageUrl: 'assets/images/NikeLogo3.png',
              isFavorite: true,
              category: 'Tennis',
              quantity: 0),
        ]);

  void toggleFavorite(Shoe shoe) {
    state = [
      for (final s in state)
        if (s.name == shoe.name)
          Shoe(
            name: s.name,
            price: s.price,
            imageUrl: s.imageUrl,
            isFavorite: !s.isFavorite,
            category: s.category,
          )
        else
          s
    ];
  }
}

final cartErrorProvider = StateProvider<String?>((ref) => null);

class CartNotifier extends StateNotifier<List<Shoe>> {
  CartNotifier(this.ref) : super([]);
  final Ref ref;

  void addToCart(Shoe shoe) {
    if (state.any((s) => s.name == shoe.name)) {
      state = [
        for (final s in state)
          if (s.name == shoe.name)
            s.copyWith(quantity: s.quantity! + 1) // Increment quantity
          else
            s
      ];
      ref.read(cartErrorProvider.notifier).state = null;
      return;
    }
    state = [...state, shoe.copyWith(quantity: 1)]; // Add with quantity 1
    ref.read(cartErrorProvider.notifier).state = null;
  }

  void removeFromCart(Shoe shoe) {
    if (state.any((s) => s.name == shoe.name && s.quantity! > 1)) {
      state = [
        for (final s in state)
          if (s.name == shoe.name)
            s.copyWith(quantity: s.quantity! - 1) // Decrement quantity
          else
            s
      ];
    } else {
      state = state
          .where((s) => s.name != shoe.name)
          .toList(); // Remove if quantity is 1
    }
    ref.read(cartErrorProvider.notifier).state = null;
  }

  void clearCart() {
    print('heyy');
    state = [];
    ref.read(cartErrorProvider.notifier).state = null;
  }
}

class NotificationNotifier extends StateNotifier<List<Shoe>> {
  NotificationNotifier() : super([]);
  // final Ref ref;
  void addNotifications(List<Shoe> shoes) {
    final updatedShoes = shoes.map((shoe) {
      return shoe.copyWith(date: DateTime.now().toIso8601String());
    }).toList();
    state = [...state, ...updatedShoes];
    // ref.read(popularCartProvider.notifier).clearCart();
  }

  void clearNotification() {
    print('heyy');
    state = [];
  }
}

final popularNotificationProvider =
    StateNotifierProvider<NotificationNotifier, List<Shoe>>((ref) {
  return NotificationNotifier();
});

final popularCartProvider =
    StateNotifierProvider<CartNotifier, List<Shoe>>((ref) {
  return CartNotifier(ref);
});

final notificationItemCountProvider = Provider<int>((ref) {
  final notitifications = ref.watch(popularNotificationProvider);
  return notitifications.fold<int>(
    0,
    (previousValue, shoe) => previousValue + (shoe.quantity ?? 0),
  );
});
final cartItemCountProvider = Provider<int>((ref) {
  final cart = ref.watch(popularCartProvider);
  return cart.fold<int>(
    0,
    (previousValue, shoe) => previousValue + (shoe.quantity ?? 0),
  );
});
final favoriteShoesProvider = Provider<List<Shoe>>((ref) {
  final allShoes = ref.watch(popularShoesProvider);
  return allShoes.where((shoe) => shoe.isFavorite).toList();
});

// StateNotifierProvider for the list of shoes
final popularShoesProvider =
    StateNotifierProvider<ShoeNotifier, List<Shoe>>((ref) {
  return ShoeNotifier();
});

// State provider for selected category
final selectedCategoryProvider = StateProvider<String>((ref) => "All Shoes");

// Provider to filter shoes based on selected category
final filteredShoesProvider = Provider<List<Shoe>>((ref) {
  final selectedCategory = ref.watch(selectedCategoryProvider);
  final allShoes = ref.watch(popularShoesProvider);

  if (selectedCategory == 'All Shoes') {
    return allShoes;
  } else {
    return allShoes.where((shoe) => shoe.category == selectedCategory).toList();
  }
});

final pageIndexProvider = StateProvider<int>((ref) => 0);

class Shoe {
  final String name;
  final double price;
  final String imageUrl;
  final bool isFavorite;
  final String category;
  final int? quantity;
  final String? date;

  Shoe(
      {required this.name,
      required this.price,
      required this.imageUrl,
      required this.isFavorite,
      required this.category,
      this.date,
      this.quantity = 1});

  Shoe copyWith({
    String? name,
    double? price,
    String? imageUrl,
    bool? isFavorite,
    String? category,
    int? quantity,
    String? date,
  }) {
    return Shoe(
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      date: date ?? this.date,
    );
  }
}
