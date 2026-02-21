return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    -- `nvim-treesitter` main branch is a rewrite and removed `nvim-treesitter.configs`.
    -- Keep startup stable and show what to do if an incompatible version is installed.
    local ok, treesitter = pcall(require, "nvim-treesitter.configs")
    if not ok then
      vim.schedule(function()
        vim.notify(
          "Incompatible nvim-treesitter version detected. Run :Lazy restore (or :Lazy sync) to use the pinned master branch.",
          vim.log.levels.WARN
        )
      end)
      return
    end

    -- configure treesitter
    treesitter.setup({ -- enable syntax highlighting
      highlight = {
        enable = true,
      },
      -- enable indentation
      indent = { enable = true },
      -- ensure these language parsers are installed
      ensure_installed = {
        "json",
        "yaml",
        "html",
        "css",
        "markdown",
        "markdown_inline",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })

    -- use bash parser for zsh files
    vim.treesitter.language.register("bash", "zsh")
  end,
}
