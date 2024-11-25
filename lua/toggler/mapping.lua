local mapper = {}

---Map keys, each map is a table containing a number, a function,
---an optional icon and an optional memonic letter.
---@param prefix string
---@param maps table
---@value prefix 'mod' or 'alt' or 'super' or 'shift' or 'ctrl'
mapper.bind = function (prefix, maps)
    -- Validate prefix
    if not prefix or not vim.tbl_contains({'mod', 'alt', 'super', 'shift', 'ctrl'}, prefix) then
        error("Invalid prefix. Must be 'mod', 'alt', 'super', 'ctrl', or 'shift'")
    end

    -- Convert 'mod' to 'alt' as they are equivalent
    local actual_prefix = ''
    if prefix == 'mod' or prefix == 'alt' then
        actual_prefix = 'A'
    elseif prefix == 'super' then
        actual_prefix = 'D'
    elseif prefix == 'ctrl' then
        actual_prefix = 'C'
    else
        actual_prefix = 'S'
    end

    -- Iterate through maps
    for _, map in ipairs(maps) do
        -- Validate required fields
        if not map.number or type(map.number) ~= "number" then
            error("Each map must contain a 'number' field of type number")
        end
        if not map.callback or (type(map.callback) ~= "function" and type(map.callback) ~= "string") then
            error("Each map must contain a 'callback' field of type function or string")
        end

        -- Create the keymap
        local lhs = string.format("<%s-%d>", actual_prefix, map.number)
        local mode = 'n'

        vim.keymap.set(mode, lhs, map.callback, {
            silent = true
        })
    end
end

return mapper
