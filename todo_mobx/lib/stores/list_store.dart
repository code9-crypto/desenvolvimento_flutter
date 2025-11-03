import 'package:mobx/mobx.dart';
import 'package:todomobx/stores/todo_store.dart';

part 'list_store.g.dart';

class ListStore = _ListStore with _$ListStore;

abstract class _ListStore with Store{

  @observable
  String newTodoTitle = "";
  @action
  void setNewTitle(String texto) => newTodoTitle = texto;

  ObservableList<TodoStore> todoList = ObservableList<TodoStore>();
  @action
  void addTodo(){
    todoList.insert(0, TodoStore(newTodoTitle));
    newTodoTitle = "";
  }

}