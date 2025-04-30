import { McpAgent } from "agents/mcp"
import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js"
import { z } from "zod"
import { executeQuery, retrieveTableSchema } from "./tools"
import serverMetadata from './metadata'

export class MyMCP extends McpAgent<Env> {
	server = new McpServer(serverMetadata);

	async init() {

		this.server.tool(
			"query",
			"Query compliance database. This tool allows querying the compliance database with SQL. Input should include a valid SQL query string and an optional 'noCache' flag. Results are returned in JSON format.",
			{
				sql: z.string().describe("A valid SQL query string to execute against the compliance database."),
				noCache: z.boolean().optional().describe("If true, bypasses the cache and queries the database directly."),
			},
			async ({ sql, noCache = false }) => {
				const result = await executeQuery({ sql, noCache, db: this.env.DB, cache: this.env.DB_CACHE })
				return result
			}
		)

		this.server.tool(
			"schema-introspection",
			"Retrieve database schema information, including tables, columns, data types, and relationships. Optionally, specify a table name to get details for a specific table.",
			{
				tableName: z.string().optional().describe("The name of the table to introspect. If omitted, returns schema for all tables."),
			},
			async ({ tableName }) => {
				const result = await retrieveTableSchema(this.env.DB, tableName)
				return result
			}
		)
	}
}

export default MyMCP.mount("/sse", { binding: "MY_MCP" })
