local config = require("toggler.config")
local mapper = require("toggler.mapping")
local ui = require("toggler.ui")
local M = {}

---Initialize the toggler
---@param options table
---@return nil
M.setup = function(options)
    local opts = config.setup(options)
    mapper.bind(opts.prefix, opts.maps)
    ui.render_line(opts.maps)
end

M.ui_line_text = ui.get_line_text

return M
