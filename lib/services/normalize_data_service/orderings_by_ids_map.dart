import '../../models/ordering.dart';

class OrderingsByIdsMap {
  final List<Ordering> orderings;

  Map<String, Ordering> _map = {};

  OrderingsByIdsMap(this.orderings) {
    _map = _generateOrderingsMap();
  }

  Map<String, Ordering> _generateOrderingsMap() {
    final orderingsMap = <String, Ordering>{};

    for (final ordering in orderings) {
      orderingsMap[ordering.id] = ordering;
    }

    return orderingsMap;
  }

  int get(String idA, String idB) {
    final num orderingOrInfinity = _map[idA]?.ordering[idB] ?? double.infinity;

    return orderingOrInfinity.toInt();
  }
}
