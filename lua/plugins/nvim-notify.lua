local notify = require('notify')
notify.setup({
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
    render = 'compact',
    stages = 'fade_in_slide_out',
    time_formats = {
        notification = '%T',
        notification_history = '%FT%T',
    },
    timeout = 5000,
    top_down = false,
})

vim.notify = notify
