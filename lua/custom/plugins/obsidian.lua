return {
  "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = false,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
		workspaces = {
			{
				name = "notes",
				path = "~/Documents/teb_zab",
			},
		},
    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "daily-notes",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%Y-%m-%d",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      alias_format = "%B %-d, %Y",
      -- Optional, default tags to add to each new daily note created.
      default_tags = { "daily-notes" },
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = nil
    },
		completion = {
			nvim_cmp = true,
			min_chars = 2,
		},
		mappings = {
			-- overrides the 'gf' mapping to work on markdown/wiki links within your vault.
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
			-- toggle check-boxes.
			["<leader>ch"] = {
				action = function()
					return require("obsidian").util.toggle_checkbox()
				end,
				opts = { buffer = true },
			},
			-- smart action depending on context, either follow link or toggle checkbox.
			["<cr>"] = {
				action = function()
					return require("obsidian").util.smart_action()
				end,
				opts = { buffer = true, expr = true },
			},
		},
		note_frontmatter_func = function(note)
			if note.title then
				note:add_alias(note.title)
			end
			local out = { id = note.id, aliases = note.aliases, tags = note.tags }
			-- ensure fields are kept in the frontmatter
			if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
				for k, v in pairs(note.metadata) do
					out[k] = v
				end
			end
			return out
		end,
		follow_url_func = function(url)
			vim.fn.jobstart({ "yank", url })
		end,
		follow_img_func = function(img)
			vim.fn.jobstart({ "yank", img })
		end,
		picker = {
			name = "telescope.nvim",
			-- note_mappings = {
			-- 	-- create a new note from your query.
			-- 	new = "<C-n>",
			-- 	-- insert a link to the selected note.
			-- 	insert_link = "<C-l>",
			-- },
			-- tag_mappings = {
			-- 	tag_note = "<C-x>",
			-- 	insert_tag = "<C-l>",
			-- },
		},
		sort_by = "modified",
		sort_reversed = true,
		search_max_lines = 1000,
		open_notes_in = "current", -- vsplit|hsplit
	},
  }
    -- see below for full list of options 👇

