{ config, pkgs, ... }@inputs:
{

  programs.nixvim = {
    enable = true;
    keymaps = [
      {
        mode = "n";
        key = "<leader>ep";
        action = "<cmd>e .<CR>";
      }
      {
        mode = "n";
        key = "<leader>ca";
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
      }
      {
        mode = "n";
        key = "<leader>rn";
        action = "<cmd>lua vim.lsp.buf.rename()<CR>";
      }
      {
        mode = "n";
        key = "<Space>";
        action = "<Nop>";

      }
    ];

    opts = {
      number = true;
    };
    globals = {
      mapleader = " ";
    };

    autoCmd = [
      {
        command = "lua vim.lsp.buf.format()";
        event = "BufWritePre";
      }
    ];

    clipboard.register = "unnamedplus";

    plugins.tiny-inline-diagnostic.enable = true;

    plugins.telescope = {
      enable = true;
      keymaps = {
        "<C-p>" = {
          action = "git_files";
        };
        "gd" = {
          action = "lsp_definitions";
        };
      };
    };
    plugins.lualine.enable = true;

    plugins.lsp = {
      enable = true;
      servers = {
        rust-analyzer.enable = true;
        nil_ls.enable = true;

      };
    };

    plugins.treesitter = {
      enable = true;
      settings.highlight.enable = true;
    };

    plugins.fidget.enable = true;

    plugins.oil = {
      enable = true;
      settings.keymaps = {
        "<C-p>" = false;
      };

    };

    plugins.cmp = {
      enable = true;
      autoEnableSources = true;
      settings.sources = [
        { name = "nvim_lsp"; }
        { name = "path"; }
        { name = "buffer"; }
      ];
      settings.mapping = {
        "<CR>" = "cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}";
        "<Tab>" =
          "
			cmp.mapping(function(fallback)
			      if cmp.visible() then
				cmp.select_next_item()
			      else
				fallback()
			      end
			    end, { 'i', 's' }),";
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      base16-nvim
    ];

    extraConfigLua = ''
         	vim.o.guifont = "${config.stylix.fonts.serif.name}";
      	require("base16-colorscheme").setup({
      	 base00= "#${config.lib.stylix.colors.base00}",
      	 base01= "#${config.lib.stylix.colors.base01}",
      	 base02= "#${config.lib.stylix.colors.base02}",
      	 base03= "#${config.lib.stylix.colors.base03}",
      	 base04= "#${config.lib.stylix.colors.base04}",
      	 base05= "#${config.lib.stylix.colors.base05}",
      	 base06= "#${config.lib.stylix.colors.base06}",
      	 base07= "#${config.lib.stylix.colors.base07}",
      	 base08= "#${config.lib.stylix.colors.base08}",
      	 base09= "#${config.lib.stylix.colors.base09}",
      	 base0A= "#${config.lib.stylix.colors.base0A}",
      	 base0B= "#${config.lib.stylix.colors.base0B}",
      	 base0C= "#${config.lib.stylix.colors.base0C}",
      	 base0D= "#${config.lib.stylix.colors.base0D}",
      	 base0E= "#${config.lib.stylix.colors.base0E}",
      	 base0F= "#${config.lib.stylix.colors.base0F}"
             })

    '';
  };
}
