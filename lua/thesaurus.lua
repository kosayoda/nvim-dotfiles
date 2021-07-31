local M = {}

local Job = require("plenary.job")

local lsp_util = require("vim.lsp.util")
local handler = function(result)
    -- Searched word
    result[1] = result[1]:match("[^|]+")

    -- Items
    for i = 2, #result do
        local line = result[i]
        local type = line:match("%(%a+%)")
        local items = {}
        for item in line:gmatch("|[^|]+") do
            table.insert(items, item:sub(2):match"^%s*(.*%S)")
        end
        result[i] = string.format("%s | %s", type, table.concat(items, ", "))
    end
    local width = vim.api.nvim_get_option("columns")
    local _, win = lsp_util.open_floating_preview(
        result, "plaintext", { max_width = math.ceil(width * 0.8 - 4) }
    )
    vim.api.nvim_win_set_config(win, { anchor = "NW" })
end

M.search = function()
    local query = vim.fn.expand("<cword>")
    local search_string = string.format("^%s\\|\\d+\\s(^\\(.*\\s)+", query)
    local result = Job:new({
        command = "rg",
        args = { "-U", search_string, "th_en_US_new.dat" },
        cwd = "/home/kosa/Documents/misc/temp/MyThes-1.0/",
    }):sync()

    if #result == 0 then
        print(string.format("No synonyms for '%s' found.", query))
    else
        handler(result)
    end
end

return M
