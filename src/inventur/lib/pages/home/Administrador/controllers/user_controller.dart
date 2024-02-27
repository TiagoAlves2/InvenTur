import 'package:flutter/material.dart';
import 'package:inventur/models/user_model.dart';

class UserController extends ChangeNotifier {
  int _countSelectedUsers = 0;
  List<UserModel> _users = [];
  bool _allSelectedUsers = false;
  String _usersFilteredStatus = 'Todos';
  String _usersFilteredAccessLevel = 'Pesquisador';

  final List<UserModel> _selectedUsers = [];
  final List<UserModel> _filteredUsers = [];

  final List<String> _accessLevels = ['Pesquisador', 'Administrador'];
  final List<String> statusItems = [
    'Aguardando Aprovação',
    'Ativo',
    'Não Ativo'
  ];
  final List<String> _statusFilters = [
    'Todos',
    'Ativo',
    'Não Ativo',
    'Aguardando Aprovação'
  ];

  List<String> get accessLeves => _accessLevels;
  List<String> get statusFilters => _statusFilters;
  int get countSelectedUsers => _countSelectedUsers;
  List<UserModel> get filteredUsers => _filteredUsers;
  String get usersFilteredStatus => _usersFilteredStatus;
  String get usersFilteredAccessLevel => _usersFilteredAccessLevel;

  bool get allSelectedUsers => _allSelectedUsers;

  void setAllSelectedUsers(bool marked) {
    _allSelectedUsers = marked;
    notifyListeners();
  }

  void populateFilteredUsers() {
    if (_selectedUsers.isNotEmpty) {
      unselectAllUsers();
    }

    if (_filteredUsers.isNotEmpty) {
      _filteredUsers.clear();
    }

    for (UserModel user in _users) {
      if (usersFilteredAccessLevel == _accessLevels[0] &&
          user.accessLevel == _accessLevels[0]) {
        switch (usersFilteredStatus) {
          case 'Todos':
            _filteredUsers.add(user);
            break;
          default:
            if (user.status == usersFilteredStatus) {
              _filteredUsers.add(user);
            }
            break;
        }
      } else if (usersFilteredAccessLevel == _accessLevels[1] &&
          user.accessLevel == _accessLevels[1]) {
        _filteredUsers.add(user);
      }
      notifyListeners();
    }
  }

  void setUsers(List<UserModel> users) {
    _users = users;
  }

  void selectUser({required UserModel user}) {
    if (!_selectedUsers.contains(user)) {
      _selectedUsers.add(user);
      user.isSelected = true;
      _countSelectedUsers++;
    }

    if (!allSelectedUsers && _selectedUsers.length == filteredUsers.length) {
      setAllSelectedUsers(true);
    }
    notifyListeners();
  }

  void unselectUser({required UserModel user}) {
    if (allSelectedUsers) setAllSelectedUsers(false);
    _selectedUsers.remove(user);
    user.isSelected = false;
    _countSelectedUsers--;
    notifyListeners();
  }

  void selectAllUsers() {
    for (UserModel user in _filteredUsers) {
      selectUser(user: user);
    }
  }

  void unselectAllUsers() {
    for (UserModel user in _filteredUsers) {
      if (user.isSelected) {
        unselectUser(user: user);
      }
    }
  }

  void setUserStatus(String status, UserModel user) {
    user.status = status;
    notifyListeners();
  }

  void changeSelectedUsersStatus(String status) {
    for (UserModel user in _filteredUsers) {
      if (user.isSelected) {
        setUserStatus(status, user);
        unselectUser(user: user);
      }
    }
    populateFilteredUsers();
  }

  void filterUsersByStatus(String status) {
    _usersFilteredStatus = status;
    notifyListeners();
    populateFilteredUsers();
  }

  void filterUsersByAccessLevel(String accessLevel) {
    _usersFilteredAccessLevel = accessLevel;
    notifyListeners();
    populateFilteredUsers();
  }

  void searchUsers(String text) {
    List<UserModel> auxUsers = [];

    if (_selectedUsers.isNotEmpty) {
      unselectAllUsers();
    }
    
    text = text.toLowerCase();
    for (UserModel user in _filteredUsers) {
      if (user.nome.toLowerCase().contains(text)) {
        auxUsers.add(user);
      } else if (user.cpf.contains(text)) {
        auxUsers.add(user);
      } else if (user.email.toLowerCase().contains(text)) {
        auxUsers.add(user);
      }
    }

    _filteredUsers.clear();
    for (UserModel user in auxUsers){
      _filteredUsers.add(user);
    }
    notifyListeners();
  }

  Color? statusColor(String status) {
    switch (status) {
      case 'Aguardando Aprovação':
        return Colors.orange[600];
      case 'Ativo':
        return Colors.green[600];
      case 'Não Ativo':
        return Colors.red[600];
    }
    return null;
  }
}