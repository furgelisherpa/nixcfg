{pkgs, ...}: let
  mk = mode: key: cmd: desc: {
    inherit mode key;
    action = "<cmd>FzfLua ${cmd}<CR>";
    options = {
      inherit desc;
      silent = true;
    };
  };
  fz = mk "n";
in {
  programs.nixvim = {
    plugins.fzf-lua = {
      enable = true;
      settings = {
        winopts = {
          height = 0.8;
          width = 0.6;
          preview.hidden = true; # toggle with <F4>
        };
        files.fd_opts = "--color=never --type f --hidden --exclude .git";
        grep.rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden --glob '!.git/*' -e";
        keymap.fzf = {
          __unkeyed-1 = true; # inherit fzf-lua's default fzf binds
          "ctrl-j" = "down";
          "ctrl-k" = "up";
          "ctrl-d" = "preview-page-down";
          "ctrl-u" = "preview-page-up";
        };
      };
    };

    # use fzf-lua for vim.ui.select (replaces telescope ui-select)
    extraConfigLua = ''
      require("fzf-lua").register_ui_select()
    '';

    extraPackages = [
      pkgs.fzf
      pkgs.ripgrep
      pkgs.fd
      pkgs.bat
      pkgs.zoxide
    ];

    # <leader>f
    plugins.which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>f";
        group = "Find";
        icon = "󰍉 ";
      }
    ];

    keymaps = [
      # Files / buffers
      (fz "<leader>ff" "files" "Find files")
      (fz "<leader>fF" "git_files" "Git files")
      (fz "<leader>fo" "oldfiles" "Recently opened files")
      (fz "<leader>fb" "buffers" "Find buffers")
      (fz "<leader>fl" "blines" "Search current buffer lines")
      (fz "<leader>fL" "lines" "Search lines in open buffers")
      (fz "<leader>f/" "global" "Global picker (files/buffers/symbols)")
      (fz "<leader>fz" "zoxide" "Zoxide directories")
      (fz "<leader>fq" "quickfix" "Quickfix list")
      (fz "<leader>fQ" "loclist" "Location list")
      (fz "<leader>ft" "tabs" "Tabs")

      # Grep
      (fz "<leader>fg" "live_grep" "Live grep")
      (fz "<leader>fG" "grep_project" "Grep project lines")
      (fz "<leader>fw" "grep_cword" "Grep word under cursor")
      (fz "<leader>fW" "grep_cWORD" "Grep WORD under cursor")
      (fz "<leader>f." "live_grep_resume" "Resume last live grep")
      (mk "v" "<leader>fw" "grep_visual" "Grep visual selection")

      # Git
      (fz "<leader>fc" "git_commits" "Git commits")
      (fz "<leader>fC" "git_bcommits" "Buffer commits")
      (fz "<leader>fB" "git_branches" "Git branches")
      (fz "<leader>fS" "git_status" "Git status")
      (fz "<leader>fs" "git_stash" "Git stash")
      (fz "<leader>fT" "git_tags" "Git tags")
      (fz "<leader>fH" "git_hunks" "Git hunks")
      (fz "<leader>fv" "git_blame" "Git blame (buffer)")

      # LSP (list-producing actions live here)
      (fz "<leader>ld" "lsp_definitions" "Definitions")
      (fz "<leader>lD" "lsp_declarations" "Declarations")
      (fz "<leader>lR" "lsp_references" "References")
      (fz "<leader>lI" "lsp_implementations" "Implementations")
      (fz "<leader>lt" "lsp_typedefs" "Type definitions")
      (fz "<leader>la" "lsp_code_actions" "Code actions")
      (fz "<leader>lA" "lsp_finder" "LSP finder (all locations)")
      (fz "<leader>li" "lsp_incoming_calls" "Incoming calls")
      (fz "<leader>lo" "lsp_outgoing_calls" "Outgoing calls")

      # Symbols / diagnostics stay under the find prefix
      (fz "<leader>fy" "lsp_document_symbols" "Document symbols")
      (fz "<leader>fY" "lsp_live_workspace_symbols" "Workspace symbols")
      (fz "<leader>fd" "diagnostics_document" "Document diagnostics")
      (fz "<leader>fD" "diagnostics_workspace" "Workspace diagnostics")

      # Meta / Neovim
      (fz "<leader>fh" "helptags" "Help tags")
      (fz "<leader>fk" "keymaps" "Keymaps")
      (fz "<leader>fr" "resume" "Resume last search")
      (fz "<leader>fp" "builtin" "fzf-lua builtin commands")
      (fz "<leader>f:" "command_history" "Command history")
      (fz "<leader>fn" "commands" "Commands")
      (fz "<leader>f?" "search_history" "Search history")
      (fz "<leader>fm" "marks" "Marks")
      (fz "<leader>fj" "jumps" "Jumplist")
      (fz "<leader>fe" "registers" "Registers")
      (fz "<leader>fu" "undotree" "Undo tree")
      (fz "<leader>fM" "manpages" "Man pages")
      (fz "<leader>fN" "nvim_options" "Neovim options")
      (fz "<leader>f=" "spell_suggest" "Spelling suggestions")
    ];
  };
}
