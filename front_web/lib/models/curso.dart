class Curso {
  String id, name;
  int max_periodos;
  List<int> periodos;

  Curso({this.id, this.name, this.max_periodos});

  Curso.fromJson(Map<String, dynamic> json) {
    this.id = json['curso_id'];
    this.name = json['name'];
    this.max_periodos = int.parse(json['max_periodo']);
    this.periodos = new List();
    for (int i = 1; i <= this.max_periodos; i++) {
      this.periodos.add(i);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['curso_id'] = this.id;
    data['name'] = this.name;
    data['max_periodo'] = this.max_periodos;
    return data;
  }
}
