# api_agent.md

## Opinionated, Concise Approach
If an API is mandatory:
- **One GET Endpoint**: `/questions.json` returns entire dataset.
- **No Auth, No Params**: Just static content.
- **No Pagination**: The file is small. Simplicity > complexity.
- **Documentation**: One line: "GET /questions.json returns the conversation data."
 