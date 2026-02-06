import 'package:flutter/material.dart';
import '../models/wizard.dart';
import '../models/house.dart';
import '../models/wand.dart';
import '../services/wizard_service.dart';
import '../services/house_service.dart';
import '../services/wand_service.dart';

class WizardFormScreen extends StatefulWidget {
  final Wizard? wizard; // Si viene un mago, es edición
  final VoidCallback onSaved; // Para refrescar la pantalla anterior

  const WizardFormScreen({super.key, this.wizard, required this.onSaved});

  @override
  State<WizardFormScreen> createState() => _WizardFormScreenState();
}

class _WizardFormScreenState extends State<WizardFormScreen> {
  // Controladores
  final nameCtrl = TextEditingController();
  final ageCtrl = TextEditingController();

  // Clave de Form para validación
  final formKey = GlobalKey<FormState>();

  // Servicios
  final wizardService = WizardService();
  final houseService = HouseService();
  final wandService = WandService();

  // Listas
  List<House> houses = [];
  List<Wand> wands = [];

  // Valores seleccionados
  String? selectedHouseId;
  String? selectedWandId;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  /// Cargar casas, varitas y datos iniciales
  Future<void> _loadData() async {
    houses = await houseService.getHouses();
    wands = await wandService.getWands();

    if (widget.wizard != null) {
      nameCtrl.text = widget.wizard!.name;
      ageCtrl.text = widget.wizard!.age.toString();

      selectedHouseId = widget.wizard!.houseId;
      selectedWandId = widget.wizard!.wandId;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.wizard != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? "Editar Mago" : "Nuevo Mago")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        // CONTENEDOR general del formulario, con fondo y bordes redondeados
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF4F4F4),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color.fromARGB(255, 247, 247, 247)),
          ),

          child: Form(
            key: formKey, // Para validación

            child: ListView(
              children: [
                // -------------------------------
                //  NOMBRE (validado)
                // -------------------------------
                TextFormField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(labelText: "Nombre"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "El nombre es obligatorio";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // -------------------------------
                //  EDAD (validada)
                // -------------------------------
                TextFormField(
                  controller: ageCtrl,
                  decoration: const InputDecoration(labelText: "Edad"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "La edad es obligatoria";
                    }
                    final age = int.tryParse(value);
                    if (age == null || age <= 0) {
                      return "Introduce una edad válida";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // -------------------------------
                //  DROPDOWN DE CASAS
                // -------------------------------
                DropdownMenu<String>(
                  width: double.infinity,
                  initialSelection: selectedHouseId,
                  label: const Text("Casa"),
                  dropdownMenuEntries: houses
                      .map(
                        (h) => DropdownMenuEntry<String>(
                          value: h.id,
                          label: h.name,
                        ),
                      )
                      .toList(),
                  onSelected: (value) {
                    setState(() {
                      selectedHouseId = value;
                    });
                  },
                ),

                const SizedBox(height: 20),

                // -------------------------------
                //  DROPDOWN DE VARITAS
                // -------------------------------
                DropdownMenu<String>(
                  width: double.infinity,
                  initialSelection: selectedWandId,
                  label: const Text("Varita"),
                  dropdownMenuEntries: wands
                      .map(
                        (w) => DropdownMenuEntry<String>(
                          value: w.id,
                          label: "${w.wood} - ${w.core}",
                        ),
                      )
                      .toList(),
                  onSelected: (value) {
                    setState(() {
                      selectedWandId = value;
                    });
                  },
                ),

                const SizedBox(height: 30),

                // -------------------------------
                //  BOTÓN GUARDAR
                // -------------------------------
                ElevatedButton(
                  child: Text(isEdit ? "Guardar cambios" : "Crear mago"),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final name = nameCtrl.text;
                      final age = int.parse(ageCtrl.text);

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
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
