import 'package:flutter/material.dart';
import 'package:pmsn20232/models/task_teacher_model.dart';

class SearchTeacher extends SearchDelegate<TeacherModel> {

  SearchTeacher({
    this.screen, 
    this.listTeacher,
  });

  final String? screen;
  final List<TeacherModel>? listTeacher;
  List<TeacherModel> _filter = [];
  
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {          
          close(context, TeacherModel());
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      onPressed: () {
        close(context, TeacherModel());
      },
      icon: const Icon(Icons.arrow_back),
    );
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: _filter.length,
      itemBuilder: (_, index) {        
        return GestureDetector(
          child: ListTile(
            title: Text(_filter[index].nameTeacher!)
          ),
          onTap: () {
            close(context, _filter[index]);
            Navigator.pushNamed(context, '/addTeacherTask', arguments: {'screen': screen, 'data': _filter[index]});
          }
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _filter = listTeacher!.where((model) {
          return model.nameTeacher!.toLowerCase().contains(query.trim().toLowerCase());
        }).toList();
    return ListView.builder(
      itemCount: _filter.length,
      itemBuilder: (_, index) {
        return GestureDetector(
          child: ListTile(
            title: Text(_filter[index].nameTeacher!),
          ),
          onTap: () {
            close(context, _filter[index]);
            Navigator.pushNamed(context, '/addTeacherTask', arguments: {'screen': screen, 'data': _filter[index]});
          }
        );
      },
    );
  }
}