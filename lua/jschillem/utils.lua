local M = {}

--- Loads environment variables from a .env file with caching.
-- This function reads the .env file from the Neovim config directory,
-- parses its contents, and stores the result in a cache. Subsequent
-- calls return the cached result without reading the file again.
--
-- @return table A table containing the environment variables as key-value pairs.
--
-- @usage local env = require('jschillem.utils').load_env()
--
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
	local global_ts = "/home/jschillem/.nvm/versions/node/v20.15.1/lib/node_modules/typescript/lib"
	local found_ts = ""
	local function check_dir(path)
		local ts_path = table.concat({ path, "node_modules", "typescript", "lib" })
		if vim.uv.fs_stat(ts_path) then
			found_ts = ts_path
			return true
		end
	end
	if util.search_ancestors(root_dir, check_dir) then
		return found_ts
	else
		return global_ts
	end
end

--- Function for finding the Godot project root directory.
--- @return string?
local function find_godot_project_root()
	local cwd = vim.fn.getcwd()
	local search_paths = { "", "/.." }

	for _, relative_path in ipairs(search_paths) do
		local proj_file = cwd .. relative_path .. "/project.godot"
		if vim.uv.fs_stat(proj_file) then
			return cwd .. relative_path
		end
	end

	return nil
end

--- Function to check if server is already running.
--- @return boolean
local function is_server_running(project_path)
	local server_pipe = project_path .. "/server.pipe"
	return vim.uv.fs_stat(server_pipe) ~= nil
end

--- Function to start Godot server if needed.
--- @return boolean
function M.start_godot_server_if_needed()
	local godot_project_path = find_godot_project_root()

	if godot_project_path and not is_server_running(godot_project_path) then
		vim.fn.serverstart(godot_project_path .. "/server.pipe")
		return true
	end

	return false
end

return M
