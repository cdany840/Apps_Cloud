import 'package:flutter/material.dart';
import 'package:pmsn20232/models/task_teacher_model.dart';

class SearchCourse extends SearchDelegate<CourseModel> {

  SearchCourse({
    this.screen, 
    this.listCourse,
  });

  final String? screen;
  final List<CourseModel>? listCourse;
  List<CourseModel> _filter = [];
  
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {          
          close(context, CourseModel());
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      onPressed: () {
        close(context, CourseModel());
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
            title: Text(_filter[index].nameCourse!)
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
    _filter = listCourse!.where((model) {
          return model.nameCourse!.toLowerCase().contains(query.trim().toLowerCase());
        }).toList();
    return ListView.builder(
      itemCount: _filter.length,
      itemBuilder: (_, index) {
        return GestureDetector(
          child: ListTile(
            title: Text(_filter[index].nameCourse!),
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