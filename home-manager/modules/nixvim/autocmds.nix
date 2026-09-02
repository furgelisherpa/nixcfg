{...}: {
  # --- module: nixvim/autocmds.nix ----------------------------------------
  # Global autocommands: highlight-yank feedback, auto window rebalance,
  # cursor-position restore, `q` to close helper windows, directory creation on
  # save, and line-number suppression inside terminals.

  programs.nixvim = {
    # Define autocmd groups
    autoGroups = {
      highlight_yank.clear = true;
      resize_splits.clear = true;
      last_loc.clear = true;
      close_with_q.clear = true;
      create_dir_on_save.clear = true;
      line_nums_on_term.clear = true;
    };

    # Define autocommands
    autoCmd = [
      # Highlight yanked text
      {
        event = ["TextYankPost"];
        group = "highlight_yank";
        callback = {
          __raw = ''
            function()
            vim.hl.on_yank({ higroup = "IncSearch", timeout = 150 })
            end
          '';
        };
      }

      # Resize splits when window is resized
      {
        event = ["VimResized"];
        group = "resize_splits";
        callback = {
          __raw = ''
            function()
            local current_tab = vim.fn.tabpagenr()
            vim.cmd("tabdo wincmd =")
            vim.cmd(tostring(current_tab) .. "tabnext")
            end
          '';
        };
      }

      # Restore cursor position on file open
      {
        event = ["BufReadPost"];
        group = "last_loc";
        callback = {
          __raw = ''
              function(event)
              local exclude = { "gitcommit", "NvimTree" }
            local buf = event.buf
              if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazy_last_loc then
                return
                  end
                  vim.b[buf].lazy_last_loc = true
                  local mark = vim.api.nvim_buf_get_mark(buf, '"')
                  local lcount = vim.api.nvim_buf_line_count(buf)
                  if mark[1] > 0 and mark[1] <= lcount then
                    pcall(vim.api.nvim_win_set_cursor, 0, mark)
                      end
                      end
          '';
        };
      }

      # Close helper windows with 'q'
      {
        event = ["FileType"];
        group = "close_with_q";
        pattern = [
          "PlenaryTestPopup"
          "help"
          "lspinfo"
          "notify"
          "qf"
          "query"
          "spectre_panel"
          "startuptime"
          "tsplayground"
          "checkhealth"
          "dap-float"
        ];
        callback = {
          __raw = ''
            function(event)
            vim.bo[event.buf].buflisted = false
            vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
            end
          '';
        };
      }

      # Auto create dir on save
      {
        event = ["BufWritePre"];
        group = "create_dir_on_save";
        callback = {
          __raw = ''
            function()
              local dir = vim.fn.expand('<afile>:p:h')
              if vim.fn.isdirectory(dir) == 0 then
                vim.fn.mkdir(dir, 'p')
              end
            end
          '';
        };
      }

      # Disable line numbers on terminal mode
      {
        event = ["TermOpen"];
        group = "line_nums_on_term";
        callback = {
          __raw = ''
            function()
              vim.opt_local.number = false
              vim.opt_local.relativenumber = false
              vim.opt_local.signcolumn = "no"
            end
          '';
        };
      }
    ];
  };
}
