return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    local ok, treesitter = pcall(require, "nvim-treesitter")
    if not ok then
      vim.schedule(function()
        vim.notify(
          "nvim-treesitter (main) is required for this config. Run :Lazy sync.",
          vim.log.levels.WARN
        )
      end)
      return
    end
    if type(treesitter.install) ~= "function" then
      vim.schedule(function()
        vim.notify("Detected old nvim-treesitter API. Run :Lazy sync to switch to main branch.", vim.log.levels.WARN)
      end)
      return
    end

    treesitter.setup({})

    treesitter.install({
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
    })

    local group = vim.api.nvim_create_augroup("GriviarTreesitter", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    -- use bash parser for zsh files
    vim.treesitter.language.register("bash", "zsh")
  end,
}
