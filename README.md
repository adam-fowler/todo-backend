# Todo Backend

The Todo-Backend project defines a simple web API spec - for managing a todo list. Contributors implement that spec using various tech stacks. A spec runner verifies that each contribution implements the exact same API, by running an automated test suite which defines the API. 

This is the Hummingbird version of the Todo Backend. It uses [Fluent](https://github.com/vapor/fluent.kit) for it's database support.

## API

GET /todos - List all todos<br/>
POST /todos - Add a new todo<br/>
DELETE /todos - Delete all todos<br/>
GET /todos/:id - Return todo with id<br/>
PATCH /todos/:id - Edit todo with id<br/>
DELETE /todos/:id - Delete todo with id<br/>
