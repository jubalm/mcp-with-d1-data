# MCP Server: Demo

## Overview

This repository serves as a demonstration of building an MCP (Model Context Protocol) server that can access and query actual database information. Uses
the `@modelcontextprotocol/sdk` library leveraging Cloudflare's `MCPAgent` to implement tools, manage resources, and a D1 database.

## Features

### Database

The project integrates with a D1 database (`mcp-agent-d1-data`) to retrieve data but you should be able to work with any database with some minor adjustments on the tools. Also included some niceties:

- **Schema Management**: SQL migration files (`up.sql`, `down.sql`, `seed.sql`) in the `db/` directory manage the database schema and seed data.

### MCP Server (`MyMCP`)

The `MyMCP` class extends the `McpAgent` class from the `@modelcontextprotocol/sdk` library. It acts as the core server implementation, providing server sent events (SSE) as a foundational transport.

- **Durable Object**: The server is implemented as a Durable Object, which allows stateful interactions and long process operations. It also comes with hibernation built-in when idle.

### Query Tool

The `query` tool is designed to interact with the database by providing an interface where the LLM can send SQL queries onto the database. Use with care in production environments and practice proper authorization safeguards.

### Introspection Tool

The `schema-introspection` tool is particularly useful to help the LLM understand the structure of the database to produce a more accurate query design.

### Integration Tests

Included integration tests in the `tests/` directory to get started. Validate the functionality of the MCP server and its tools, or use the tests for TDD.

```bash
npm run test
```

## Project Structure

```
📦 d1-mcp
├── package.json
├── README.md
├── tsconfig.json
├── vitest.config.js
├── worker-configuration.d.ts
├── wrangler.jsonc
├── db
│   ├── down.sql
│   ├── seed.sql
│   └── up.sql
├── public
│   └── index.html
├── src
│   ├── index.ts
│   ├── metadata.ts
│   ├── tools.ts
│   └── utils.ts
└── tests
    ├── index.test.ts
    └── tsconfig.json
```

## Getting Started

### Prerequisites

- Node.js
- Cloudflare Workers CLI (`wrangler`)

### Installation

1. Clone the repository.
2. Install dependencies:
   ```bash
   npm install
   ```

### Development

- Start the development server:
  ```bash
  npm run dev
  ```

### Deployment

- Deploy to Cloudflare Workers:
  ```bash
  npm run deploy
  ```

## License

This project is licensed under the MIT License.
