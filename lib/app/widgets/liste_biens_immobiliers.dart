import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../data/repository/repository.dart';
import '../../models/model_data.dart';
import 'bien_immobiler_item.dart';
import 'detail_bien_immobiler.dart';

class ListeBiensImmobiliers extends StatefulWidget {
  const ListeBiensImmobiliers({Key? key}) : super(key: key);

  @override
  _ListeBiensImmobiliersState createState() => _ListeBiensImmobiliersState();
}

class _ListeBiensImmobiliersState extends State<ListeBiensImmobiliers> {
  late StreamSubscription _subscription;
  final repository = GetIt.instance<Repository>();

  @override
  void initState() {
    super.initState();
    // Listen to the Stream and call setState every time an event is received
    _subscription = repository.updateStream.listen((_) => setState(() {}));
  }

  @override
  void dispose() {
    _subscription
        .cancel(); // Cancel the subscription when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Real Estate'),
      ),
      body: FutureBuilder<List<BienImmobilier>>(
        future: repository.getBiensImmobiliers(),
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
                  child: Expanded(
                    // Add this
                    child: BienImmobilierItem(
                        bienImmobilier: snapshot.data![index]),
                  ),
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
