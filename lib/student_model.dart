class Student {
  int? id;
  String name;
  String course;

  Student({
    this.id,
    required this.name,
    required this.course});

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    id: json['id'],
    name: json['name'],
    course: json['course'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'course': course,
  };
}