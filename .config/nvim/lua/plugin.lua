--------Plugins config--------

-- Install Packer
local packer_url = 'https://github.com/wbthomason/packer.nvim'
local dest_path = os.getenv('HOME')..'/.local/share/nvim/site/pack/packer/start/packer.nvim'
packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', packer_url, dest_path})

-- Plugin autocompile
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugin.lua source <afile> | PackerCompile
  augroup end
]])

-- List plugins
return require('packer').startup(function() use { 'wbthomason/packer.nvim' }

  -- Utilities
  use {
    'preservim/nerdcommenter',
    config = function()
      vim.g.NERDSpaceDelims = 1
      vim.g.NERDCompactSexyComs = 1
    end
  }
  use {
    'airblade/vim-gitgutter',
    config = function()
      vim.g.gitgutter_max_signs = 2000
    end
  }

  use {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup {}
    end
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup {
        auto_reload_on_write = true,
        update_cwd = true,
        view = {
          adaptive_size = true,
          number = false,
          relativenumber = false,
        },
        renderer = {
          indent_markers = {
            enable = true,
            icons = {
              corner = "└ ",
              edge = "│ ",
              none = "  ",
            },
          },
          group_empty = true,
          icons = {
            show = {
              file = true,
              folder = true,
              git = true,
              folder_arrow = true,
            }
          }
        },
        filters = {
          dotfiles = false,
        },
        update_focused_file = {
          enable = false,
        },
        git = {
          enable = true,
          ignore = false,
        },
      }
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup {}
    end
  }

  use { 'tpope/vim-fugitive' }
  use { 'tpope/vim-surround' }
  use { 'jiangmiao/auto-pairs' }
  use { 'tpope/vim-dadbod' }
  use { 'kristijanhusak/vim-dadbod-ui' }
  use {
    'kristijanhusak/vim-dadbod-completion',
    config = function()
      require('telescope').setup {}
      vim.cmd([[
        autocmd FileType sql setlocal omnifunc=vim_dadbod_completion#omni
        autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
      ]])
    end
  }

  use {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup {
        size = 15,
        hide_numbers = true,
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        persist_mode = true,
        direction = 'horizontal',
        close_on_exit = true,
      }
    end
  }

  -- Programming language
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'rust', 'lua', 'python', 'javascript', 'toml',
          'html', 'css', 'json', 'yaml', 'typescript', 'c', 'dockerfile',
          'proto', 'markdown', 'http' },
        sync_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      }
    end
  }

  use { 'rust-lang/rust.vim'  }

  -- Language Server Protocol
  use { 'neovim/nvim-lspconfig' }
  use { 'hrsh7th/nvim-cmp' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'saadparwaiz1/cmp_luasnip' }
  use { 'L3MON4D3/LuaSnip' }

  -- UI
  use {
    'folke/tokyonight.nvim',
    config = function()
      vim.g.tokyonight_style = 'storm'
      vim.g.tokyonight_lualine_bold = true
      vim.cmd([[ colorscheme tokyonight ]])
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = false,
          theme = 'auto',
          component_separators = { left = '🔥', right = '⤳'},
          section_separators = { left = '↯', right = '» '},
          disabled_filetypes = { 'packer', 'NvimTree' },
          always_divide_middle = true,
          globalstatus = false,
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch'},
          lualine_c = {'filename', 'diagnostics'},
          lualine_x = {'diff', 'fileformat', 'encoding', 'filetype'},
          lualine_y = {'location'},
          lualine_z = {'progress'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        extensions = {}
      }
    end
  }

  -- Bot
  use { 'github/copilot.vim' }
end)
--------End plugins config--------