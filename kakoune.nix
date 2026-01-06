{
  config,
  pkgs,
  ...
}:
{

  programs.kakoune = {
    enable = true;

    config = {
      hooks = [
        {
          commands = ''
            	kakboard-enable
          '';
          name = "WinCreate";
          option = ".*";
        }
        {
          commands = ''
            map window insert <tab> <c-n>
            hook -once -always window InsertCompletionHide .* %{
                unmap window insert <tab> <c-n>
            }
          '';
          name = "InsertCompletionShow";
          option = ".*";
        }
        {
          commands = ''
            	lsp-formatting
          '';
          name = "BufWritePre";
          option = ".*";
        }
        {
          commands = '''';
          # set-option -add buffer snippets 'bevy plugin'   'bepl' %{ snippets-insert %{ pub struct ''${plugin}; impl Plugin for ''${plugin} {} }}
          name = "BufSetOption";
          option = "filetype=rust";
        }
      ];

    };

    defaultEditor = true;
    plugins = [
      pkgs.kakoune-lsp

      pkgs.kakounePlugins.kakboard

      pkgs.kakounePlugins.fzf-kak

    ];
    extraConfig = ''
      eval %sh{${pkgs.kakoune-lsp}/bin/kak-lsp}
      lsp-enable

      set-option global modelinefmt "%opt{lsp_modeline} %opt{modelinefmt}"

      map global user l ':enter-user-mode lsp<ret>' -docstring 'LSP mode'

      map global insert <c-l> '<a-;>:try lsp-snippets-select-next-placeholders catch %{ execute-keys -with-hooks <lt>tab> }<ret>' -docstring 'Select next snippet placeholder'

      map global normal <c-p> ': fzf-mode<ret>f'

      define-command update-status %{ evaluate-commands %sh{
        printf %s 'set-option buffer modelinefmt %{'
        if [ "$kak_opt_lsp_diagnostic_error_count" -ne 0 ]; then
          printf %s '{DiagnosticError}%opt{lsp_diagnostic_error_count}!{Default} '
        fi
        if [ "$kak_opt_lsp_diagnostic_warning_count" -ne 0 ]; then
          printf %s '{DiagnosticWarning}%opt{lsp_diagnostic_warning_count}!{Default} '
        fi
        printf %s '{{context_info}} {{mode_info}} '
        printf %s ' · %val{bufname} [%opt{filetype}]'
        printf %s ' · %val{cursor_line}:%val{cursor_char_column}/%val{buf_line_count}'
        case "$kak_client" in client*) ;; *) printf %s " · $kak_client";; esac
        case "$kak_session" in \'\'|*[!0-9]*) printf %s " @$kak_session";; esac
        printf %s '}'
      }}
      hook global WinDisplay .* update-status
      hook global BufSetOption lsp_diagnostic_error_count=.* update-status
      hook global BufSetOption lsp_diagnostic_warning_count=.* update-status
    '';
  };

  # lsp servers
  home.packages = [
    # pkgs.rust-analyzer
    pkgs.nil
  ];

}
