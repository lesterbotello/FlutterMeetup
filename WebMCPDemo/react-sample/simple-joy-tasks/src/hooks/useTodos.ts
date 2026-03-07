import { useState, useCallback, useEffect } from "react";

export interface Todo {
  id: string;
  text: string;
  completed: boolean;
  createdAt: Date;
}

const STORAGE_KEY = "webmcp-todos";

function loadTodos(): Todo[] {
  try {
    const raw = localStorage.getItem(STORAGE_KEY);
    if (!raw) return [];
    return JSON.parse(raw).map((t: any) => ({ ...t, createdAt: new Date(t.createdAt) }));
  } catch {
    return [];
  }
}

function saveTodos(todos: Todo[]) {
  localStorage.setItem(STORAGE_KEY, JSON.stringify(todos));
}

export function useTodos() {
  const [todos, setTodos] = useState<Todo[]>(loadTodos);

  useEffect(() => {
    const handleStorageUpdate = () => {
      setTodos(loadTodos());
    };

    window.addEventListener("webmcp-todos-updated", handleStorageUpdate);
    window.addEventListener("storage", handleStorageUpdate);

    return () => {
      window.removeEventListener("webmcp-todos-updated", handleStorageUpdate);
      window.removeEventListener("storage", handleStorageUpdate);
    };
  }, []);

  const update = useCallback((next: Todo[]) => {
    setTodos(next);
    saveTodos(next);
  }, []);

  const addTodo = useCallback((text: string) => {
    if (!text.trim()) return;
    const todo: Todo = {
      id: crypto.randomUUID(),
      text: text.trim(),
      completed: false,
      createdAt: new Date(),
    };
    update([todo, ...loadTodos()]);
  }, [update]);

  const toggleTodo = useCallback((id: string) => {
    const current = loadTodos();
    update(current.map((t) => (t.id === id ? { ...t, completed: !t.completed } : t)));
  }, [update]);

  const deleteTodo = useCallback((id: string) => {
    update(loadTodos().filter((t) => t.id !== id));
  }, [update]);

  const pending = todos.filter((t) => !t.completed);
  const completed = todos.filter((t) => t.completed);

  return { todos, pending, completed, addTodo, toggleTodo, deleteTodo };
}
