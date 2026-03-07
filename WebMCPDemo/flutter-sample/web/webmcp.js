if (window.navigator && window.navigator.modelContext) {
    window.navigator.modelContext.registerTool({
        name: "addTodo",
        description: "Add a new item to the todo list",
        inputSchema: {
            type: "object",
            properties: {
                title: { type: "string" },
                dueDateIso: { type: "string" },
                projectId: { type: "string" }
            }
        },
        annotations: {
            readOnlyHint: "true"
        },
        execute: ({ title, dueDateIso, projectId }) => {
            // Execute the addTodo function in the Flutter app
            window.addTodo(title, dueDateIso, projectId);
            return { content: [{ type: "text", text: `Added todo: ${title}` }] };
        }
    });
}