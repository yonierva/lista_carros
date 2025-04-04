class Car {
  final String name;
  final String brand;
  // Agrega más campos si es necesario

  Car({required this.name, required this.brand});

  // Método para convertir JSON a objeto Car
  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      name: json['name'],
      brand: json['brand'],
    );
  }

  // Método para convertir objeto Car a JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'brand': brand,
    };
  }
}
