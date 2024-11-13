class Notifikasi {
  final String title;
  final String subtitle;

  Notifikasi({
    required this.title,
    required this.subtitle,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
    };
  }
}