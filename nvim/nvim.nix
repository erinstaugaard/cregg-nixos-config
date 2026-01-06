{ config, pkgs, ... }@inputs:
{

  programs.nixvim = {
    enable = true;
    # plugins = {
    #
    #   # friendly-snippets.enable = true;
    #
    #   luasnip = {
    #     enable = true;
    #
    #     fromVscode = [
    #       {
    #         paths = ./snippets;
    #       }
    #     ];
    #
    #   };
    #
    #   cmp_luasnip.enable = true;
    #   cmp = {
    #     enable = true;
    #     autoEnableSources = true;
    #     settings.sources = [ { name = "luasnip"; } ];
    #
    #     settings.mapping = {
    #       "<CR>" = "cmp.mapping.confirm({select = true})";
    #       "<Tab>" = ''
    #
    #                                   cmp.mapping(
    #                                   	       function(fallback)
    #         				         luasnip = require("luasnip")
    #                                   		 if cmp.visible() then
    #                                   		   cmp.select_next_item()
    #                                   		 elseif luasnip.expandable() then
    #                                   		   luasnip.expand()
    #                                   		 elseif luasnip.expand_or_jumpable() then
    #                                   		   luasnip.expand_or_jump()
    #                                   		 else
    #                                   		   fallback()
    #                                   		 end
    #                     		      end, { 'i', 's' })
    #       '';
    #     };
    #   };
    # };
    # extraConfigLua = ''
    #   require("luasnip").log.set_loglevel("info")
    # '';

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
        callback = {
          __raw = "
    function()
    	vim.lsp.buf.format()
    	if (vim.bo.filetype == 'uiua') then
    		vim.cmd(':e')
    	end
    end

    ";
        };
        # command = "lua vim.lsp.buf.format()";
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
    plugins.luasnip = {
      enable = true;

      fromVscode = [
        {
          paths = ./snippets;
        }
      ];
      # };
    };

    plugins.lsp = {
      enable = true;
      servers = {
        rust-analyzer.enable = true;
        nil_ls.enable = true;
        ocamllsp.enable = true;
        html.enable = true;
        uiua.enable = true;
        clangd.enable = true;
        clangd.cmd = [
          "clangd"
          "--background-index"
          "--clang-tidy"
          "--query-driver=**/g++"
        ];
        clangd.package = pkgs.clang-tools;
        clangd.packageFallback = true;
        cmake.enable = true;

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

    plugins.cmp_luasnip.enable = true;

    plugins.cmp = {
      enable = true;
      autoEnableSources = true;
      settings.sources = [
        { name = "nvim_lsp"; }
        { name = "path"; }
        { name = "buffer"; }
        {
          name = "luasnip";
          keywordLength = 3;
          option = {
            show_autosnippets = true;
          };
        }
      ];
      settings.mapping = {
        "<CR>" =
          "cmp.mapping.confirm {
    		behavior = cmp.ConfirmBehavior.Replace,
    		select = true,
    	}";
        "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
        "<C-l>" = ''
                    cmp.mapping(function()
          	    luasnip = require("luasnip")
                      if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                      end
                    end, { 'i', 's' })
        '';
        "<C-h>" = ''
                    cmp.mapping(function()
          	    luasnip = require("luasnip")
                      if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                      end
                    end, { 'i', 's' })
        '';
      };
      settings.snippet = {
        expand = ''
          	      function(args)
          		  require("luasnip").lsp_expand(args.body)
          	      end
        '';
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      base16-nvim
    ];

    extraConfigLua = ''
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      vim.lsp.config('html', {
        capabilities = capabilities,
      })
               	vim.o.guifont = "${config.stylix.fonts.serif.name}:h12";
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
