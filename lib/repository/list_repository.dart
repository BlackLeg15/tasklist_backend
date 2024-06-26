import 'package:tasklist_backend/datasource/list_datasource.dart';

class ListRepository {
  const ListRepository({required this.datasource});

  final ListDatasource datasource;
}
