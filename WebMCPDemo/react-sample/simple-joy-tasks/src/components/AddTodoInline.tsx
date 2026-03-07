import { useState, useRef } from "react";
import { Plus } from "lucide-react";

interface Props {
  onAdd: (text: string) => void;
}

export function AddTodoInline({ onAdd }: Props) {
  const [open, setOpen] = useState(false);
  const [value, setValue] = useState("");
  const inputRef = useRef<HTMLInputElement>(null);

  const handleOpen = () => {
    setOpen(true);
    setTimeout(() => inputRef.current?.focus(), 0);
  };

  const handleSubmit = () => {
    if (value.trim()) {
      onAdd(value);
      setValue("");
    }
    // keep open for rapid entry
  };

  const handleKeyDown = (e: React.KeyboardEvent) => {
    if (e.key === "Enter") handleSubmit();
    if (e.key === "Escape") {
      setOpen(false);
      setValue("");
    }
  };

  if (!open) {
    return (
      <button
        onClick={handleOpen}
        className="flex items-center gap-2 w-full px-4 py-3 text-sm text-muted-foreground hover:text-primary transition-colors group"
      >
        <span className="w-5 h-5 rounded-full flex items-center justify-center group-hover:bg-primary group-hover:text-primary-foreground transition-colors">
          <Plus className="w-4 h-4" />
        </span>
        Add task
      </button>
    );
  }

  return (
    <div className="px-4 py-3 border border-primary/30 rounded-lg mx-1 mb-1 bg-card">
      <input
        ref={inputRef}
        value={value}
        onChange={(e) => setValue(e.target.value)}
        onKeyDown={handleKeyDown}
        placeholder="Task name"
        className="w-full bg-transparent text-sm text-foreground placeholder:text-muted-foreground outline-none mb-3"
      />
      <div className="flex items-center gap-2 justify-end">
        <button
          onClick={() => { setOpen(false); setValue(""); }}
          className="text-xs px-3 py-1.5 rounded-md text-muted-foreground hover:bg-accent transition-colors"
        >
          Cancel
        </button>
        <button
          onClick={handleSubmit}
          disabled={!value.trim()}
          className="text-xs px-3 py-1.5 rounded-md bg-primary text-primary-foreground hover:opacity-90 transition-opacity disabled:opacity-40"
        >
          Add task
        </button>
      </div>
    </div>
  );
}
