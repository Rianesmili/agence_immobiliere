import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universal_html/html.dart' as html;
import '../../data/repository/repository.dart';
import '../../models/model_data.dart';

class DetailsBienImmobilier extends StatefulWidget {
  final BienImmobilier bienImmobilier;
  final repository = GetIt.instance<Repository>();

  DetailsBienImmobilier({Key? key, required this.bienImmobilier}) : super(key: key);

  @override
  State<DetailsBienImmobilier> createState() => _DetailsBienImmobilierState();
}

class _DetailsBienImmobilierState extends State<DetailsBienImmobilier> {
  late TextEditingController nombrePiecesController;
  late TextEditingController prixController;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    nombrePiecesController = TextEditingController(text: '${widget.bienImmobilier.nombrePieces}');
    prixController = TextEditingController(text: '${widget.bienImmobilier.prix}');
    imageUrl = widget.bienImmobilier.image;
  }

  Future<void> _pickImage() async {
    if (kIsWeb) {
      // Flutter Web: Load image from file picker
      final html.InputElement input = html.document.createElement('input') as html.InputElement;
      input.type = 'file';
      input.accept = 'image/*';
      input.click();
      await input.onChange.first;
      if (input.files != null && input.files!.isNotEmpty) {
        final reader = html.FileReader();
        reader.readAsDataUrl(input.files![0]);
        await reader.onLoad.first;
        setState(() {
          imageUrl = reader.result as String?;
          widget.bienImmobilier.image = imageUrl!;
          widget.repository.updateBienImmobilier(widget.bienImmobilier);
        });
      }
    } else {
      // Mobile: Load image from gallery
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          imageUrl = image.path;
          widget.bienImmobilier.image = imageUrl!;
          widget.repository.updateBienImmobilier(widget.bienImmobilier);
        });
      }
    }
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
                  widget.repository.updateBienImmobilier(widget.bienImmobilier);
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
                    widget.repository.updateBienImmobilier(widget.bienImmobilier);
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
                    widget.repository.updateBienImmobilier(widget.bienImmobilier);
                  });
                } catch (e) {
                  // Handle the error appropriately.
                  print('Error: $e');
                }
              },
            ),
            GestureDetector(
              onTap: _pickImage,
              child: imageUrl == null
                  ? const SizedBox.shrink()
                  : kIsWeb
                  ? Image.network(imageUrl!, fit: BoxFit.cover, width: 200, height: 200)
                  : Image.file(File(imageUrl!), fit: BoxFit.cover, width: 200, height: 200),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    nombrePiecesController.dispose();
    prixController.dispose();
    super.dispose();
  }
}