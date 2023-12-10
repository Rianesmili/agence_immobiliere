import 'dart:async';

import 'package:agence_immobiliere/data/repository/repository.dart';
import 'package:agence_immobiliere/models/model_data.dart';

class RepoMockImpl implements Repository {
  final List<BienImmobilier> _biensImmobiliers = [
    BienImmobilier(
      numero: 1234,
      type: TypeBien.appartement,
      nombrePieces: 4,
      prix: 100000,
      image: 'lib/assets/images/appartement1.jpg',
    ),
    BienImmobilier(
      numero: 456,
      type: TypeBien.maison,
      nombrePieces: 4,
      prix: 120000,
      image: 'lib/assets/images/maison1.jpg',
    ),
    BienImmobilier(
      numero: 7890,
      type: TypeBien.maison,
      nombrePieces: 7,
      prix: 300000,
      image: 'lib/assets/images/maison2.jpg',
    ),
    BienImmobilier(
      numero: 543,
      type: TypeBien.appartement,
      nombrePieces: 5,
      prix: 110000,
      image: 'lib/assets/images/appartement2.jpg',
    ),
    BienImmobilier(
      numero: 876,
      type: TypeBien.maison,
      nombrePieces: 5,
      prix: 140000,
      image: 'lib/assets/images/maison3.jpg',
    ),
  ];

  // Create a StreamController that will emit an event every time a BienImmobilier is updated
  final StreamController<BienImmobilier> _updateController = StreamController<BienImmobilier>.broadcast();

  @override
  Future<List<BienImmobilier>> getBiensImmobiliers() async {
    return _biensImmobiliers;
  }

  @override
  void updateBienImmobilier(BienImmobilier updatedBien) {
    final index = _biensImmobiliers.indexWhere((bien) => bien.numero == updatedBien.numero);
    if (index != -1) {
      _biensImmobiliers[index] = updatedBien;
      _updateController.add(updatedBien);
    }
  }

  @override
  Stream<BienImmobilier> get updateStream => _updateController.stream;

  void dispose() {
    _updateController.close();
  }
}