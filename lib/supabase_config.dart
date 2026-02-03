import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  // Inicializa Supabase
  static Future<void> init() async {
    await Supabase.initialize(
      url: 'https://oootpwyyhakzpkbmmwbf.supabase.co',
      anonKey: 'YOUR_ANON_KEY',
    );
  }

  // Atajo para acceder al cliente
  static SupabaseClient get client => Supabase.instance.client;
}
