return {
	"norcalli/nvim-colorizer.lua",
	lazy = false,
	enable = true,
	ft = {
		"css",
		"html",
		"jinja",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
	config = function() require("colorizer").setup() end,
	--opts = {
	--    {'*'}, {
	--        RGB = true, -- #RGB hex codes
	--        RRGGBB = true, -- #RRGGBB hex codes
	--        names = true, -- "Name" codes like Blue
	--        RRGGBBAA = true, -- #RRGGBB hex codes
	--        rgb_fn = true, -- CSS rgb() and rgba() functions
	--        hsl_fn = true, -- CSS hsl() and hsla() functions
	--        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
	--        css_fn = true -- Enable all CSS *functions*: rgb_fn, hsl_fn
	--    }
	--}
}
