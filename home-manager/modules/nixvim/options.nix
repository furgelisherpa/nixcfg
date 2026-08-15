{...}: {
  programs.nixvim = {
    opts = {
      # General settings
      shortmess = "I"; # Disable startup intro message (or use shortmess = vim.opt.shortmess + "I")
      mouse = "a"; # Enable mouse support
      clipboard = "unnamedplus"; # Sync with system clipboard
      autowrite = true; # Auto-save buffer on buffer switch
      modifiable = true; # Allow buffer modifications
      path = [
        "."
        "**"
        "**/*"
      ];

      # UI & Appearance
      termguicolors = true; # True color support
      number = true; # Print line numbers
      relativenumber = true; # Relative line numbers
      cursorline = true; # Highlight the current line
      guicursor = "n-v-c-sm:block,ci-ve:ver25,r-cr-o:hor20,i:block-blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"; # Block cursor in every mode
      showmode = false; # Hide default mode display
      signcolumn = "yes"; # Always show sign column
      colorcolumn = "80"; # Highlight column 80
      textwidth = 80; # Max width for code wrapping
      scrolloff = 10; # Minimum screen lines above/below cursor
      sidescrolloff = 10; # Minimum screen columns to left/right of cursor
      laststatus = 3; # use same statusline for multiple windows

      # Windows & Splitting
      splitbelow = true; # Horizontal splits go below
      splitright = true; # Vertical splits go right
      winborder = "none"; # No borders on floating windows

      # Tabs & Indentation
      tabstop = 2; # Spaces per tab
      shiftwidth = 2; # Spaces per autoindent step
      softtabstop = 2; # Spaces for softtabstop
      expandtab = true; # Use spaces instead of tabs
      autoindent = true; # Copy indent from current line
      smartindent = true; # Smart autoindenting

      # Searching
      hlsearch = false; # Clear search highlights on completion
      incsearch = true; # Show search matches incrementally
      ignorecase = true; # Ignore case in search patterns
      smartcase = true; # Override ignorecase if search contains uppercase

      # Files & Backups
      swapfile = false; # Disable swap files
      backup = false; # Disable backup files
      writebackup = false; # Disable write backups
      undofile = true; # Maintain undo history across sessions
      undolevels = 10000; # Increase undo history depth
      updatetime = 300; # Faster Completion
      timeoutlen = 300; # Key timeout duration
      ttimeoutlen = 0; # Key code timeout
      autoread = true; # Autoread files changed outside vim

      # Concealing & List Characters
      conceallevel = 0; # Conceal markup syntax
      concealcursor = "nc"; # Conceal in normal/command modes
      completeopt = "menu,menuone,noinsert,noselect"; # Completion options
      list = true; # Display listchars
      listchars = {
        tab = "» ";
        trail = "·";
        nbsp = "␣";
      };
      fillchars = {
        eob = " "; # Hide "~" lines after end of buffer
        fold = " ";
        foldopen = "▾";
        foldclose = "▸";
        foldsep = " ";
      };

      # Folding Defaults
      foldmethod = "manual";
      foldenable = true;
      foldlevel = 99;
      foldlevelstart = 99;

      # Advanced Substitutions & Macros
      inccommand = "nosplit"; # Live preview of substitutions
      gdefault = true; # Swap all instances in a line by default
      formatoptions = "jcroql"; # Appends "j" while maintaining standard defaults
    };

    globals = {
      mapleader = " "; # or whatever key you use as leader
      maplocalleader = " ";
    };

    # Disable the built-in netrw file explorer (nvim-tree replaces it)
    extraConfigLua = ''
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      -- vim.opt.path:append("**")
    '';
  };
}
