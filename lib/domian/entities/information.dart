class Information {
  final String text;

  Information({required this.text});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Information) return false;
    return text == other.text;
  }

  @override
  int get hashCode => text.hashCode;
}
