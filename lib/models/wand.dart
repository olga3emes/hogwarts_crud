class Wand {
  final String id;
  final String core;
  final String wood;
  final int length;

  Wand({required this.id,  required this.core, required this.wood, required this.length,});

  // Crear desde JSON de Supabase
  factory Wand.fromMap(Map<String, dynamic> map) {
    return Wand( id: map['id'], core: map['core'], wood: map['wood'], length: map['length'], );
  }
}//end class
