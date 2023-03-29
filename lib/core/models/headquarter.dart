class Headquarter {
  final String name;
  final String city;
  final int workstations;
  final String image;

  Headquarter({
    required this.name,
    required this.city,
    required this.workstations,
    required this.image,
  });

  Headquarter copyWith({
    String? name,
    String? city,
    int? workstations,
  }) {
    return Headquarter(
      name: name ?? this.name,
      city: city ?? this.city,
      workstations: workstations ?? this.workstations,
      image: image ?? this.image,
    );
  }
}
