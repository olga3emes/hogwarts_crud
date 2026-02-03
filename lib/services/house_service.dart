
import '../supabase_config.dart';
import '../models/house.dart';

class HouseService {
  // Atajo a la instancia de Supabase
  final _db = SupabaseConfig.client;


// Voy a devolver una lista de magos, pero todavía no la tengo.
// Te la da cuando el servidor responda. Entonces uso Future.
// El tipo de dato que devolveré es List<House>
// Así que el Future será Future<List<House>>
// El método es asíncrono, así que uso async
// El resultado lo obtengo con await, que espera la respuesta del servidor
// Finalmente devuelvo la lista de casas


  // Obtener todas las casas
  Future<List<House>> getHouses() async {
    final response = await _db.from('houses').select();
    // Transformamos cada registro en un objeto House
    return response.map((e) => House.fromMap(e)).toList();
  }

  // Crear una casa nueva
  Future<void> addHouse(String name, String founder) async {
    await _db.from('houses').insert({
      'name': name,
      'founder': founder,
    });
  }

  // Actualizar una casa
  Future<void> updateHouse(String id, String name, String founder) async {
    await _db
        .from('houses')
        .update({'name': name, 'founder': founder})
        .eq('id', id);
  }

  // Eliminar una casa
  Future<void> deleteHouse(String id) async {
    await _db.from('houses').delete().eq('id', id);
  }
}