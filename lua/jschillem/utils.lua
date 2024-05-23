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

--- Get the path to the typescript server (preferably from the node_modules directory),
--- if it exists in the project directory. If not, return the global typescript server path.
--- @param root_dir string: The root directory of the project
--- @return string: The path to the typescript server
function M.get_typescript_server_path(root_dir)
	local util = require("lspconfig.util")
	local global_ts = "/home/jschillem/.nvm/versions/node/v20.11.1/lib/node_modules/typescript/lib"
	local found_ts = ""
	local function check_dir(path)
		found_ts = util.path.join(path, "node_modules", "typescript", "lib")
		if util.path.exists(found_ts) then
			return path
		end
	end
	if util.search_ancestors(root_dir, check_dir) then
		return found_ts
	else
		return global_ts
	end
end

return M
