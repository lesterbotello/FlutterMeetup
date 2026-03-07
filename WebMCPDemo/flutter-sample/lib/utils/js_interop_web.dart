import 'dart:js_interop';
import 'dart:js_interop_unsafe';

void exportAddTodo(
  void Function(String title, [String? dueDateIso, String? projectId]) addTodo,
) {
  globalContext.setProperty('addTodo'.toJS, addTodo.toJS);
}
