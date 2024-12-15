# backend_agent.md

## Opinionated, Concise Approach
Don’t overcomplicate. Ideally, no server at all: bundle `questions.json` in-app. If needed:
- **Node.js**: One static JSON endpoint, no DB, no auth.
- **Low Maintenance**: Just serve the JSON. Updates mean replacing the JSON file.
- **No Middleware**: Keep it simple.
 