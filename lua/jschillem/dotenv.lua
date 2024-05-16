local M = {}

--- Load environment variables from a .env file
--- @return table: A table with the environment variables (key-value pairs)
function M.load_env()
	local config_dir = vim.fn.stdpath("config")
	local env_file = config_dir .. "/.env"
	local env = {}
	for line in io.lines(env_file) do
		for k, v in string.gmatch(line, "([%w_]+)=([%w%p]+)") do
			env[k] = v
		end
	end
	return env
end

return M
