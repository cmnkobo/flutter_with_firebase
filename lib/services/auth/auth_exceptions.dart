//Login exception
class UserNotFoundException implements Exception {}

class WrongPasswordAuthExcception implements Exception {}

//register exception

class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUSeAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

//generic exceptions

class GenericAuthException implements Exception {}

class UserNotLoggedInException implements Exception {}
