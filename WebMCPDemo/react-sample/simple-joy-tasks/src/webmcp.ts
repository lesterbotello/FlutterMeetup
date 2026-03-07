export const createTaskTool = {
    execute: async (args: any) => {
        const title = args.title;
        if (!title || typeof title !== "string" || !title.trim()) {
            return "Task title is required";
        }

        let todos = [];
        try {
            const raw = localStorage.getItem("webmcp-todos");
            if (raw) {
                todos = JSON.parse(raw);
            }
        } catch (e) {
            console.error("Failed to parse todos", e);
        }

        const todo = {
            id: crypto.randomUUID(),
            text: title.trim(),
            completed: false,
            createdAt: new Date().toISOString(),
        };

        todos.unshift(todo);
        localStorage.setItem("webmcp-todos", JSON.stringify(todos));
        window.dispatchEvent(new Event("webmcp-todos-updated"));

        return `Task "${todo.text}" created successfully.`;
    },
    name: "createTask",
    description: "Create a new task",
    inputSchema: {
        type: "object",
        properties: {
            title: {
                type: "string",
                description: "Title of the task",
            },
        },
        required: ["title"],
    },
}

export function registerTools() {
    const modelContext = (window.navigator as any).modelContext;
    if (modelContext) {
        modelContext.registerTool(createTaskTool);
    }
}

registerTools();