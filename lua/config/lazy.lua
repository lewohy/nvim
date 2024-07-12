local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    {
        'rcarriga/nvim-notify',
        opts = {
            -- background_colour = nil,
            fps = 60,
            icons = {
                DEBUG = '',
                ERROR = '',
                INFO = '',
                TRACE = '✎',
                WARN = '',
            },
            level = 2,
            minimum_width = 20,
            render = 'wrapped-compact',
            stages = 'fade_in_slide_out',
            time_formats = {
                notification = '%T',
                notification_history = '%FT%T',
            },
            timeout = 5000,
            top_down = false,
        },
        init = function()
            vim.notify = require('notify')
        end,
    },
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        opts = {
            flavour = 'mocha', -- latte, frappe, macchiato, mocha
            background = {     -- :h background
                light = 'mocha',
                dark = 'mocha',
            },
        },

        init = function()
            -- setup must be called before loading
            vim.cmd.colorscheme('catppuccin-mocha')

            local palettes = require('catppuccin.palettes').get_palette('mocha')

            vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = palettes.overlay2, bold = true })
            vim.api.nvim_set_hl(0, 'LineNr', { fg = palettes.overlay1, bold = true })
            vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#FB508F', bold = true })
        end
    },
    {
        'numToStr/Comment.nvim',
        opts = {
            ---Add a space b/w comment and the line
            padding = true,
            ---Whether the cursor should stay at its position
            sticky = true,
            ---Lines to be ignored while (un)comment
            ignore = nil,
            ---LHS of toggle mappings in NORMAL mode
            toggler = {
                ---Line-comment toggle keymap
                line = 'gcc',
                ---Block-comment toggle keymap
                block = 'gbc',
            },
            ---LHS of operator-pending mappings in NORMAL and VISUAL mode
            opleader = {
                ---Line-comment keymap
                line = 'gc',
                ---Block-comment keymap
                block = 'gb',
            },
            ---LHS of extra mappings
            extra = {
                ---Add comment on the line above
                above = 'gcO',
                ---Add comment on the line below
                below = 'gco',
                ---Add comment at the end of line
                eol = 'gcA',
            },
            ---Enable keybindings
            ---NOTE: If given `false` then the plugin won't create any mappings
            mappings = {
                ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
                basic = true,
                ---Extra mapping; `gco`, `gcO`, `gcA`
                extra = true,
            },
            ---Function to call before (un)comment
            pre_hook = nil,
            ---Function to call after (un)comment
            post_hook = nil,
        },

        lazy = false,
    },
    {
        'glacambre/firenvim',
        lazy = false,
        build = function() vim.fn['firenvim#install'](0) end,
        config = function()

        end,
        init = function()
            local id = vim.api.nvim_create_augroup('ExpandLinesOnTextChanged', { clear = true })
            local max_height = 20
            local height_offset = 4
            local resize_window = function(event)
                local height = vim.api.nvim_win_text_height(0, {}).all + height_offset

                if height > vim.o.lines and height < max_height then
                    vim.o.lines = height
                    vim.cmd('norm! zb')
                end
            end

            vim.g.firenvim_config = {
                globalSettings = { alt = 'all' },
                localSettings = {
                    ['.*'] = {
                        cmdline = 'neovim',
                        content = 'text',
                        priority = 0,
                        selector = 'textarea',
                        takeover = 'never',
                    },
                },
            }

            vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, {
                group = id,
                callback = function(event)
                    resize_window(event)

                    if vim.g.timer_started == true then
                        return
                    end
                    vim.g.timer_started = true
                    vim.fn.timer_start(1000, function()
                        vim.g.timer_started = false
                        vim.cmd('silent write')

                        vim.fn.timer_start(100, function()
                            resize_window(event)
                        end)
                    end)
                end
            })

            vim.api.nvim_create_autocmd({ 'UIEnter' }, {
                group = id,
                callback = function(event)
                    vim.fn.timer_start(100, function()
                        resize_window(event)
                    end)
                end
            })
        end

    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            local function is_nvim_tree() return vim.bo.filetype == 'NvimTree' end
            local function is_todo() return vim.bo.filetype == 'qf' end
            local function is_firenvim() return vim.g.started_by_firenvim end

            require('lualine').setup({
                options = {
                    icons_enabled = true,
                    theme = 'catppuccin',
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    },
                },
                sections = {
                    lualine_a = {
                        {
                            'mode',
                            cond = function()
                                return (not is_nvim_tree()) and (not is_todo())
                            end,
                        },
                    },
                    lualine_b = {
                        {
                            'branch',
                            cond = function()
                                return (not is_nvim_tree()) and (not is_todo())
                            end,
                        },
                        {
                            'diff',
                            cond = function()
                                return (not is_nvim_tree()) and (not is_todo())
                            end,
                        },
                        {
                            'diagnostics',
                            cond = function()
                                return (not is_nvim_tree()) and (not is_todo())
                            end,
                        },
                    },
                    lualine_c = {
                        {
                            'filename',
                            cond = function()
                                return (not is_nvim_tree())
                                    and (not is_firenvim())
                                    and (not is_todo())
                            end,
                        },
                    },
                    lualine_x = {},
                    lualine_y = {
                        {
                            'encoding',
                            cond = function()
                                return (not is_nvim_tree()) and (not is_todo())
                            end,
                        },
                        {
                            'fileformat',
                            cond = function()
                                return (not is_nvim_tree()) and (not is_todo())
                            end,
                        },
                        {
                            'filetype',
                            cond = function()
                                return (not is_nvim_tree()) and (not is_todo())
                            end,
                        },
                    },
                    lualine_z = {
                        {
                            'location',
                            cond = function()
                                return (not is_nvim_tree()) and (not is_todo())
                            end,
                        },
                    },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
                extensions = {},
            })
        end
    },
    {
        'kylechui/nvim-surround',
        version = '*', -- Use for stability; omit to use `main` branch for the latest features
        event = 'VeryLazy',
        opts = {
            keymaps = {
                insert = '<C-g>s',
                insert_line = '<C-g>S',
                normal = 'ys',
                normal_cur = 'yss',
                normal_line = 'yS',
                normal_cur_line = 'ySS',
                visual = 'S',
                visual_line = 'gS',
                delete = 'ds',
                change = 'cs',
                change_line = 'cS',
            },
        },

    },
    {
        'lukas-reineke/virt-column.nvim',
        config = function()
            require('virt-column').setup({
                char = '▕',
                virtcolumn = '80,120',
            })
        end
    },
    {
        'karb94/neoscroll.nvim',
        opts = {
            mappings = { -- Keys to be mapped to their corresponding default scrolling animation
                '<C-u>', '<C-d>',
                '<C-b>', '<C-f>',
                '<C-y>', '<C-e>',
                'zt', 'zz', 'zb',
            },
            hide_cursor = false,         -- Hide cursor while scrolling
            stop_eof = true,             -- Stop at <EOF> when scrolling downwards
            respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
            cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
            easing = 'cubic',            -- Default easing function
            pre_hook = nil,              -- Function to run before the scrolling animation starts
            post_hook = nil,             -- Function to run after the scrolling animation ends
            performance_mode = false,    -- Disable 'Performance Mode' on all buffers.
        },

    },
    {
        'folke/todo-comments.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        opts = {
            signs = true,      -- show icons in the signs column
            sign_priority = 8, -- sign priority
            -- keywords recognized as todo comments
            keywords = {
                FIX = {
                    icon = ' ', -- icon used for the sign, and in search results
                    color = 'error', -- can be a hex color, or a named color (see below)
                    alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' }, -- a set of other keywords that all map to this FIX keywords
                    -- signs = false, -- configure signs for some keywords individually
                },
                TODO = { icon = ' ', color = 'info' },
                HACK = { icon = ' ', color = 'warning' },
                WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX' } },
                PERF = { icon = ' ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
                NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
                TEST = {
                    icon = '⏲ ',
                    color = 'test',
                    alt = { 'TESTING', 'PASSED', 'FAILED' },
                },
            },
            gui_style = {
                fg = 'NONE',       -- The gui style to use for the fg highlight group.
                bg = 'BOLD',       -- The gui style to use for the bg highlight group.
            },
            merge_keywords = true, -- when true, custom keywords will be merged with the defaults
            -- highlighting of the line containing the todo comment
            -- * before: highlights before the keyword (typically comment characters)
            -- * keyword: highlights of the keyword
            -- * after: highlights after the keyword (todo text)
            highlight = {
                multiline = true,                -- enable multine todo comments
                multiline_pattern = '^.',        -- lua pattern to match the next multiline from the start of the matched keyword
                multiline_context = 10,          -- extra lines that will be re-evaluated when changing a line
                before = '',                     -- 'fg' or 'bg' or empty
                keyword = 'wide',                -- 'fg', 'bg', 'wide', 'wide_bg', 'wide_fg' or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
                after = 'fg',                    -- 'fg' or 'bg' or empty
                pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
                comments_only = true,            -- uses treesitter to match keywords in comments only
                max_line_len = 400,              -- ignore lines longer than this
                exclude = {},                    -- list of file types to exclude highlighting
            },
            -- list of named colors where we try to extract the guifg from the
            -- list of highlight groups or use the hex color if hl not found as a fallback
            colors = {
                error = { 'DiagnosticError', 'ErrorMsg', '#FF0000' },
                warning = { 'DiagnosticWarn', 'WarningMsg', '#FFFF00' },
                info = { 'DiagnosticInfo', '#2563EB' },
                hint = { 'DiagnosticHint', '#10B981' },
                default = { 'Identifier', '#7C3AED' },
                test = { 'Identifier', '#FF00FF' },
            },
            search = {
                command = 'rg',
                args = {
                    '--color=never',
                    '--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                },
                -- regex that will be used to match keywords.
                -- don't replace the (KEYWORDS) placeholder
                pattern = [[\b(KEYWORDS):]], -- ripgrep regex
                -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
            },
        },

    },
    {
        'NeogitOrg/neogit',
        dependencies = {
            'nvim-lua/plenary.nvim',  -- required
            'sindrets/diffview.nvim', -- optional - Diff integration

            -- Only one of these is needed, not both.
            'nvim-telescope/telescope.nvim', -- optional
            'ibhagwan/fzf-lua',              -- optional
        },

    },
    {
        'petertriho/nvim-scrollbar',
        opts = {

        },
        cond = vim.g.vscode == nil,
    },
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            pickers = {
                buffers = {
                    theme = 'dropdown',
                },
                find_files = {
                    theme = 'dropdown',
                },
                oldfiles = {
                    theme = 'dropdown',
                },
            },
        },
    },
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '│' },
                delete = { text = '-' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
                untracked = { text = '┆' },
            },
        },

    },
    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        opts = {
            indent = {
                char = '▏'
            }
        },
        cond = vim.g.vscode == nil,
    },
    {
        'akinsho/bufferline.nvim',
        version = '*',
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            local mocha = require('catppuccin.palettes').get_palette('mocha')
            local hightlights = require('catppuccin.groups.integrations.bufferline').get({
                styles = {
                    'italic',
                    'bold'
                },
                custom = {
                    all = {
                        fill = {
                            -- bg = '#0000ff'
                        },
                    },
                    mocha = {
                        background = { fg = mocha.text },
                    },
                    latte = {
                        background = { fg = '#000000' },
                    },
                },
            })

            require('bufferline').setup({
                highlights = hightlights,
                options = {
                    separator_style = 'slant'
                }
            })
        end
    },
    {
        'smoka7/hop.nvim',
        version = '*',
        opts = {
            keys = 'qwerasdfzxcv',
            quit_key = '<ESC>',
            jump_on_sole_occurrence = false,
            case_insensitive = false,
            multi_windows = true,
        },
    },
    -- {
    --     'williamboman/mason.nvim',
    --     opts = {
    --         ui = {
    --             icons = {
    --                 package_installed = '✓',
    --                 package_pending = '➜',
    --                 package_uninstalled = '✗'
    --             }
    --         }
    --     },
    --
    -- },
    -- {
    --     'williamboman/mason-lspconfig.nvim',
    --     opts = {},
    --
    -- },
    -- {
    --     'neovim/nvim-lspconfig',
    --     config = function()
    --         local lspconfig = require('lspconfig')
    --
    --         lspconfig.clangd.setup({})
    --     end
    -- },
})
