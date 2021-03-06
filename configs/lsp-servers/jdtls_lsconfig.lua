-- File Documentation
-- Filename: jdtls_lsconfig.lua
-- Author: nonomain
-- last updated: 31/01/22 17:36:59
-- Description:
--	configuration for the lsp of eclipse-jdt

local util = require 'lspconfig.util'
local sysname = vim.loop.os_uname().sysname

local env = {
  HOME = vim.loop.os_homedir(),
  JDTLS_HOME = vim.g.java_ls_path,
  JAVA_HOME = vim.g.jdt_java_home_path,
  WORKSPACE = vim.g.jdt_workspace,
  JAR = vim.g.jdt_jar_path,
}

local function get_workspace_dir()
  return env.WORKSPACE and env.WORKSPACE or util.path.join(env.HOME, 'workspace')
end

local function get_java_executable()
	if sysname:match 'Windows' then
		return env.JAVA_HOME .. '.exe'
	else
		return env.JAVA_HOME
	end
end

local function get_jdtls_config()
	if sysname:match 'Linux' then
		return util.path.join(env.JDTLS_HOME, 'config_linux')
	elseif sysname:match 'Darwin' then
		return util.path.join(env.JDTLS_HOME, 'config_mac')
	elseif sysname:match 'Windows' then
		return util.path.join(env.JDTLS_HOME, 'config_win')
	else
		return util.path.join(env.JDTLS_HOME, 'config_linux')
	end
end


require'lspconfig'.jdtls.setup
{
	cmd = {
		get_java_executable(),
		'-Declipse.application=org.eclipse.jdt.ls.core.id1',
		'-Dosgi.bundles.defaultStartLevel=4',
		'-Declipse.product=org.eclipse.jdt.ls.core.product',
		'-Dlog.protocol=true',
		'-Dlog.level=ALL',
		'-Xms1g',
		'-Xmx2G',
		'--add-modules=ALL-SYSTEM',
		'--add-opens',
		'java.base/java.util=ALL-UNNAMED',
		'--add-opens',
		'java.base/java.lang=ALL-UNNAMED',
		'-jar',
		env.JAR,
		'-configuration',
		get_jdtls_config(),
		'-data',
		get_workspace_dir(),
    };
	filetypes = {
		"java",
	};
	on_attach = vim.g.on_attach_lspconfig_global;
	handlers = vim.g.handlers_lspconfig_global;
}
