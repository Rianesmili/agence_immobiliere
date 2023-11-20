class BienImmobilier {
  final int numero;
  final TypeBien type;
  final int nombrePieces;
  final double prix;
  final String image;

  BienImmobilier({
    required this.numero,
    required this.type,
    required this.nombrePieces,
    required this.prix,
    required this.image,
  });
}

enum TypeBien {
  appartement,
  maison,
}
