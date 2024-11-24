local ui = {}

ui.line_text = ''

---Render the UI of toggler.nvim, each map is a table containing a number,
---a function, an icon.
---@param maps table
ui.render_line = function (maps)
    -- Use a hash table to store the latest entry for each number
    local unique_maps = {}

    -- Process each map, overwriting duplicates
    for _, map in pairs(maps) do
        -- Validate required number field
        if type(map.number) ~= "number" then
            error("Each map must have a number field")
        end

        -- Validate required icon field
        if type(map.icon) ~= "string" then
            error("Each map must have an icon")
        end

        -- Store the map using its number as the key, overwriting any previous entry
        unique_maps[map.number] = map
    end

    -- Create result array
    local result = {}

    -- Build display strings for deduped maps
    for i, map in ipairs(unique_maps) do
        local display = "["..tostring(i)..":"
        display = display..map.icon.."]"
        table.insert(result, display)
    end

    -- Concatenate all parts
    ui.line_text = table.concat(result, "")
    return ui.line_text
end

ui.get_line_text = function ()
    return ui.line_text
end

return ui
