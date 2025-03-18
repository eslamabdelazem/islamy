extension IndexedMap<ElementType> on List<ElementType> {
  List<ResultType> indexedMap<ResultType>(
      ResultType Function(int index, ElementType item) f) {
    return asMap()
        .entries
        .map((element) => f(element.key, element.value))
        .toList();
  }
}
