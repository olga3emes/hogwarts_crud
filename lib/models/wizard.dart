class Wizard {
  final String id;
  final String name;
  final int age;
  final String? houseId;
  final String? wandId;

  // Campos opcionales obtenidos desde los JOIN
  final String? houseName;
  final String? wandWood;
  final String? wandCore;

  Wizard({
    required this.id,
    required this.name,
    required this.age,
    this.houseId,
    this.wandId,
    this.houseName,
    this.wandWood,
    this.wandCore,
  });

  factory Wizard.fromMap(Map<String, dynamic> map) {
    return Wizard(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      houseId: map['house_id'],
      wandId: map['wand_id'],
      houseName: map['houses'] != null ? map['houses']['name'] : null,
      wandWood: map['wands'] != null ? map['wands']['wood'] : null,
      wandCore: map['wands'] != null ? map['wands']['core'] : null,
    );
  }
}
