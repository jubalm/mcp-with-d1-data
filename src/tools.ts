import { createTextResult } from './utils'

/**
 * Executes a query against the compliance database.
 * @param sql The SQL query string.
 * @param noCache Whether to bypass the cache.
 * @param db The database instance.
 * @param cache The cache instance.
 * @returns The query result as a JSON string.
 */
export async function executeQuery({ sql, noCache = false, db, cache }: {
	sql: string
	noCache?: boolean
	db: D1Database
	cache: KVNamespace<string>
}) {
	// Check cache for existing result
	const cachedResult = !noCache ? await cache.get(sql, "text") : null
	if (cachedResult) {
		return createTextResult(
			JSON.stringify({
				source: "cache",
				result: JSON.parse(cachedResult),
			})
		)
	}

	try {
		// Execute query on the database
		const dbQueryResult = await db.prepare(sql).run()
		const resultString = JSON.stringify(dbQueryResult)

		// Store result in cache
		await cache.put(sql, resultString, { expirationTtl: 60 })

		return createTextResult(
			JSON.stringify({
				source: "database",
				result: dbQueryResult,
			})
		)
	} catch (error) {
		return createTextResult(
			JSON.stringify({
				error: true,
				message: `Error executing query: ${error instanceof Error ? error.message : "Unknown error"}`,
			})
		)
	}
}

/**
 * Parses the schema of a database table.
 * @param db The database instance.
 * @param tableName The name of the table to introspect.
 * @returns The schema details of the table.
 */
export async function retrieveTableSchema(db: D1Database, tableName?: string) {
	if (tableName) {
		try {
			// Get column details for the specified table
			const columns = await db.prepare(`PRAGMA table_info(${tableName});`).all()
			const foreignKeys = await db.prepare(`PRAGMA foreign_key_list(${tableName});`).all()

			return createTextResult(
				JSON.stringify({
					table: tableName,
					columns: columns,
					foreignKeys: foreignKeys,
				})
			)
		} catch (error) {
			return createTextResult(
				JSON.stringify({
					error: true,
					message: `Error retrieving schema for table '${tableName}': ${error instanceof Error ? error.message : "Unknown error"}`,
				})
			)
		}
	} else {
		try {
			// Get a list of all tables
			const tables = await db.prepare("SELECT name FROM sqlite_master WHERE type='table';").all()

			// Ensure tables is an array
			const tablesArray = Array.isArray(tables.results) ? tables.results : []

			const schema = await Promise.all(
				tablesArray.map(async (table) => {
					const tableName = (table as { name: string }).name
					try {
						const columns = await db.prepare(`PRAGMA table_info(${tableName});`).all()
						const foreignKeys = await db.prepare(`PRAGMA foreign_key_list(${tableName});`).all()

						return {
							name: tableName,
							columns: columns,
							foreignKeys: foreignKeys,
						}
					} catch (error) {
						return {
							name: tableName,
							error: true,
							message: `Error retrieving schema for table '${tableName}': ${error instanceof Error ? error.message : "Unknown error"}`,
						}
					}
				})
			)

			return createTextResult(
				JSON.stringify({
					tables: schema,
				})
			)
		} catch (error) {
			return createTextResult(
				JSON.stringify({
					error: true,
					message: `Error retrieving table list: ${error instanceof Error ? error.message : "Unknown error"}`,
				})
			)
		}
	}
}
