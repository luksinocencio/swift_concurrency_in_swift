import SwiftUI

struct TodoListView: View {
    private var todoListViewModel: TodoListViewModel = TodoListViewModel()
    
    var body: some View {
        NavigationStack {
            List(todoListViewModel.todos, id: \.id) { todo in
                Text(verbatim: todo.title)
            }
            .navigationTitle(Text(verbatim: "ToDo List"))
        }
        .task {
            await todoListViewModel.populateTodos()
        }
    }
}

#Preview {
    TodoListView()
}
