class Food {
  int? id;
  String name;
  double price;
  String available;
  String address;
  double rating;
  String image;
  Food({
    this.id,
    required this.name,
    required this.price,
    required this.available,
    required this.address,
    required this.rating,
    required this.image,
  });
}

List<Food> foodList = [
  Food(
      name: "Pizza",
      price: 700,
      available: "10 am to 7 pm",
      address: "Radhe Radhe",
      rating: 4.5,
      image: "assets/images/pizza_def.jpg"),
  Food(
      name: "Sekuwa",
      price: 2500,
      available: "10 am to 7 pm",
      address: "Radhe Radhe",
      rating: 4.5,
      image: "assets/images/sekuwa.jpeg"),
  Food(
      name: "Burger",
      price: 1000,
      available: "10 am to 7 pm",
      address: "Radhe Radhe",
      rating: 5,
      image: "assets/images/burger.jpeg"),
  Food(
      name: "Cake",
      price: 100,
      available: "10 am to 7 pm",
      address: "Radhe Radhe",
      rating: 3,
      image: "assets/images/cake.jpeg"),
];

List<Food> kfcList = [
  Food(
      name: "2 Pc Hot & Crispy",
      price: 480,
      available: "10 am to 7 pm",
      address: "Radhe Radhe",
      rating: 4.5,
      image: "assets/images/two_peace.png"),
  Food(
      name: "Chicken & Fries Bucket",
      price: 599,
      available: "10 am to 7 pm",
      address: "Radhe Radhe",
      rating: 4.5,
      image: "assets/images/bucket.jpeg"),
  Food(
      name: "Boneless Strips",
      price: 385,
      available: "10 am to 7 pm",
      address: "Radhe Radhe",
      rating: 5,
      image: "assets/images/boneless_strips.png"),
  Food(
      name: "6 Pc Chicken Strips",
      price: 699,
      available: "10 am to 7 pm",
      address: "Radhe Radhe",
      rating: 3,
      image: "assets/images/six_strips.jpg"),
];
