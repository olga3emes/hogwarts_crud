import '../supabase_config.dart';
import '../models/wizard.dart';

class WizardService {
  final _db = SupabaseConfig.client;

  // Obtener todos los magos
  Future<List<Wizard>> getWizards() async {
    final response = await _db.from('wizards').select();
    return response.map((e) => Wizard.fromMap(e)).toList();
  }

  // Crear mago con relaciones
  Future<void> addWizard(String name, int age, String? houseId, String? wandId) async {
    await _db.from('wizards').insert({
      'name': name,
      'age': age,
      'house_id': houseId,
      'wand_id': wandId,
    });
  }

  // Editar mago
  Future<void> updateWizard(
    String id,
    String name,
    int age,
    String? houseId,
    String? wandId,
  ) async {
    await _db.from('wizards').update({
      'name': name,
      'age': age,
      'house_id': houseId,
      'wand_id': wandId,
    }).eq('id', id);
  }

  // Eliminar mago
  Future<void> deleteWizard(String id) async {
    await _db.from('wizards').delete().eq('id', id);
  }
}