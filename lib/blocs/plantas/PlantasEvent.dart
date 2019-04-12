import 'package:equatable/equatable.dart';

abstract class PlantasEvent extends Equatable {
  PlantasEvent([List props = const []]) : super(props);
}

class FetchPlantas extends PlantasEvent {
  final int id;
  FetchPlantas({this.id});
}