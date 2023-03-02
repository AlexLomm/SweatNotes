import '../../models/ordering.dart';

class OrderingsMap {
  final List<Ordering> orderings;

  Map<String, Ordering> _map = {};

  OrderingsMap(this.orderings) {
    // TODO: remove this from constructor?
    _map = _generateOrderingsMap();
  }

  Map<String, Ordering> _generateOrderingsMap() {
    final orderingsMap = <String, Ordering>{};

    for (final ordering in orderings) {
      orderingsMap[ordering.id] = ordering;
    }

    return orderingsMap;
  }

  int get(String idA, idB) {
    final num orderingOrInfinity = _map[idA]?.ordering[idB] ?? double.infinity;

    return orderingOrInfinity.toInt();
  }
}
