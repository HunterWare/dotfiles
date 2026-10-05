-- clangd: optionally allow-list cross-toolchain drivers so clangd can ask them for their
-- system include paths (needed when the compile database names a cross g++/gcc).
-- The list is machine-specific, so it comes from the environment rather than this file:
--   export CLANGD_QUERY_DRIVER="/path/to/toolchains/**/bin/*g++,/path/to/toolchains/**/bin/*gcc"
-- (put it in ~/.localrc, which .zshrc/.bashrc source). Unset -> stock LazyVim clangd command.
return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local drivers = vim.env.CLANGD_QUERY_DRIVER
      if drivers and drivers ~= "" then
        opts.servers = opts.servers or {}
        opts.servers.clangd = opts.servers.clangd or {}
        local cmd = opts.servers.clangd.cmd or { "clangd" }
        table.insert(cmd, "--query-driver=" .. drivers)
        opts.servers.clangd.cmd = cmd
      end
    end,
  },
}
