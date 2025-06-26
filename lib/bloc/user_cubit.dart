import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/user_model.dart';
import '../api/api_service.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

// lists to fetch all users and filter users while searching
  List<User> _allUsers = [];
  List<User> _filteredUsers = [];

  // load users from ApiService and emit appt. state
  Future<void> loadUsers() async {
    emit(UserLoading());
    try {
      _allUsers = await ApiService.fetchUsers();
      _filteredUsers = List.from(_allUsers);
      emit(UserLoaded(List.from(_filteredUsers)));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  //! add a new user locally store it as a User Model
  void addUser(User user) {
    _allUsers.insert(0, user);
    _filteredUsers = List.from(_allUsers);
    emit(UserLoaded(List.from(_filteredUsers)));
  }

// filter users based on qery and add them in filteredUsers
  void search(String query) {
    if (query.isEmpty) {
      _filteredUsers = List.from(_allUsers);
    } else {
      // convert to lowercase to avoid case sensitive bugs!
      _filteredUsers = _allUsers.where((user) {
        return user.name.toLowerCase().contains(query.toLowerCase()) ||
               user.email.toLowerCase().contains(query.toLowerCase()) ||
               user.phone.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    emit(UserLoaded(List.from(_filteredUsers)));
  }
} 