import 'dart:async';

import '../../models/model_data.dart';

class Repository {
  static final List<BienImmobilier> _biensImmobiliers = [
    BienImmobilier(
      // innitialize the list with some data

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

  // Création d'un StreamController qui émettra un événement chaque fois qu'un BienImmobilier est mis à jour
  static final StreamController<BienImmobilier> _updateController = StreamController<BienImmobilier>.broadcast();

  static Future<List<BienImmobilier>> getBiensImmobiliers() async {
    return _biensImmobiliers;
  }

  static void updateBienImmobilier(BienImmobilier updatedBien) {
    final index = _biensImmobiliers.indexWhere((bien) => bien.numero == updatedBien.numero);
    if (index != -1) {
      _biensImmobiliers[index] = updatedBien;
      _updateController.add(updatedBien); // Émet un événement chaque fois qu'un BienImmobilier est mis à jour
    }
  }

  // Méthode pour obtenir le Stream du StreamController
  static Stream<BienImmobilier> get updateStream => _updateController.stream;
}
