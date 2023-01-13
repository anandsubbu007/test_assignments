import 'package:equatable/equatable.dart';

class BaseState extends Equatable {
  const BaseState();

  @override
  List<Object?> get props => throw UnimplementedError();
}
