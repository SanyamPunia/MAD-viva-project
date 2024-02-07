/**
 * Problem Statement
 * You are building a user authentication system for a mobile application. Create mixins Authenticator and AuthorizationManager to handle user authentication and authorization functionalities, respectively 
 * Implement these mixins in the User class to authenticate users during login and authorize access to specific resources based on user roles and permissions. You can use different ways to authenticate & 
 * authorize a user
 */

mixin Authenticator {
  static final Map<String, String> users = {
    'user1': 'password1',
    'user2': 'password2',
  };

  bool authenticateUser(String username, String password) {
    if (users.containsKey(username) && users[username] == password) {
      print('User $username authenticated successfully');
      return true;
    } else {
      print('Invalid username or password');
      return false;
    }
  }
}

mixin AuthorizationManager {
  static final Map<String, List<String>> userRoles = {
    'user1': ['read'],
    'user2': ['read', 'write'],
  };

  bool authorizeUser(String username, String resource, String action) {
    if (userRoles.containsKey(username) &&
        userRoles[username]!.contains(action)) {
      print('User $username is authorized to $action $resource');
      return true;
    } else {
      print('User $username is not authorized to $action $resource');
      return false;
    }
  }
}

// User class implementing Authenticator and AuthorizationManager mixins
/**
 * Mixin is a feature which allows class to include functionalities from other classes
 * Implemented using `with` keywords
 */
class User with Authenticator, AuthorizationManager {
  final String username;

  User(this.username);

  bool login(String password) {
    return authenticateUser(username, password);
  }

  bool hasPermission(String resource, String action) {
    return authorizeUser(username, resource, action);
  }
}

void main() {
  // String? user1 = stdin.readLineSync();
  var user1 = User('user1');
  var user2 = User('user2');

  user1.login('password1');
  user2.login('password2');

  user1.hasPermission('document1', 'read'); // read access for doc 1
  user2.hasPermission('document1', 'write'); // write access for doc 1
  user1.hasPermission('document2', 'write'); // write acecss for doc 2
}
