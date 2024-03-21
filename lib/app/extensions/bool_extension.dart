// Author: drunrapakon sangraung 630510620

extension ListBoolExtension on List<bool> {
  bool get atLeastOneTrue {
    return any((e) => (e == true));
  }
}
