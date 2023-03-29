class Event {
  final String name;
  final String headquarter_city;
  final String headquarter_name;
  final int tickets;
  final String image;
  final DateTime date;

  Event({
    required this.date,
    required this.headquarter_city,
    required this.headquarter_name,
    required this.tickets,
    required this.name,
    required this.image,
  });
}
