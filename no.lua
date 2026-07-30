local executor = string.lower(identifyexecutor and identifyexecutor() or "")

local source = [[
    --[[
        ~ New Discord Server ~
        [ https://discord.gg/tUEJZYvF9d ]

        ~ Index ~
        [ Drawing Library ] - [ Line 111 ]
        [ UI Library ] - [ Line 1117 ]
        [ Cham Library ] - [ Line 2710 ]
        [ Main Cheat ] - [ Line 2766 ]
        [ Make UI ] - [ Line 5778 ]

        ~ Credits ~
        [ iRay ] - [ @896378803868295178 ] | Lead developer
        [ ipufo ] - [ @819756897543389184 ] | Took over development since 5/19/2025
        [ Mickey ] - [ @953720095811719208 ] | Developed perfect trajectory function and ESP library
        [ Redpoint ] - [ @418013390024474624 ] | Contributed to triangles in the custom drawing api

        ~ Special Thanks ~
        [ BBot ] - [ Inspiration to make such a nice UI and high quality/quantity feature list ]
        [ Legacy ] - [ Best and only beta tester ]
    ]]

    function LPH_NO_VIRTUALIZE(fuction) -- unnecessary now
        return fuction
    end
    LPH_JIT_MAX = LPH_NO_VIRTUALIZE

    local devMode = true
    local defaultUIName = "Wapus" -- $$$
    local folderName = "Phantom Forces Cheat"
    local connectionList = {}
    local callbackList = {}
    local playerStatus = {}
    local chatSpamLists = {}
    local customAudios = {}
    local cham = {}
    local unloadMain
    local wapus

    -- anti votekick bot code
    local userName = game:GetService("Players").LocalPlayer.Name
    local fileName = tostring(game.JobId) .. ".txt"
    if isfolder(folderName) and isfolder(folderName .. "/cache") and isfolder(folderName .. "/cache/votekick data") and isfile(folderName .. "/cache/votekick data/" .. fileName) and readfile(folderName .. "/cache/votekick data/" .. fileName) ~= userName then
        local hostName = readfile("Phantom Forces Cheat/cache/votekick data/" .. tostring(game.JobId) .. ".txt")
        local modules, require_module

        for _, func in getgc(false) do
            if type(func) == "function" and islclosure(func) and debug.getinfo(func).name == "require" and string.find(debug.getinfo(func).source, "ClientLoader") then
                require_module = func
                modules = {}

                for moduleName, moduleCache in debug.getupvalue(func, 1)._cache do
                    modules[moduleName] = moduleCache.module
                end

                break
            end
        end

        local network = modules.NetworkClient
        local votekick = modules.VoteKickInterface
        local charInterface = modules.CharacterInterface
        local roundSystem = modules.RoundSystemClientInterface

        local clientEvents = debug.getupvalue(debug.getupvalue(network._init, 2), 2)

        game:GetService("RunService"):Set3dRenderingEnabled(false) -- increase performance              bruh why this doesnt work on nihon idk if it works on other executors

        local function isKickInProgress()
            return debug.getupvalue(votekick.vote, 1) -- fuck you guy
        end

        local console = clientEvents.console
        function clientEvents.console(message)
            task.spawn(function()
                if string.find(message, "has initiated a votekick on") then
                    local initiator = string.split(message, " has initiated")[1]
                    local victim = string.split(string.split(message, "initiated a votekick on ")[2], " for ")[1]

                    repeat task.wait() until isKickInProgress()

                    if victim == hostName then -- meanie tried to votekick u
                        votekick.vote("no")
                    elseif initiator == hostName then
                        votekick.vote("yes") -- troll
                    end
                end
            end)

            return console(message)
        end

        repeat
            repeat task.wait() until not roundSystem.roundLock
            charInterface.spawn()
            repeat task.wait() until charInterface.isAlive() and charInterface.getCharacterObject() and charInterface.getCharacterObject():canJump()
            charInterface.getCharacterObject():jump(4)
            task.wait(5)
            network:send("forcereset")
            task.wait(3.1)
        until nil
    end

    if LPH_OBFUSCATED then
        while true do
        end
        return
    end

    LPH_NO_VIRTUALIZE(function()
    workspace:FindFirstChild("nigga stop deobfuscating my script you black monkey nigger - iray") -- theres this bitch nigga named isse (@723741691583922209)
    do -- Drawing Library
        local drawing = {}
        local cache = {
            updates = {},
            instances = {},
            shapes = {}
        }

        local leftTriangleId = "http://www.roblox.com/asset/?id=18975909718" -- "http://www.roblox.com/asset/?id=17661400876" 2
        local rightTriangleId = "http://www.roblox.com/asset/?id=18975907988" -- "http://www.roblox.com/asset/?id=17661399529" 1

        local folder = Instance.new("ScreenGui")
        local black = Color3.new(0, 0, 0)
        local v2 = Vector2
        local nv = v2.zero

        folder.Name = "Drawing API By iRay"
        folder.IgnoreGuiInset = true
        folder.Parent = game:GetService("CoreGui")

        local universal = {
            Visible = false,
            Transparency = 1,
            Color = black,
            ZIndex = 1
        }

        local defaults = { -- benefit of remaking it is to have a uniform drawing api across all executors because the wapus ui was originally made with krampus' drawing api
            Square = {
                Position = nv,
                Size = nv,
                Thickness = 1,
                Filled = false
            },
            Circle = {
                Position = nv,
                NumSides = 8,
                Radius = 200,
                Thickness = 1,
                Filled = false
            },
            Line = {
                From = nv,
                To = nv,
                Thickness = 1
            },
            Text = {
                Text = "",
                Size = 14,
                Center = false,
                Outline = false,
                OutlineColor = black,
                Position = nv,
                TextBounds = nv,
                Font = 0
            },
            Triangle = {
                Thickness = 1,
                PointA = nv,
                PointB = nv,
                PointC = nv,
                Filled = false
            },
            Image = {
                Position = nv,
                Size = nv,
                Data = ""
            },
            Quad = { -- why did i even do this
                Thickness = 1,
                PointA = nv,
                PointB = nv,
                PointC = nv,
                PointD = nv,
                Filled = false
            }
        }

        drawing.Fonts = {
            UI = 0,
            System = 1,
            Plex = 2,
            Monospace = 3
        }

        local fontIndexes = {
            [0] = Enum.Font.Legacy,
            [1] = Enum.Font.Ubuntu,
            [2] = Enum.Font.Code,
            [3] = Enum.Font.Jura
        }

        local newMetatable = {
            __index = function(self, index)
                if index == "TextBounds" and self._data.shape == "Text" then
                    return self._data.drawings.label.TextBounds
                end

                return self._data[index]
            end,
            __newindex = function(self, index, value)
                if self._data[index] == nil then
                    --warn("invalid shape property: '" .. tostring(index) .. "'")
                elseif self._data[index] ~= value then
                    local shapeIndex = self._data.index

                    if self._data.shape == "Text" then -- only putting this here to make TextBounds work better
                        if index == "Text" then
                            self._data.drawings.label.Text = value
                            self._data[index] = value
                            return
                        elseif index == "Font" then
                            self._data.drawings.label.Font = fontIndexes[value]
                            self._data[index] = value
                            return
                        elseif index == "Size" then
                            self._data.drawings.label.TextSize = value * 0.66
                            self._data[index] = value
                            return
                        end
                    end

                    if not cache.updates[shapeIndex] then
                        cache.updates[shapeIndex] = {}
                    end

                    if index == "Thickness" or index == "NumSides" then
                        value = math.max(math.abs(value), 1)
                    end

                    if index == "NumSides" then
                        value = math.min(value, 64)
                    end

                    cache.updates[shapeIndex][index] = value
                    self._data[index] = value
                end
            end
        }

        local function destroyEntity(entity)
            if entity._data.shape == "Circle" or entity._data.shape == "Quad" then
                for _, object in entity._data.drawings.lines do
                    object:Destroy()
                end

                for _, objects in entity._data.drawings.triangles do
                    objects[1]:Destroy()
                    objects[2]:Destroy()
                end
            else
                for _, object in entity._data.drawings do
                    object:Destroy()
                end
            end
        end

        local function createEntity(shape)
            local entity = {}

            for ind, val in universal do
                entity[ind] = val
            end

            for ind, val in defaults[shape] do
                entity[ind] = val
            end

            return entity
        end

        local function newFrame()
            local frame = Instance.new("Frame", folder)
            frame.Visible = false
            frame.BorderSizePixel = 0
            frame.BackgroundColor3 = black
            return frame
        end

        local function newTriangle()
            local right = Instance.new("ImageLabel", folder)
            right.Image = rightTriangleId
            right.Visible = false
            right.BackgroundTransparency = 1
            right.AnchorPoint = v2.new(0.5, 0.5)
            right.ImageColor3 = black
            local left = Instance.new("ImageLabel", folder)
            left.Image = leftTriangleId
            left.Visible = false
            left.BackgroundTransparency = 1
            left.AnchorPoint = v2.new(0.5, 0.5)
            left.ImageColor3 = black
            return right, left
        end

        function drawing.new(shape)
            if shape == "Square" then
                local data = createEntity(shape)
                local square = {_data = data, Remove = destroyEntity, Destroy = destroyEntity}
                data.drawings = {box = newFrame(), line1 = newFrame(), line2 = newFrame(), line3 = newFrame(), line4 = newFrame()}
                data._data = data
                data.index = #cache.shapes + 1
                data.shape = shape
                cache.shapes[data.index] = square
                table.insert(cache.instances, data.drawings)
                return setmetatable(square, newMetatable)
            elseif shape == "Circle" then
                local data = createEntity(shape)
                local circle = {_data = data, Remove = destroyEntity, Destroy = destroyEntity}
                data.drawings = {lines = {}, triangles = {}}
                data._data = data
                data.index = #cache.shapes + 1
                data.shape = shape
                cache.shapes[data.index] = circle

                for i = 1, 8 do
                    local newLine = newFrame()
                    newLine.AnchorPoint = v2.new(0.5, 0.5)
                    table.insert(data.drawings.lines, newLine)
                end

                for i = 1, 8 do
                    table.insert(data.drawings.triangles, {newTriangle()})
                end

                table.insert(cache.instances, data.drawings)
                return setmetatable(circle, newMetatable)
            elseif shape == "Image" then
                local data = createEntity(shape)
                local image = {_data = data, Remove = destroyEntity, Destroy = destroyEntity}
                data.drawings = {image = Instance.new("ImageLabel", folder)}
                data._data = data
                data.index = #cache.shapes + 1
                data.shape = shape
                data.drawings.image.Image = ""
                data.drawings.image.Visible = false
                data.drawings.image.BackgroundTransparency = 1
                data.drawings.image.Size = UDim2.new(0, 0, 0, 0)
                cache.shapes[data.index] = image
                table.insert(cache.instances, data.drawings)
                return setmetatable(image, newMetatable)
            elseif shape == "Line" then
                local data = createEntity(shape)
                local line = {_data = data, Remove = destroyEntity, Destroy = destroyEntity}
                data.drawings = {line = newFrame()}
                data.drawings.line.AnchorPoint = v2.new(0.5, 0.5)
                data._data = data
                data.index = #cache.shapes + 1
                data.shape = shape
                cache.shapes[data.index] = line
                table.insert(cache.instances, data.drawings)
                return setmetatable(line, newMetatable)
            elseif shape == "Text" then
                local data = createEntity(shape)
                local text = {_data = data, Remove = destroyEntity, Destroy = destroyEntity}
                local label = Instance.new("TextLabel", folder)
                label.Text = ""
                label.TextColor3 = black
                label.BackgroundTransparency = 1
                label.AutomaticSize = Enum.AutomaticSize.XY
                label.Size = UDim2.new(0, 0, 0, 0)
                label.Font = fontIndexes[0]
                label.Visible = false
                data.drawings = {label = label}
                data._data = data
                data.index = #cache.shapes + 1
                data.shape = shape
                cache.shapes[data.index] = text
                table.insert(cache.instances, data.drawings)
                return setmetatable(text, newMetatable)
            elseif shape == "Triangle" then
                local data = createEntity(shape)
                local triangle = {_data = data, Remove = destroyEntity, Destroy = destroyEntity}
                local left, right = newTriangle()
                data.drawings = {left = left, right = right, a = newFrame(), b = newFrame(), c = newFrame()}
                data.drawings.a.AnchorPoint = v2.new(0.5, 0.5)
                data.drawings.b.AnchorPoint = v2.new(0.5, 0.5)
                data.drawings.c.AnchorPoint = v2.new(0.5, 0.5)
                data._data = data
                data.index = #cache.shapes + 1
                data.shape = shape
                cache.shapes[data.index] = triangle
                table.insert(cache.instances, data.drawings)
                return setmetatable(triangle, newMetatable)
            elseif shape == "Quad" then
                local data = createEntity(shape)
                local triangle = {_data = data, Remove = destroyEntity, Destroy = destroyEntity}
                local left, right = newTriangle()
                data.drawings = {lines = {}, triangles = {}}
                data._data = data
                data.index = #cache.shapes + 1
                data.shape = shape
                cache.shapes[data.index] = triangle

                for i = 1, 4 do
                    local newLine = newFrame()
                    newLine.AnchorPoint = v2.new(0.5, 0.5)
                    table.insert(data.drawings.lines, newLine)
                end

                for i = 1, 2 do
                    table.insert(data.drawings.triangles, {newTriangle()})
                end

                table.insert(cache.instances, data.drawings)
                return setmetatable(triangle, newMetatable)
            else
                --warn("invalid drawing shape: '" .. tostring(shape) .. "'")
            end
        end

        local function round(num)
            return math.floor(num + 0.5)
        end

        local function fixvec(vec)
            return v2.new(round(vec.X), round(vec.Y))
        end

        local function getPointOrder(a, b, c)
            local p0, p1, p2
            local d1, d2, d3 = (a - b).Magnitude, (c - b).Magnitude, (a - c).Magnitude
            local h1, h2, c0, h1d, h2d

            if d1 > d2 and d1 > d3 then
                h1 = a
                h2 = b
                c0 = c
                h1d = d3
                h2d = d2
            elseif d2 > d3 and d2 > d1 then
                h1 = c
                h2 = b
                c0 = a
                h1d = d3
                h2d = d1
            else
                h1 = c
                h2 = a
                c0 = b
                h1d = d2
                h2d = d1
            end

            if h1d < h2d then
                p0 = h1
                p1 = h2
                p2 = c0
            else
                p0 = h2
                p1 = h1
                p2 = c0
            end

            return p0, p1, p2
        end

        local function renderTriangle(leftSide, rightSide, p0, p1, p2) -- creates any triangle image by turning random triangles into 2 right triangles and using right triangle images
            local hmxo = p1.x - p0.x
            local hmyo = p1.y - p0.y
            local hm = (hmyo == 0 and 1 or hmyo) / (hmxo == 0 and 1 or hmxo)
            local hb = p0.y - hm * p0.x
            local lm = -1 / hm
            local lb = p2.y - lm * p2.x
            local sxo = (hm - lm)
            local sx = (lb - hb) / (sxo == 0 and 1 or sxo)
            local s = v2.new(sx, lm * sx + lb) -- point with right angle

            local ho = p2 - s
            local height = ho.Magnitude
            local b1o = p1 - s
            local base1 = b1o.Magnitude
            local b2o = p0 - s
            local base2 = b2o.Magnitude

            local m1 = s + ho * 0.5 + b1o * 0.5
            local m2 = s + ho * 0.5 + b2o * 0.5

            local d1 = p1 - p0
            local left, right = leftSide, rightSide
            local rotation = math.deg(math.atan2(d1.Y, d1.X))

            -- ty redpoint for these 12 lines (@418013390024474624)
            local horizontal_dot = b1o:Dot(v2.new(1, 0))
            local vertical_dot = ho:Dot(v2.new(0, -1))
            if horizontal_dot > 0 and vertical_dot < 0 or horizontal_dot < 0 and vertical_dot > 0 then
                if d1.X ~= 0 then
                    left = rightSide
                    right = leftSide
                    rotation += math.deg(math.pi)
                end
            elseif d1.X == 0 then
                left = rightSide
                right = leftSide
                rotation += math.deg(math.pi)
            end

            left.Position = UDim2.new(0, m1.X, 0, m1.Y)
            left.Size = UDim2.new(0, base1, 0, height)
            left.Rotation = rotation
            right.Position = UDim2.new(0, m2.X, 0, m2.Y)
            right.Size = UDim2.new(0, base2, 0, height)
            right.Rotation = rotation
        end

        local lastRender = tick();
        local function render()
            if tick() - lastRender < 1/30 then return end;

            lastRender = tick();
            for shapeIndex, updateList in cache.updates do
                local shape = cache.shapes[shapeIndex]._data

                if shape.shape == "Line" then
                    local line = shape.drawings.line

                    if updateList.From or updateList.To then
                        local a = shape.From
                        local b = shape.To
                        local offset = b - a
                        local middle = a + offset * 0.5
                        local distance = offset.Magnitude
                        line.Position = UDim2.new(0, middle.X, 0, middle.Y) -- middle
                        line.Rotation = math.deg(math.atan(offset.Y / offset.X))
                        line.Size = UDim2.new(0, math.floor(distance + 0.5), 0, math.abs(shape.Thickness))
                    end

                    if updateList.Thickness then
                        local distance = (shape.From - shape.To).Magnitude
                        line.Size = UDim2.new(0, math.floor(distance + 0.5), 0, math.abs(updateList.Thickness))
                    end

                    if updateList.Color then
                        line.BackgroundColor3 = updateList.Color
                    end

                    if updateList.Visible ~= nil then
                        line.Visible = updateList.Visible
                    end

                    if updateList.Transparency then
                        line.Transparency = 1 - updateList.Transparency
                    end

                    if updateList.ZIndex then
                        line.ZIndex = updateList.ZIndex
                    end
                elseif shape.shape == "Text" then
                    local label = shape.drawings.label

                    if updateList.Position then
                        label.Position = UDim2.new(0, updateList.Position.X, 0, updateList.Position.Y + 2)
                    end

                    if updateList.Center ~= nil then
                        label.AutomaticSize = updateList.Center and Enum.AutomaticSize.Y or Enum.AutomaticSize.XY
                    end

                    if updateList.Outline ~= nil then
                        label.TextStrokeTransparency = updateList.Outline and 0 or 1
                    end

                    if updateList.OutlineColor then
                        label.TextStrokeColor3 = updateList.OutlineColor
                    end

                    if updateList.Color then
                        label.TextColor3 = updateList.Color
                    end

                    if updateList.Visible ~= nil then
                        label.Visible = updateList.Visible
                    end

                    if updateList.Transparency then
                        label.TextTransparency = 1 - updateList.Transparency
                    end

                    if updateList.ZIndex then
                        label.ZIndex = updateList.ZIndex
                    end
                elseif shape.shape == "Square" then
                    local drawings = shape.drawings

                    if updateList.Position or updateList.Thickness or updateList.Size then
                        local size = fixvec(shape.Size)
                        local position = shape.Position

                        if size.X < 0 then
                            size = v2.new(math.abs(size.X), size.Y)
                            position = v2.new(position.X - size.X, position.Y)
                        end

                        if size.Y < 0 then
                            size = v2.new(size.X, math.abs(size.Y))
                            position = v2.new(position.X, position.Y - size.Y)
                        end

                        local realThick = shape.Thickness
                        local thick = realThick - 1
                        local thicknessOffset = math.floor(thick * 0.5 + 0.5)
                        local boxPos = fixvec(v2.new(position.X - thicknessOffset, position.Y - thicknessOffset))
                        drawings.box.Position = UDim2.new(0, boxPos.X, 0, boxPos.Y)
                        drawings.box.Size = UDim2.new(0, size.X + thick, 0, size.Y + thick)
                        drawings.line1.Position = drawings.box.Position
                        drawings.line2.Position = UDim2.new(0, boxPos.X + size.X - 1, 0, boxPos.Y + realThick)
                        drawings.line3.Position = UDim2.new(0, boxPos.X, 0, boxPos.Y + size.Y - 1)
                        drawings.line4.Position = UDim2.new(0, boxPos.X, 0, boxPos.Y + realThick)
                        drawings.line2.Size = UDim2.new(0, realThick, 0, size.Y - realThick - 1)
                        drawings.line1.Size = UDim2.new(0, size.X + thick, 0, realThick)
                        drawings.line4.Size = UDim2.new(0, realThick, 0, size.Y - realThick - 1)
                        drawings.line3.Size = UDim2.new(0, size.X + thick, 0, realThick)
                    end

                    if updateList.Filled ~= nil then
                        if shape.Visible then
                            drawings.box.Visible = updateList.Filled
                            drawings.line1.Visible = not updateList.Filled
                            drawings.line2.Visible = not updateList.Filled
                            drawings.line3.Visible = not updateList.Filled
                            drawings.line4.Visible = not updateList.Filled
                        end
                    end

                    if updateList.Visible ~= nil then
                        if shape.Filled then
                            drawings.box.Visible = updateList.Visible
                        else
                            drawings.line1.Visible = updateList.Visible
                            drawings.line2.Visible = updateList.Visible
                            drawings.line3.Visible = updateList.Visible
                            drawings.line4.Visible = updateList.Visible
                        end
                    end

                    if updateList.Transparency then
                        drawings.box.Transparency = 1 - updateList.Transparency
                        drawings.line1.Transparency = 1 - updateList.Transparency
                        drawings.line2.Transparency = 1 - updateList.Transparency
                        drawings.line3.Transparency = 1 - updateList.Transparency
                        drawings.line4.Transparency = 1 - updateList.Transparency
                    end

                    if updateList.Color then
                        for _, drawing in drawings do
                            drawing.BackgroundColor3 = updateList.Color
                        end
                    end

                    if updateList.ZIndex then
                        for _, drawing in drawings do
                            drawing.ZIndex = updateList.ZIndex
                        end
                    end
                elseif shape.shape == "Image" then
                    local image = shape.drawings.image

                    if updateList.Position then
                        image.Position = UDim2.new(0, updateList.Position.X, 0, updateList.Position.Y)
                    end

                    if updateList.Size then
                        image.Size = UDim2.new(0, updateList.Size.X, 0, updateList.Size.Y)
                    end

                    if updateList.Data then
                        image.Image = updateList.Data
                    end

                    if updateList.Visible ~= nil then
                        image.Visible = updateList.Visible
                    end

                    if updateList.Transparency then
                        image.ImageTransparency = 1 - updateList.Transparency
                    end

                    if updateList.ZIndex then
                        image.ZIndex = updateList.ZIndex
                    end
                elseif shape.shape == "Circle" then
                    local drawings = shape.drawings

                    if updateList.NumSides then
                        for _, triangle in drawings.triangles do
                            for _, drawing in triangle do
                                drawing:Destroy()
                            end
                        end

                        for _, drawing in drawings.lines do
                            drawing:Destroy()
                        end

                        drawings.lines = {}
                        drawings.triangles = {}

                        for _ = 1, updateList.NumSides do
                            local newLine = newFrame()
                            newLine.AnchorPoint = v2.new(0.5, 0.5)
                            table.insert(drawings.lines, newLine)
                            table.insert(drawings.triangles, {newTriangle()})
                        end

                        updateList.Filled = shape.Filled
                        updateList.Visible = shape.Visible
                        updateList.Transparency = shape.Transparency
                        updateList.Color = shape.Color
                        updateList.ZIndex = shape.ZIndex
                    end

                    if updateList.Position or updateList.Thickness or updateList.Radius or updateList.NumSides then
                        local position = shape.Position
                        local size = shape.Radius
                        local num = shape.NumSides
                        local interval = 2 * math.pi / num

                        for lineIndex = 1, num do
                            local origin = (lineIndex - 1) * interval
                            local target = lineIndex * interval
                            local o0 = v2.new(math.cos(origin), math.sin(origin))
                            local o1 = v2.new(math.cos(target), math.sin(target))
                            local p0 = position + o0 * size
                            local p1 = position + o1 * size
                            local offset = p1 - p0
                            local middle = p0 + offset * 0.5
                            local distance = offset.Magnitude
                            local newSize = (middle - position).Magnitude
                            local line = drawings.lines[lineIndex]
                            local left = drawings.triangles[lineIndex][1]
                            local right = drawings.triangles[lineIndex][2]

                            line.Position = UDim2.new(0, middle.X, 0, middle.Y) -- middle
                            line.Rotation = math.deg(math.atan(offset.Y / offset.X))
                            line.Size = UDim2.new(0, math.floor(distance + 0.5), 0, math.abs(shape.Thickness))

                            local rotation = math.deg((lineIndex - 0.5) * interval - (math.pi * 0.5))
                            local leftPosition = (lineIndex - 1) * interval
                            leftPosition = position + v2.new(math.cos(leftPosition), math.sin(leftPosition)) * size * 0.5
                            left.Position = UDim2.new(0, leftPosition.X, 0, leftPosition.Y)
                            left.Size = UDim2.new(0, distance * 0.5, 0, newSize)
                            left.Rotation = rotation
                            local rightPosition = (lineIndex - 0) * interval
                            rightPosition = position + v2.new(math.cos(rightPosition), math.sin(rightPosition)) * size * 0.5
                            right.Position = UDim2.new(0, rightPosition.X, 0, rightPosition.Y)
                            right.Size = UDim2.new(0, distance * 0.5, 0, newSize)
                            right.Rotation = rotation
                        end
                    end

                    if updateList.Filled ~= nil then
                        if shape.Visible then
                            for _, triangle in drawings.triangles do
                                for _, drawing in triangle do
                                    drawing.Visible = updateList.Filled
                                end
                            end

                            for _, drawing in drawings.lines do
                                drawing.Visible = not updateList.Filled
                            end
                        end
                    end

                    if updateList.Visible ~= nil then
                        if shape.Filled then
                            for _, triangle in drawings.triangles do
                                for _, drawing in triangle do
                                    drawing.Visible = updateList.Visible
                                end
                            end
                        else
                            for _, drawing in drawings.lines do
                                drawing.Visible = updateList.Visible
                            end
                        end
                    end

                    if updateList.Transparency then
                        for _, drawing in drawings.lines do
                            drawing.Transparency = 1 - updateList.Transparency
                        end

                        for _, triangle in drawings.triangles do
                            for _, drawing in triangle do
                                drawing.ImageTransparency = 1 - updateList.Transparency
                            end
                        end
                    end

                    if updateList.Color then
                        for _, drawing in drawings.lines do
                            drawing.BackgroundColor3 = updateList.Color
                        end

                        for _, triangle in drawings.triangles do
                            for _, drawing in triangle do
                                drawing.ImageColor3 = updateList.Color
                            end
                        end
                    end

                    if updateList.ZIndex then
                        for _, drawing in drawings.lines do
                            drawing.ZIndex = updateList.ZIndex
                        end

                        for _, triangle in drawings.triangles do
                            for _, drawing in triangle do
                                drawing.ZIndex = updateList.ZIndex
                            end
                        end
                    end
                elseif shape.shape == "Triangle" then
                    local drawings = shape.drawings

                    if updateList.PointA or updateList.PointB or updateList.PointC or updateList.Thickness then
                        local a, b, c = shape.PointA, shape.PointB, shape.PointC

                        if a and b and c and a ~= b and a ~= c and b ~= c then
                            local p0, p1, p2 = getPointOrder(a, b, c)

                            local line1, line2, line3 = drawings.a, drawings.b, drawings.c
                            local d1 = p1 - p0
                            local mp1 = p0 + d1 * 0.5
                            line1.Position = UDim2.new(0, mp1.X, 0, mp1.Y)
                            line1.Rotation = math.deg(math.atan(d1.Y / d1.X))
                            line1.Size = UDim2.new(0, math.floor(d1.Magnitude + 0.5), 0, math.abs(shape.Thickness))

                            local d2 = p2 - p1
                            local mp2 = p1 + d2 * 0.5
                            line2.Position = UDim2.new(0, mp2.X, 0, mp2.Y)
                            line2.Rotation = math.deg(math.atan(d2.Y / d2.X))
                            line2.Size = UDim2.new(0, math.floor(d2.Magnitude + 0.5), 0, math.abs(shape.Thickness))

                            local d3 = p0 - p2
                            local mp3 = p2 + d3 * 0.5
                            line3.Position = UDim2.new(0, mp3.X, 0, mp3.Y)
                            line3.Rotation = math.deg(math.atan(d3.Y / d3.X))
                            line3.Size = UDim2.new(0, math.floor(d3.Magnitude + 0.5), 0, math.abs(shape.Thickness))

                            renderTriangle(drawings.left, drawings.right, p0, p1, p2)
                        end
                    end

                    if updateList.Filled ~= nil then
                        if shape.Visible then
                            drawings.left.Visible = updateList.Filled
                            drawings.right.Visible = updateList.Filled
                            drawings.a.Visible = not updateList.Filled
                            drawings.b.Visible = not updateList.Filled
                            drawings.c.Visible = not updateList.Filled
                        end
                    end

                    if updateList.Visible ~= nil then
                        if shape.Filled then
                            drawings.left.Visible = updateList.Visible
                            drawings.right.Visible = updateList.Visible
                        else
                            drawings.a.Visible = updateList.Visible
                            drawings.b.Visible = updateList.Visible
                            drawings.c.Visible = updateList.Visible
                        end
                    end

                    if updateList.Color then
                        drawings.left.ImageColor3 = updateList.Color
                        drawings.right.ImageColor3 = updateList.Color
                        drawings.a.BackgroundColor3 = updateList.Color
                        drawings.b.BackgroundColor3 = updateList.Color
                        drawings.c.BackgroundColor3 = updateList.Color
                    end

                    if updateList.Transparency then
                        drawings.left.ImageTransparency = 1