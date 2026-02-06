import 'package:flutter/material.dart';
import 'wizard_list_screen.dart';
import 'house_list_screen.dart';
import 'wand_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior
      appBar: AppBar(
        title: const Text("Hogwarts CRUD"),
        centerTitle: true,
      ),

      // Contenido principal
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        // GridView para tener botones organizados en columnas
        child: GridView.count(
          crossAxisCount: 2, // 2 columnas
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: [
            // --- BOTÓN: MAGOS ---
            _buildHomeCard(
              context,
              title: "Magos",
              icon: Icons.rowing,
              color: Colors.blue,
              target: const WizardListScreen(),
            ),

            // --- BOTÓN: CASAS ---
            _buildHomeCard(
              context,
              title: "Casas",
              icon: Icons.castle,
              color: Colors.redAccent,
              target: const HouseListScreen(),
            ),

            // --- BOTÓN: VARITAS ---
            _buildHomeCard(
              context,
              title: "Varitas",
              icon: Icons.auto_fix_high,
              color: const Color.fromARGB(255, 246, 105, 54),
              target: const WandListScreen(),
            ),
          ],
        ),
      ),
    );
  }

  /// Construye una tarjeta que actúa como botón
  Widget _buildHomeCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required Widget target,
  }) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => target),
      ),

      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 5,

        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: color.withValues(alpha: 0.3), //transparencia 30%
            //esto es para que el fondo del botón sea un color pastel, con poca opacidad
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icono grande
              Icon(icon, size: 50, color: color),

              const SizedBox(height: 12),

              // Texto
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}