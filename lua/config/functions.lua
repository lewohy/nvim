function OpenRegister()
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile') -- 버퍼 타입을 'nofile'로 설정
    vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe') -- 버퍼를 숨기고 다시 열 때 삭제하도록 설정
    vim.api.nvim_buf_set_option(buf, 'swapfile', false) -- 스왑 파일 사용 안 함
    -- vim.api.nvim_buf_set_option(buf, 'modifiable', false)
    local lines = { 'a', 'b' }
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    -- 새 창에서 버퍼 표시
    local win = vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        width = 30,
        height = 10,
        row = 10,
        col = 10,
        border = 'single',
    })
end


function TableToString(tbl, indent)
    if not indent then indent = 0 end
    if type(tbl) ~= 'table' then return tostring(tbl) end
    local keys = {}
    for k in pairs(tbl) do
        keys[#keys + 1] = k
    end
    -- table.sort(keys, function(a, b) return tostring(a) < tostring(b) end)

    local parts = {}
    for _, key in ipairs(keys) do
        local value = tbl[key]
        local padding = string.rep("  ", indent)
        if type(value) == "table" then
            if next(value) then
                table.insert(parts,
                    padding .. tostring(key) .. " = {\n" .. tableToString(value, indent + 1) .. "\n" .. padding .. "}")
            else
                table.insert(parts, padding .. tostring(key) .. " = {}")
            end
        else
            table.insert(parts, padding .. tostring(key) .. " = " .. tostring(value))
        end
    end
    return table.concat(parts, ",\n")
end

