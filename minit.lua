local lazypath = "./build/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

-- install lazy if it doesn't exist
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

require("lazy").setup({
    spec = {
        {
            dir = "./",
            config = function ()
                require("toggler").setup({
                    maps = {
                        {
                            number = 1,
                            icon = 'A',
                            callback = function ()
                                print("test 1")
                            end
                        },
                        {
                            number = 2,
                            icon = 'B',
                            callback = function ()
                                print("test 2")
                            end
                        },
                        {
                            number = 2,
                            icon = 'C',
                            callback = function ()
                                print("test 3")
                            end
                        }
                    },
                })
            end
        },
        {
            "nvim-lualine/lualine.nvim",
            config = function ()
                require("lualine").setup({
                    sections = {
                        lualine_x = {
                            function ()
                                return require("toggler").ui_line_text()
                            end
                        }
                    }
                })
            end
        },
    },
    dev = {
        path = "./",
        fallback = false,
    },
    -- defaults = {
    --     spec = {
    --     },
    -- },
    -- {
    -- },
})
