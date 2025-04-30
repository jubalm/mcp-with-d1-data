import { describe, it, expect } from "vitest"
import { Client } from "@modelcontextprotocol/sdk/client/index.js"
import { SSEClientTransport } from "@modelcontextprotocol/sdk/client/sse.js"
import serverMetadata from "../src/metadata.js"

declare module "cloudflare:test" {
	interface ProvidedEnv extends Env {}
}

const MCP_SERVER_URL = "http://localhost:8787/sse"

describe("Integration Tests", () => {
	const transport = new SSEClientTransport(new URL(MCP_SERVER_URL))
	const client = new Client({ name: "connection-test", version: "1.0.0" })

	it("should be able to connect with mcp client", async () => {
		await client.connect(transport)
		expect(client.getServerVersion()).toEqual(serverMetadata)
	})

	it("should be able to list tools", async () => {
		const { tools } = await client.listTools()
		expect(tools).toBeDefined()
		expect(tools.map(tool => tool.name)).toEqual(["query", "schema-introspection"])
	})

	it("should be able to introspect database tables", async () => {
		const result = await client.callTool({
			name: "schema-introspection",
			arguments: {}
		})
		expect(result.content).toBeDefined()
	})

	it("should be able to execute a query", async () => {
		const result = await client.callTool({
			name: "query",
			arguments: {
				sql: "SELECT * FROM vehicles",
			}
		})
		expect(result.content).toBeDefined()
	})
})
