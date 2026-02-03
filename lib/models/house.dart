class House {
  final String id;
  final String name;
  final String founder;

  House({required this.id, required this.name, required this.founder});

  factory House.fromMap(Map<String, dynamic> map) {
    return House(id: map['id'], name: map['name'], founder: map['founder']);
  }
}//end class
