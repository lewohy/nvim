return {
    config = {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    init = function()
        local function is_nvim_tree() return vim.bo.filetype == 'NvimTree' end
        local function is_todo() return vim.bo.filetype == 'qf' end
        local function is_firenvim() return vim.g.started_by_firenvim end
        local mocha = require("catppuccin.palettes").get_palette("mocha")

        local winbar_a = {
            {
                'filename',
                cond = function() return not is_firenvim() end,
                section_separators = { left = '', right = '' },
                color = {
                    -- bg = mocha.dark,
                    -- fg = mocha.dark,
                },
                file_status = true,    -- Displays file status (readonly status, modified status)
                newfile_status = true, -- Display new file status (new file means no write after created)
                path = 0,
                shorting_target = 40,  -- Shortens path to leave 40 spaces in the window
                -- for other components. (terrible name, any suggestions?)
                symbols = {
                    modified = '', -- Text to show when the file is modified.
                    readonly = '[Readonly]', -- Text to show when the file is non-modifiable or readonly.
                    unnamed = '[No Name]', -- Text to show for unnamed buffers.
                    newfile = '[New]', -- Text to show for newly created file before first write
                },
            },
        }

        require('lualine').setup({
            options = {
                icons_enabled = true,
                theme = "catppuccin",
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
            tabline = {
                lualine_a = {
                    {
                        'tabs',
                        cond = function() return not is_firenvim() end,
                        tab_max_length = vim.o.columns,
                        max_length = vim.o.columns,
                        mode = 2,
                        path = 0,
                        use_mode_colors = false,
                        tabs_color = {
                            active = {
                                -- bg = Colors.blue,
                                -- fg = Colors.darkgray,
                            },
                            inactive = {
                                -- bg = Color.from_hex(Colors.blue):lighten(2):to_css(),
                                -- fg = Colors.darkgray,
                            },
                        },

                        show_modified_status = true,
                        symbols = {
                            modified = nil,
                        },
                        fmt = function(tab, context)
                            if context.tabnr == vim.api.nvim_get_current_tabpage() then
                                return '' .. tab .. ''
                            else
                                return ' ' .. tab .. ' '
                            end
                        end,
                    },
                },
                lualine_b = {
                    {
                        'windows',
                        cond = function() return not is_firenvim() end,
                        window_max_length = vim.o.columns,
                        max_length = vim.o.columns,
                        show_filename_only = true,    -- Shows shortened relative path when set to false.
                        show_modified_status = false, -- Shows indicator when the window is modified.
                        mode = 2,
                        filetype_names = {
                            TelescopePrompt = 'Telescope',
                            dashboard = 'Dashboard',
                            packer = 'Packer',
                            fzf = 'FZF',
                            alpha = 'Alpha',
                        }, -- Shows specific window name for that filetype ( { `filetype` = `window_name`, ... } )

                        -- disabled_buftypes = { 'quickfix', 'prompt' }, -- Hide a window if its buffer's type is disabled

                        -- Automatically updates active window color to match color of other components (will be overidden if buffers_color is set)
                        use_mode_colors = false,

                        windows_color = {
                            active = {
                                -- bg = Colors.cyan,
                                -- fg = Colors.darkgray,
                            },
                            inactive = {
                                -- bg = Color.from_hex(Colors.cyan):lighten(-2):to_css(),
                                -- fg = Colors.darkgray,
                                -- bg = Colors.darkcyan,
                                -- fg = Colors.lightgray,
                            },
                        },
                        fmt = function(window, context)
                            if context.winnr == vim.api.nvim_get_current_win() then
                                return '' .. window .. ''
                            else
                                return ' ' .. window .. ' '
                            end
                        end,
                    },
                },
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            winbar = {
                lualine_a = winbar_a,
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            inactive_winbar = {
                lualine_a = winbar_a,
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            extensions = {},
        })
    end
}
