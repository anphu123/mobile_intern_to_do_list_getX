import 'dart:developer' as developer;
import 'package:get/get.dart';
import '../../core/errors/error_handler.dart';
import '../../core/utils/validators.dart';
import '../../data/model/todo_model.dart';
import '../login/db_helper.dart';

class HomeController extends GetxController {
  final todos = <TodoModel>[].obs;
  final isLoading = false.obs;

  void _log(String message, {bool isError = false, Object? error}) {
    final prefix = isError ? '[ERROR]' : '[INFO]';
    developer.log(
      '$prefix $message',
      name: 'HomeController',
      error: error,
    );
  }

  @override
  void onInit() {
    super.onInit();
    _log('Khởi tạo HomeController');
    loadTodos();
  }

  Future<void> loadTodos() async {
    _log('Bắt đầu tải danh sách Todo từ SQLite...');
    try {
      isLoading.value = true;
      final data = await DatabaseHelper.instance.getTodos();
      todos.assignAll(data);
      _log('Tải thành công ${data.length} item(s)');
    } catch (e, stackTrace) {
      _log('Lỗi khi tải Todos: $e', isError: true, error: e);
      developer.log('StackTrace:', name: 'HomeController', stackTrace: stackTrace);
      ErrorHandler.handle(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addTodo(String title) async {
    _log('Đang thực hiện thêm todo: "$title"');
    try {
      final validTitle = Validators.todoTitle(title);
      final newTodo = TodoModel(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: validTitle,
      );

      // 1. Lưu vào SQLite
      await DatabaseHelper.instance.insertTodo(newTodo);
      _log('Đã lưu todo vào SQLite: [id: ${newTodo.id}, title: ${newTodo.title}]');

      // 2. Cập nhật state UI
      todos.add(newTodo);
      _log('Cập nhật UI hoàn tất. Tổng số item: ${todos.length}');
    } catch (e, stackTrace) {
      _log('Lỗi khi thêm Todo: $e', isError: true, error: e);
      developer.log('StackTrace:', name: 'HomeController', stackTrace: stackTrace);
      ErrorHandler.handle(e);
    }
  }

  Future<void> toggleTodo(String id) async {
    _log('Đang thay đổi trạng thái todo ID: $id');
    try {
      final index = todos.indexWhere((todo) => todo.id == id);
      if (index == -1) {
        _log('Không tìm thấy todo có ID: $id để cập nhật', isError: true);
        return;
      }

      final updatedStatus = !todos[index].isDone;

      // 1. Cập nhật trong SQLite
      await DatabaseHelper.instance.updateTodoStatus(id, updatedStatus);
      _log('Cập nhật SQLite thành công: ID $id -> isDone = $updatedStatus');

      // 2. Cập nhật UI
      todos[index].isDone = updatedStatus;
      todos.refresh();
      _log('Đã refresh UI state cho todo ID: $id');
    } catch (e, stackTrace) {
      _log('Lỗi khi toggle Todo [id: $id]: $e', isError: true, error: e);
      developer.log('StackTrace:', name: 'HomeController', stackTrace: stackTrace);
      ErrorHandler.handle(e);
    }
  }

  Future<void> removeTodo(String id) async {
    _log('Đang xóa todo ID: $id');
    try {
      // 1. Xóa trong SQLite
      await DatabaseHelper.instance.deleteTodo(id);
      _log('Đã xóa todo khỏi SQLite: ID $id');

      // 2. Xóa khỏi state UI
      todos.removeWhere((todo) => todo.id == id);
      _log('Đã xóa khỏi UI. Số lượng item còn lại: ${todos.length}');
    } catch (e, stackTrace) {
      _log('Lỗi khi xóa Todo [id: $id]: $e', isError: true, error: e);
      developer.log('StackTrace:', name: 'HomeController', stackTrace: stackTrace);
      ErrorHandler.handle(e);
    }
  }

  @override
  void onClose() {
    _log('Hủy HomeController');
    super.onClose();
  }
}