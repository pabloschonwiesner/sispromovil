import 'package:equatable/equatable.dart';

abstract class PlantasState extends Equatable {
  PlantasState([List props = const []]);
}

class PlantasEmpty extends PlantasState {}

class PlantaLoading extends PlantasState {}

// class PlantasLoaded extends PlantasState {
//   final ParamsModel 
// }