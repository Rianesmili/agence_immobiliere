import 'package:agence_immobiliere/data/repository/repository.dart';
import 'package:agence_immobiliere/models/model_data.dart';

class RepoMockImpl implements Repository{
  @override
  get listBienImmobiliers async {
    return[
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
  }

}