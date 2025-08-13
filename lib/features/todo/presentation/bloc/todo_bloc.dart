import 'package:auth_todo/features/todo/domain/entities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<TodoFetch>((event, emit) async {
      emit(TodoLoading());
      try {
        await Future.delayed(Duration(seconds: 2));
        final todos = [
          Todo(id: '1', title: 'Todo 1'),
          Todo(id: '2', title: 'Todo 2', isCompleted: true),
          Todo(id: '3', title: 'Todo 3', isCompleted: true),
          Todo(id: '4', title: 'Todo 4', isCompleted: true),
          Todo(id: '5', title: 'Todo 5', isCompleted: true),
          Todo(id: '6', title: 'Todo 6', isCompleted: true),
          Todo(id: '7', title: 'Todo 7', isCompleted: true),
          Todo(id: '8', title: 'Todo 8', isCompleted: true),
          Todo(id: '9', title: 'Todo 9', isCompleted: true),
          Todo(id: '10', title: 'Todo 10', isCompleted: true),
        ];
        emit(TodoLoaded(todos));
      } catch (e) {
        emit(TodoError('Failed to load todos'));
      }
    });
  }
}
