import { Check, Trash2 } from "lucide-react";
import type { Todo } from "@/hooks/useTodos";

interface Props {
  todo: Todo;
  onToggle: (id: string) => void;
  onDelete: (id: string) => void;
}

export function TodoItem({ todo, onToggle, onDelete }: Props) {
  return (
    <div className={`group flex items-center gap-3 px-4 py-3 border-b border-border last:border-b-0 transition-colors hover:bg-accent/50 todo-item-enter ${todo.completed ? "todo-item-complete" : ""}`}>
      <button
        onClick={() => onToggle(todo.id)}
        className={`todo-check flex-shrink-0 w-5 h-5 rounded-full border-2 flex items-center justify-center ${
          todo.completed
            ? "bg-primary border-primary"
            : "border-muted-foreground/40 hover:border-primary"
        }`}
      >
        {todo.completed && <Check className="w-3 h-3 text-primary-foreground" />}
      </button>

      <span className={`flex-1 text-sm leading-relaxed ${todo.completed ? "line-through text-muted-foreground" : "text-foreground"}`}>
        {todo.text}
      </span>

      <button
        onClick={() => onDelete(todo.id)}
        className="opacity-0 group-hover:opacity-100 transition-opacity p-1 rounded hover:bg-destructive/10 text-muted-foreground hover:text-destructive"
      >
        <Trash2 className="w-4 h-4" />
      </button>
    </div>
  );
}
