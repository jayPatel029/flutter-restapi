import 'package:equatable/equatable.dart';
import '../models/user_model.dart';

/// base class for all states
abstract class UserState extends Equatable {
  const UserState();
  @override
  List<Object?> get props => [];
}

// initial state before any situation 

class UserInitial extends UserState {}

// states when data/users are being loaded and after loaded

class UserLoading extends UserState {}
class UserLoaded extends UserState {
  final List<User> users;
  const UserLoaded(this.users);
  @override
  List<Object?> get props => [users];
}
// error state: occurs extracts message to display
class UserError extends UserState {
  final String message;
  const UserError(this.message);
  @override
  List<Object?> get props => [message];
} 