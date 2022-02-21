import 'package:flutter_riverpod/flutter_riverpod.dart';

final helloWorldProvider = Provider((_) => 'Documents');

final selectedIndex = StateProvider<int>((ref) {
  return 0;
});

final is_Grid = StateProvider<bool>((ref) {
  return false;
});

final is_Descending = StateProvider<bool>((ref) {
  return false;
});

final list_Entry = StateProvider<List<String>>((ref) {
  return ['E Doc', 'B Form', 'C Paper', 'D Form', 'A Form', 'F Table'];
});

final search_Entry = StateProvider<List<String>>((ref) {
  return ['E Doc', 'B Form', 'C Paper', 'D Form', 'A Form', 'F Table'];
});
