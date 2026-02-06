import 'package:flutter/material.dart';
import '../models/wizard.dart';
import '../models/house.dart';
import '../models/wand.dart';
import '../services/wizard_service.dart';
import '../services/house_service.dart';
import '../services/wand_service.dart';

class WizardFormScreen extends StatefulWidget {
  final Wizard? wizard; 
  final VoidCallback onSaved;

  const WizardFormScreen({super.key, this.wizard, required this.onSaved});

  @override
  State<WizardFormScreen> createState() => _WizardFormScreenState();
}

class _WizardFormScreenState extends State<WizardFormScreen> {
  // Controladores de texto
  final nameCtrl = TextEditingController();
  final ageCtrl = TextEditingController();

  // Servicios
  final wizardService = WizardService();
  final houseService = HouseService();
  final wandService = WandService();

  // Listas de selección
  List<House> houses = [];
  List<Wand> wands = [];

  // Selecciones actuales
  String? selectedHouseId;
  String? selectedWandId;

  @override
  void initState() {
    super.initState();

    // Cargamos las listas en paralelo
    _loadLists();

    // Si es edición, precargar valores
    if (widget.wizard != null) {
      nameCtrl.text = widget.wizard!.name;
      ageCtrl.text = widget.wizard!.age.toString();
      selectedHouseId = widget.wizard!.houseId;
      selectedWandId = widget.wizard!.wandId;
    }
  }

  // Cargar casas y varitas desde Supabase
  Future<void> _loadLists() async {
    houses = await houseService.getHouses();
    wands = await wandService.getWands();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.wizard != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? "Editar Mago" : "Nuevo Mago")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // Nombre del mago
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: "Nombre"),
            ),

            // Edad del mago
            TextField(
              controller: ageCtrl,
              decoration: const InputDecoration(labelText: "Edad"),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 20),

            // Selección de casa --- Su PMV es un DropdownButtonFormField, que es un widget que muestra un dropdown con opciones.
            // El value es la opción seleccionada, items son las opciones disponibles (en este caso, las casas),
            // onChanged se llama cuando el usuario selecciona una opción, y decoration es para ponerle un label.
            DropdownButtonFormField<String>(
              //¿Y cómo sabe cuál es la casa seleccionada? Pues con el value, que es el id de la casa seleccionada.
              // Entonces, cuando el usuario elige una opción, onChanged actualiza selectedHouseId
              // con el id de la casa elegida. Pone deprecated porque el value no puede ser nulo, 
              //pero lo dejamos así para que funcione al crear un mago nuevo, que no tiene casa asignada.
              value: selectedHouseId,
              items: houses
                  .map((h) => DropdownMenuItem(
                        value: h.id,
                        child: Text(h.name),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => selectedHouseId = v),
              decoration: const InputDecoration(labelText: "Casa"),
            ),

            const SizedBox(height: 20),

            // Selección de varita = otro DropdownButtonFormField, pero con las varitas. 
            //Funciona igual que el de casas, pero con wands en vez de houses.
            DropdownButtonFormField<String>(
              value: selectedWandId,
              items: wands
                  .map((w) => DropdownMenuItem(
                        value: w.id,
                        child: Text("${w.wood} - ${w.core}"),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => selectedWandId = v),
              decoration: const InputDecoration(labelText: "Varita"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              child: Text(isEdit ? "Guardar cambios" : "Crear mago"),
              onPressed: () async {
                final name = nameCtrl.text;
                final age = int.tryParse(ageCtrl.text) ?? 0;

                if (isEdit) {
                  await wizardService.updateWizard(
                    widget.wizard!.id,
                    name,
                    age,
                    selectedHouseId,
                    selectedWandId,
                  );
                } else {
                  await wizardService.addWizard(
                    name,
                    age,
                    selectedHouseId,
                    selectedWandId,
                  );
                }

                widget.onSaved();
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}