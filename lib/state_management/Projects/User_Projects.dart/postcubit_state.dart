import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:fym_test_1/models/Project.dart';

abstract class PostUserProjects extends Equatable {
  const PostUserProjects();

  @override
  List<Object> get props => [];
}

class PostUserProjectInitial extends PostUserProjects {}

class PostUserProjectLoading extends PostUserProjects {
  const PostUserProjectLoading();
  @override
  List<Object> get props => [];
}

class PostUserProjectSuccess extends PostUserProjects {}

class PostUserProjectFail extends PostUserProjects {
  final String error;

  PostUserProjectFail(this.error);
  @override
  List<Object> get props => [error];
}
