import '../supabase_config.dart';
import '../models/wizard.dart';

class WizardService {
  final _db = SupabaseConfig.client;

  // Obtener magos junto con su casa y su varita
  Future<List<Wizard>> getWizards() async {
    final response = await _db
        .from('wizards')
        .select('id, name, age, house_id, wand_id, houses(name), wands(core, wood)')
        .order('name');

    return response.map((e) => Wizard.fromMap(e)).toList();
  }

  Future<void> addWizard(String name, int age, String? houseId, String? wandId) async {
    await _db.from('wizards').insert({
      'name': name,
      'age': age,
      'house_id': houseId,
      'wand_id': wandId,
    });
  }

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

  Future<void> deleteWizard(String id) async {
    await _db.from('wizards').delete().eq('id', id);
  }
}