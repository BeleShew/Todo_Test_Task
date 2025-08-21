import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/todo_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final TodoController todoController = Get.put(TodoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Center(
        child: Obx(() {
          if (todoController.isLoading.value) {
            return const CircularProgressIndicator();
          }
          if (todoController.errorMessage.isNotEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(todoController.errorMessage.value),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => todoController.loadTodos(),
                  child: const Text('Retry'),
                ),
              ],
            );
          }
          return ListView.builder(
            itemCount: todoController.todos.length,
            itemBuilder: (context, index) {
              final todo = todoController.todos[index];
              return Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1.0),
                  ),
                ),
                child: ListTile(
                  title: Text(
                    todoController.capitalizeFirstLetter(todo.title),
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.black,
                    ),
                  ),
                  leading: Checkbox(
                    value: todo.completed,
                    onChanged: (bool? newValue) {
                      todoController.toggleTodoCompletion(todo.id);
                    },
                    activeColor: Colors.blue,
                  ),
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => todoController.loadTodos(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}