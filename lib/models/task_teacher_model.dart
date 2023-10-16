class CourseModel {
  int? idCourse;
  String? nameCourse;

  CourseModel({this.idCourse,this.nameCourse});

  factory CourseModel.fromMap(Map<String, dynamic> map){
    return CourseModel(
      idCourse: map['idCourse'],
      nameCourse: map['nameCourse']
    );
  }
}

class TeacherModel {
  int? idTeacher;
  String? nameTeacher;
  String? email;
  int? idCourse;

  TeacherModel({this.idTeacher,this.nameTeacher,this.email,this.idCourse});

  factory TeacherModel.fromMap(Map<String, dynamic> map){
    return TeacherModel(
      idTeacher: map['idTeacher'],
      nameTeacher: map['nameTeacher'],
      email: map['email'],
      idCourse: map['idCourse']
    );
  }

}

class TaskModel {
  int? idTask;
  String? nameTask;
  String? dateExp;
  String? dateRem;
  String? dscTask;
  int? doing;
  int? idTeacher;

  TaskModel({this.idTask,this.nameTask,this.dateExp,this.dateRem,this.dscTask,this.doing,this.idTeacher});

  factory TaskModel.fromMap(Map<String, dynamic> map){
    return TaskModel(
      idTask: map['idTask'],
      nameTask: map['nameTask'],
      dateExp: map['dateExp'],
      dateRem: map['dateRem'],
      dscTask: map['dscTask'],
      doing: map['doing'],
      idTeacher: map['idTeacher']
    );
  }
}