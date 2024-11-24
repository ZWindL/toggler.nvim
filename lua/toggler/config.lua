---Provides utilities for configuring user options
---@module 'config'
local config = {}

---Default options
---@type table
config.defaults = {
    ---Prefix can only be one of the 'super','mod'/'alt','shift'
    ---@type string
    ---@value 'mod' or 'alt' or 'super' or 'shift'
    prefix = 'mod',
    ---@type table
    maps = {},
    ---@type boolean
    debug = false,
}

---Validate user options
---@param options table
---@return boolean
config.validate = function (options)
    assert(
        type(options.prefix) == "string",
        "options.prefix must be a table"
    )
    assert(
        vim.tbl_contains({'mod', 'alt', 'super', 'shift'}, options.prefix),
        "options.prefix must be one of 'mod', 'alt', 'super', or 'shift'"
    )
    assert(
        type(options.maps) == "table",
        "options.maps must be a table"
    )
    assert(
        type(options.debug) == "boolean",
        "options.debug must be a boolean"
    )
    return true
end

--- Merge user options with defaults
---@param options table
---@return table
config.merge_config = function(options)
    local options_merged = config.defaults

    -- Override `defaults` with `options`
    options_merged = vim.tbl_deep_extend("force", config.defaults, options)

    -- if pcall(config.validate, options_merged) then
        -- return options_merged
    -- end
    -- return config.defaults
    config.validate(options_merged)
    return options_merged
end

---Setup options, called by `require("toggler").setup(options)`
config.setup = function(opts)
    local options = config.merge_config(opts)
    config.validate(options)
    -- put debug in `_G`
    -- TODO: that doesn't work
    -- _G.plug_toggler.debug = options.debug
    return options
end

return config
