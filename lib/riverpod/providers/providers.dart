import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/data/network/food_api.dart';
import 'package:food_delivery_app/riverpod/notifier/cart_change_notifier.dart';
import 'package:food_delivery_app/riverpod/notifier/food_detail_notifier.dart';

// final tokenAuthProvider = Provider<TokenAuthService>((ref) {
//   return TokenAuthService(Dio());
// });

final cartChangeNotifierProvider =
    ChangeNotifierProvider.autoDispose<CartChangeNotifier>(((ref) {
  return CartChangeNotifier(
      authenticationService: ref.watch(foodServiceProvider));
}));

final foodDetailNotiferProvider =
    ChangeNotifierProvider.autoDispose<FoodDetailNotifier>((ref) {
  return FoodDetailNotifier(ref.watch(foodServiceProvider));
});
