import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/repository/repository.dart';
import '../../models/products.dart';
import 'bien_immobiler_item.dart';

class ListeBiensImmobiliers extends StatelessWidget {
  const ListeBiensImmobiliers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Real Estate'),
      ),
      body: FutureBuilder<List<BienImmobilier>>(
        future: Repository.getBiensImmobiliers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return BienImmobilierItem(bienImmobilier: snapshot.data![index]);
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
