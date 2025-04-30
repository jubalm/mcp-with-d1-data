import { CallToolResultSchema, type CallToolResult } from '@modelcontextprotocol/sdk/types.js'

const contentSchema = CallToolResultSchema.shape.content.element

export const createTextResult = (text: string) => {
	const result: CallToolResult = { content: [] }
	const parsed = contentSchema.safeParse({ type: 'text', text })
	if (parsed.success) result.content.push(parsed.data)
	return result
}
