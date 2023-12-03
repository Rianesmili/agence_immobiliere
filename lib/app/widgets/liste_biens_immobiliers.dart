import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/repository/repository.dart';
import '../../models/model_data.dart';
import 'bien_immobiler_item.dart';
import 'detail_bien_immobiler.dart'; // Import the details page

class ListeBiensImmobiliers extends StatefulWidget {
  const ListeBiensImmobiliers({super.key});

  @override
  _ListeBiensImmobiliersState createState() => _ListeBiensImmobiliersState();
}

class _ListeBiensImmobiliersState extends State<ListeBiensImmobiliers> {
  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    // Écoute le Stream et appelle setState chaque fois qu'un événement est reçu
    _subscription = Repository.updateStream.listen((_) => setState(() {}));
  }

  @override
  void dispose() {
    _subscription.cancel(); // annuler l'abonnement lorsque le widget est supprimé
    super.dispose();
  }

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
                return GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsBienImmobilier(
                          bienImmobilier: snapshot.data![index],
                        ),
                      ),
                    );
                    setState(() {});
                  },
                  child: BienImmobilierItem(bienImmobilier: snapshot.data![index]),
                );
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