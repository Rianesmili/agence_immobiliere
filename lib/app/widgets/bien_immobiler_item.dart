import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/products.dart';

class BienImmobilierItem extends StatelessWidget {
  final BienImmobilier bienImmobilier;

  const BienImmobilierItem({
    required this.bienImmobilier,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/details', arguments: bienImmobilier);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.asset(bienImmobilier.image,
                  fit: BoxFit.cover, width: 200, height: 200),
              const SizedBox(width: 20),
              // add padding to image,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Property ${bienImmobilier.numero}',
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                      '${bienImmobilier.type.name} ${bienImmobilier.nombrePieces} rooms'),
                  const SizedBox(height: 8, width: 8),
                  Text('€ ${bienImmobilier.prix}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
