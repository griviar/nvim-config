return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    local languages = {
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
    }

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

    local function plugin_revision()
      local lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json"
      if vim.fn.filereadable(lockfile) == 1 then
        local ok_read, content = pcall(vim.fn.readfile, lockfile)
        if ok_read and content and #content > 0 then
          local ok_decode, lock = pcall(vim.json.decode, table.concat(content, "\n"))
          if ok_decode and lock and lock["nvim-treesitter"] and lock["nvim-treesitter"].commit then
            return lock["nvim-treesitter"].commit
          end
        end
      end
      return "unknown"
    end

    local function ensure_parsers_once_per_revision()
      local rev = plugin_revision()
      local marker = vim.fs.joinpath(vim.fn.stdpath("data"), "site", ".griviar_treesitter_parsers_rev")
      local last_rev = nil
      if vim.fn.filereadable(marker) == 1 then
        local ok_read, lines = pcall(vim.fn.readfile, marker)
        if ok_read and lines and lines[1] then
          last_rev = lines[1]
        end
      end
      if rev == last_rev then
        return
      end

      treesitter.install(languages)

      local ok_mkdir = pcall(vim.fn.mkdir, vim.fn.fnamemodify(marker, ":h"), "p")
      if ok_mkdir then
        pcall(vim.fn.writefile, { rev }, marker)
      end
    end

    vim.schedule(ensure_parsers_once_per_revision)

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
