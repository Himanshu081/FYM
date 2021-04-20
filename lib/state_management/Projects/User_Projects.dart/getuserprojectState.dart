import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
import 'package:fym_test_1/models/Project.dart';

abstract class GetUserProjects extends Equatable {
  const GetUserProjects();

  @override
  List<Object> get props => [];
}

class GetUserProjectInitial extends GetUserProjects {}

class GetUserProjectLoading extends GetUserProjects {
  const GetUserProjectLoading();
  @override
  List<Object> get props => [];
}

class GetUserProjectSuccess extends GetUserProjects {
  final List<Project> userProjects;

  GetUserProjectSuccess(this.userProjects);
  @override
  List<Object> get props => [userProjects];
}

class GetUserProjectFail extends GetUserProjects {
  final String error;

  GetUserProjectFail(this.error);
  @override
  List<Object> get props => [error];
}
