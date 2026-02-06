import 'package:flutter/material.dart';
import '../models/wand.dart';
import '../services/wand_service.dart';

class WandFormScreen extends StatefulWidget {
  final Wand? wand;
  final VoidCallback onSaved;

  const WandFormScreen({super.key, this.wand, required this.onSaved});

  @override
  State<WandFormScreen> createState() => _WandFormScreenState();
}

class _WandFormScreenState extends State<WandFormScreen> {
  final coreCtrl = TextEditingController();
  final woodCtrl = TextEditingController();
  final lengthCtrl = TextEditingController();
  final service = WandService();

  @override
  void initState() {
    super.initState();
    if (widget.wand != null) {
      coreCtrl.text = widget.wand!.core;
      woodCtrl.text = widget.wand!.wood;
      lengthCtrl.text = widget.wand!.length.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.wand != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? "Editar Varita" : "Nueva Varita")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: coreCtrl,
              decoration: const InputDecoration(labelText: "Núcleo"),
            ),
            TextField(
              controller: woodCtrl,
              decoration: const InputDecoration(labelText: "Madera"),
            ),
            TextField(
              controller: lengthCtrl,
              decoration: const InputDecoration(labelText: "Longitud (cm)"),
              keyboardType: TextInputType.number,//esto para el móvil saca el teclado numérico
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              child: Text(isEdit ? "Guardar" : "Crear"),
              onPressed: () async {
                final core = coreCtrl.text;
                final wood = woodCtrl.text;
                final length = int.tryParse(lengthCtrl.text) ?? 0;

                if (isEdit) {
                  await service.updateWand(widget.wand!.id, core, wood, length);
                } else {
                  await service.addWand(core, wood, length);
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