import { useTodos } from "@/hooks/useTodos";
import { TodoItem } from "@/components/TodoItem";
import { AddTodoInline } from "@/components/AddTodoInline";
import { CheckCircle2, Inbox } from "lucide-react";

const Index = () => {
  const { pending, completed, addTodo, toggleTodo, deleteTodo } = useTodos();

  return (
    <div className="min-h-screen bg-background">
      <div className="max-w-2xl mx-auto px-4 py-12">
        {/* Header */}
        <div className="mb-8">
          <h1 className="text-2xl font-semibold text-foreground tracking-tight">Today</h1>
          <p className="text-sm text-muted-foreground mt-1">
            {pending.length === 0
              ? "All clear! Enjoy your day."
              : `${pending.length} task${pending.length !== 1 ? "s" : ""} remaining`}
          </p>
        </div>

        {/* Pending todos */}
        <div className="bg-card rounded-xl border border-border shadow-sm overflow-hidden">
          {pending.length === 0 && completed.length === 0 && (
            <div className="flex flex-col items-center justify-center py-16 text-muted-foreground">
              <Inbox className="w-12 h-12 mb-3 opacity-30" />
              <p className="text-sm font-medium">No tasks yet</p>
              <p className="text-xs mt-1">Add your first task below</p>
            </div>
          )}

          {pending.map((todo) => (
            <TodoItem key={todo.id} todo={todo} onToggle={toggleTodo} onDelete={deleteTodo} />
          ))}

          <AddTodoInline onAdd={addTodo} />
        </div>

        {/* Completed section */}
        {completed.length > 0 && (
          <div className="mt-8">
            <div className="flex items-center gap-2 mb-3 px-1">
              <CheckCircle2 className="w-4 h-4 text-success" />
              <span className="text-xs font-medium text-muted-foreground uppercase tracking-wider">
                Completed ({completed.length})
              </span>
            </div>
            <div className="bg-card rounded-xl border border-border shadow-sm overflow-hidden">
              {completed.map((todo) => (
                <TodoItem key={todo.id} todo={todo} onToggle={toggleTodo} onDelete={deleteTodo} />
              ))}
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

export default Index;
