import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';

import 'package:integrazoo/ui/components.dart';


class BreedersPaginationView extends StatefulWidget {
  const BreedersPaginationView({ super.key });

  @override
  State<BreedersPaginationView> createState() => _BreedersPaginationView();
}

class _BreedersPaginationView extends State<BreedersPaginationView> {
  late BreedersDataLoader _dataSource;

  final search = BovinesSearchNotifier();

  @override
  void initState() {
    super.initState();

    _dataSource = BreedersDataLoader();
  }

  @override
  Widget build(BuildContext context) {
    return Paginator(
      loader: _dataSource,
      rowsPerPage: const [ 5, 10, 15, 20, 25],
      pageBuilder: buildBreeders,
    );
  }

  Widget buildBreeders(BuildContext context) {
    return SingleChildScrollView(child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(_dataSource.availableRows, buildIthElement),
    ));
  }

  Widget buildIthElement(int i) {
    if (_dataSource.isLoading) {
      return const ListTile(leading: CircularProgressIndicator());
    }
    final s = _dataSource.getElement(i);

    return BreederTile(breeder: s, postAction: _dataSource.reload);
  }
}
