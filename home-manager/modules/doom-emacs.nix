{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [inputs.nix-doom-emacs-unstraightened.homeModule];

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    inter
    fira-code
    alegreya
    emacs-lsp-booster
  ];

  programs.doom-emacs = {
    enable = true;
    doomDir = inputs.doom-config;
    experimentalFetchTree = true;
    doomLocalDir = "${config.home.homeDirectory}/.local/share/nix-doom";

    emacs = pkgs.emacs-pgtk;

    extraPackages = epkgs: [
      (epkgs.treesit-grammars.with-grammars
        (grammars:
          with grammars; [
            tree-sitter-javascript
            tree-sitter-typescript
            tree-sitter-tsx
            tree-sitter-json
            tree-sitter-jsdoc
            tree-sitter-yaml
            tree-sitter-css
            tree-sitter-html
            tree-sitter-nix
            tree-sitter-bash
            tree-sitter-markdown
            tree-sitter-c
            tree-sitter-cpp
          ]))
    ];
    extraBinPackages = with pkgs; [
      # Emacs ext. deps
      libtool
      pkg-config
      poppler
      vips

      # Nix
      nixd
      alejandra

      # C/C++
      clang-tools
      gcc
      gnumake
      cmake

      # latex
      texlab
      texliveFull
      texlivePackages.dvisvgm

      # lua
      lua-language-server

      # python
      # pyright
      # uv

      # Jupyter
      jupyter
      gnuplot

      # bash
      bash-language-server

      # Javascript/TypeScript/TailwindCss
      nodejs
      typescript
      typescript-language-server
      vscode-langservers-extracted
      vscode-js-debug
      tailwindcss-language-server
      prettier

      # Markdown
      pandoc
      python3Packages.grip

      # Rst
      python3Packages.docutils

      # YAML
      yaml-language-server

      # Java
      java-language-server

      # Shell
      shellcheck
      # shfmt

      # Docker
      docker
      docker-compose
      dockerfile-language-server

      # Direnv
      direnv

      # Editorconfig
      editorconfig-core-c

      # App
      xdotool
      xclip
      libnotify
      wl-clipboard

      # All the the icons
      emacs-all-the-icons-fonts

      # Spell checker
      ispell
    ];
  };

  services.emacs = {
    enable = true;
    client.enable = true;
    startWithUserSession = "graphical";
  };

  systemd.user.services.emacs.Service.Environment = [
    "DISPLAY=:1"
    "WAYLAND_DISPLAY=wayland-1"
  ];

  home.sessionVariables.EDITOR = "emacsclient -c -a ''";
}
