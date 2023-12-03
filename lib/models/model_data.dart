class BienImmobilier {
  int numero;
  TypeBien type;
  int nombrePieces;
  double prix;
  String image ;

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
