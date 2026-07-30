local executor = string.lower(identifyexecutor and identifyexecutor() or "")

-- **FIX: Define VirtualUser and patch it BEFORE loading the source**
local VirtualUser = game:GetService("VirtualUser")
if VirtualUser and not VirtualUser.ClickButton2D then
    VirtualUser.ClickButton2D = function(self, button)
        pcall(function()
            if button and button.Click then
                button:Click()
            end
        end)
    end
end

local source = [[
    --[[
        ~ New Discord Server ~
        [ https://discord.gg/tUEJZYvF9d ]

        ~ Index ~
        ... (rest of your source code remains exactly the same) ...
    ]]

    -- ... the rest of your source ...
]]

local threadSource = [[
    for _, func in getgc(false) do
        if type(func) == "function" and islclosure(func) and debug.getinfo(func).name == "require" and string.find(debug.getinfo(func).source, "ClientLoader") then
            ]] .. source .. [[
            break
        end
    end
]]

local function runSource(runner, getAll)
    for _, actor in getAll() do
        runner(actor, threadSource)
    end
end

-- ... rest of your loader logic remains the same ...
