class Days {
  final String days;

  Days({required this.days});

  Days.fromMap(Map<String, dynamic> map) : days = map["days"];
  Map<String, dynamic> toMap() {
    return {"days": days};
  }
}
