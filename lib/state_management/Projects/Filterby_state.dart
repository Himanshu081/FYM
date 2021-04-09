import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class FilterByState extends Equatable {
  final bool filterbytitle;
  final bool filterbyskills;

  FilterByState({
    @required this.filterbytitle,
    @required this.filterbyskills,
  });

  FilterByState copyWith({
    bool filterbytitle,
    bool filterbyskills,
  }) {
    return FilterByState(
      filterbytitle: filterbytitle ?? this.filterbytitle,
      filterbyskills: filterbyskills ?? this.filterbyskills,
    );
  }

  @override
  List<Object> get props => [
        filterbyskills,
        filterbytitle,
      ];

  @override
  String toString() =>
      'FilterByState(filterbytitle: $filterbytitle, filterbyskills: $filterbyskills)';
}
