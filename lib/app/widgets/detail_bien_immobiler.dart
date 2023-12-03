import 'package:flutter/material.dart';
import '../../data/repository/repository.dart';
import '../../models/model_data.dart';

class DetailsBienImmobilier extends StatefulWidget {
  final BienImmobilier bienImmobilier;

  const DetailsBienImmobilier({ super.key,
    required this.bienImmobilier,
  });

  @override
  State<DetailsBienImmobilier> createState() => _DetailsBienImmobilierState();
}

class _DetailsBienImmobilierState extends State<DetailsBienImmobilier> {
  late TextEditingController nombrePiecesController;
  late TextEditingController prixController;

  @override
  void initState() {
    super.initState();
    nombrePiecesController = TextEditingController(text: '${widget.bienImmobilier.nombrePieces}');
    prixController = TextEditingController(text: '${widget.bienImmobilier.prix}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details du bien immobilier'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('${widget.bienImmobilier.numero}'),
            DropdownButton<TypeBien>(
              value: widget.bienImmobilier.type,
              onChanged: (TypeBien? value) {
                setState(() {
                  widget.bienImmobilier.type = value!;
                  Repository.updateBienImmobilier(widget.bienImmobilier);
                });
              },
              items: TypeBien.values.map((TypeBien type) {
                return DropdownMenuItem<TypeBien>(
                  value: type,
                  child: Text(type.name),
                );
              }).toList(),
            ),
            TextField(
              controller: nombrePiecesController,
              onChanged: (String value) {
                try {
                  int newValue = int.parse(value);
                  setState(() {
                    widget.bienImmobilier.nombrePieces = newValue;
                    Repository.updateBienImmobilier(widget.bienImmobilier);
                  });
                } catch (e) {
                  // Handle the error appropriately.
                  print('Error: $e');
                }
              },
            ),
            TextField(
              controller: prixController,
              onChanged: (String value) {
                try {
                  double newValue = double.parse(value);
                  setState(() {
                    widget.bienImmobilier.prix = newValue;
                    Repository.updateBienImmobilier(widget.bienImmobilier);
                  });
                } catch (e) {
                  // Handle the error appropriately.
                  print('Error: $e');
                }
              },
            ),
            Image.asset(widget.bienImmobilier.image,
                fit: BoxFit.cover, width: 200, height: 200),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}