class Wizard {
  final String id;
  final String name;
  final int age;
  final String? houseId; /*? puede ser nulo, bueno para las FKs*/
  final String? wandId;

  Wizard({
    required this.id,
    required this.name,
    required this.age,
    this.houseId,
    this.wandId,
  });

  // Crear desde JSON de Supabase
  factory Wizard.fromMap(Map<String, dynamic> map) {
    return Wizard(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      houseId: map['house_id'],
      wandId: map['wand_id'],
    );
  }
}//end class
