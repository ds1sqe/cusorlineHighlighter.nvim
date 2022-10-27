-- Cusorline Highlighter
-- colorize your cusorline
-- @auther ds1sqe@mensakorea.org

local M = {}

M.toggleWindowHighlight = vim.api.nvim_create_augroup("toggleWindowHighlight", { clear = true })
M.cusorHighlight = vim.api.nvim_create_augroup("cusorHighlight", { clear = true })

-- Setup function. you can use this at your main config,
-- require('colorHl').setup("","","",T/F)
-- @param normalModColor => normal mod's cusorline color,
-- ex)
-- @param insertModColor => normal mod's cusorline color,
-- ex)
-- @param visualModColor => normal mod's cusorline color,
-- ex)
-- @param nohighlightIfBufferLeave => True or False ex) "true"
-- ex)
-- default settings are, normal = skyblue, insert = green , visual = pink , turn off if leave buffer = true
function M.setup(normalModColor, insertModColor, visualModColor, nohighlightIfBufferLeave)

    local settings = {
        normal = "guibg=#355666",
        insert = "guibg=#2e5c3f",
        visual = "guibg=#ad51a7",
        nohighlightIfBufferLeave = true,
    }
    if ((normalModColor ~= "") and (normalModColor ~= nil)) then
        settings.normal = normalModColor
    end
    if ((insertModColor ~= "") and (insertModColor ~= nil)) then
        settings.insert = insertModColor
    end
    if ((visualModColor ~= "") and (visualModColor ~= nil)) then
        settings.visual = visualModColor
    end
    if ((nohighlightIfBufferLeave ~= nil) and (type(nohighlightIfBufferLeave) == "boolean")) then
        settings.nohighlightIfBufferLeave = nohighlightIfBufferLeave
    end
    vim.api.nvim_create_autocmd("InsertLeave", {
        group = M.cusorHighlight,
        pattern = { "*" },
        command = "hi CursorLine " .. settings.normal
    })
    vim.api.nvim_create_autocmd("InsertEnter", {
        group = M.cusorHighlight,
        pattern = { "*" },
        command = "hi CursorLine " .. settings.insert
    })
    vim.api.nvim_create_autocmd("InsertLeave", {
        group = M.cusorHighlight,
        pattern = { "*" },
        command = "hi Visual " .. settings.visual
    })

    if (settings.nohighlightIfBufferLeave) then
        vim.api.nvim_create_autocmd("BufEnter", {
            group = M.toggleWindowHighlight,
            pattern = "*",
            command = "set relativenumber cursorline",
        })

        vim.api.nvim_create_autocmd("BufLeave", {
            group = M.toggleWindowHighlight,
            pattern = "*",
            command = "set norelativenumber nocursorline",
        })
    end

end

return M
