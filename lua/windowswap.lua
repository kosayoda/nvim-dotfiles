local vim = vim
M = {}

local function create_hint(window, name)
    -- Create buffer and populate with id text
    local buf_nr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf_nr, 0, -1, true, {name})

    -- Get position of window (center of buffer)
    local width = vim.api.nvim_win_get_width(window)
    local height = vim.api.nvim_win_get_height(window)

    local x = (width - width % 2 ) / 2 - #name
    local y = (height - height % 2 ) / 2 - 1

    -- Window options
    local win_opts = {
        relative = "win", win = window,
        row = y, col = x,
        width = #name, height = 1,
        focusable = false, style = "minimal"
    }
    local win = vim.api.nvim_open_win(buf_nr, false, win_opts)
    return win
end

M.swap = function()
    local hint_list = {}
    local windows = vim.api.nvim_tabpage_list_wins(0)
    local current_window = vim.api.nvim_tabpage_get_win(0)
    -- print("Current window: ".. current_window)
    for i, win in ipairs(windows) do
        -- print("Loop window: ".. win)
        local id = tostring(i)
        if current_window ~= win then
            -- print("Adding to table: ".. win)
            local created_win = create_hint(win, id)
            -- print("Got window: ".. created_win)
            table.insert(hint_list, created_win)
            -- print(vim.inspect(hint_list))
        end
    end
    -- print(vim.inspect(hint_list))
    if #hint_list == 0 then
        -- print("No windows to swap")
        return
    end

    -- Get windows to show up
    vim.api.nvim_command("redraw")

    -- Get window to swap
    local to_swap = tonumber(
        vim.fn.input("Enter window to swap buffers with the current window:")
    )
    if to_swap == nil then
        -- print("Window swap canceled.")
        return
    end
    local to_swap_window = windows[to_swap]
    -- print(to_swap_window)

    local to_swap_buffer = vim.api.nvim_win_get_buf(to_swap_window)
    vim.api.nvim_win_set_buf(to_swap_window, vim.api.nvim_win_get_buf(0))
    vim.api.nvim_win_set_buf(0, to_swap_buffer)

    for _, win in pairs(hint_list) do
        vim.api.nvim_win_close(win, true)
    end
    vim.api.nvim_command("redraw")
end

return M
