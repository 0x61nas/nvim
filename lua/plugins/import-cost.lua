return {
	"barrett-ruth/import-cost.nvim",
	build = [[
    #! /usr/bin/env nix-shell
    #! nix-shell -i bash -p nodePackages_latest.pnpm

    sh install.sh pnpm
  ]],
	config = true,
}
