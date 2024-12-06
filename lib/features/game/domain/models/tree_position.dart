class TreePosition {
  final double x;
  final double y;

  const TreePosition({
    required this.x,
    required this.y,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TreePosition && other.x == x && other.y == y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}
