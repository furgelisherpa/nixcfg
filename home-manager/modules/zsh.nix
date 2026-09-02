{pkgs, ...}: {
  # --- module: zsh.nix -----------------------------------------------------
  # Owns the interactive zsh experience: keymap, prompt/metrics, `less` color
  # paging, completions, aliases, and history policy.

  programs.zsh = {
    enable = true;
    # Emacs-style keybindings as the default (consistent with the Emacs-first
    # workflow; vim users can switch with `bindkey -v`).
    defaultKeymap = "emacs";

    initContent = ''
      # Point GPG at the tty so pinentry prompts appear on the right terminal;
      # without this, `gpg` invoked from a GUI/daemon context can't prompt.
      export GPG_TTY=$(tty)

      # Colourize `less` output for the common termcap capabilities, so
      # `man`/`git diff` etc. get syntax-coloured text without `less -R` flags.
      export LESS_TERMCAP_mb=$'\e[1;31m'
      export LESS_TERMCAP_md=$'\e[1;36m'
      export LESS_TERMCAP_me=$'\e[0m'
      export LESS_TERMCAP_so=$'\e[1;44;33m'
      export LESS_TERMCAP_se=$'\e[0m'
      export LESS_TERMCAP_us=$'\e[1;32m'
      export LESS_TERMCAP_ue=$'\e[0m'

      # Pipe `less` through `highlight` for source file ANSI colorization.
      export LESSOPEN="| ${pkgs.highlight}/bin/highlight -O ansi %s 2>/dev/null"

      # vcs_info feeds the git branch into the prompt.
      autoload -Uz add-zsh-hook vcs_info
      add-zsh-hook precmd vcs_info

      zstyle ':vcs_info:git:*' formats ' (%b)'
      zstyle ':vcs_info:*' enable git

      # Allow command substitution / variable expansion inside the prompt.
      setopt PROMPT_SUBST

      # Prompt: user@host:dir + git branch, with the host in red and the branch
      # in yellow.
      PROMPT='%n@%F{red}%m%f:%1~%F{yellow}''${vcs_info_msg_0_}%f $ '
    '';

    completionInit = "autoload -U compinit && compinit";

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Quality-of-life aliases: safer defaults (interactive, verbose destructive
    # commands), prettier output, and common shortcuts.
    shellAliases = {
      # --- safer / more informative core commands ---
      cp = "cp -iv";
      mv = "mv -iv";
      rm = "rm -vI"; # -I: ask before removing many files / -r dirs only
      rsync = "rsync -vrPlu";
      mkd = "mkdir -pv";
      ls = "lsd -h --color=auto --group-directories-first";
      tree = "lsd --tree";
      grep = "grep --color=auto";
      diff = "diff --color=auto";
      ccat = "highlight --out-format=ansi";
      ip = "ip -color=auto";
      bc = "bc -lq";
      python = "python3"; # python is py2 on some systems; force py3
      ffmpeg = "ffmpeg -hide_banner";

      # --- misc shortcuts ---
      sdn = "shutdown -h now";
      nvimdiff = "nvim -d";
      gl = "git log --oneline";
      findstr = "grep -rE --exclude-dir=node_modules --exclude-dir=.git --exclude-dir=lib --exclude-dir=hooks --exclude-dir=.next";

      # --- yt-dlp: default to embedded metadata + the android player client
      # (more reliable/lower-friction on YouTube), with variants by output.
      yt = "yt-dlp --embed-metadata -i --extractor-args \"youtube:player_client=android\"";
      yta = "yt -x --extract-audio --audio-format mp3 --audio-quality 0";
      ytt = "yt --skip-download --write-thumbnail";
      ytv = "yt -f \"bestvideo[height<=1080]+bestaudio/best[height<=1080]\" --merge-output-format mkv";
      ytp = "ytv -ciw -o \"%(playlist_index)s - %(title)s.%(ext)s\"";
      yap = "yta -o \"%(title)s.%(ext)s\"";

      # --- docker: compact status + common one-shot ops ---
      dps = "docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'";
      dpsa = "docker ps -a --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'";
      dex = "docker exec -it";
      dlog = "docker logs -f --tail 100";
      dimg = "docker images";
      dstop = "docker stop $(docker ps -q)";
      drm = "docker rm $(docker ps -a -q)";
      dprune = "docker system prune -a --volumes -f";

      # --- docker compose shortcuts ---
      dc = "docker compose";
      dcup = "docker compose up -d";
      dcdown = "docker compose down";
      dcv = "docker compose down -v";
      dcrebuild = "docker compose up -d --build";
      dclog = "docker compose logs -f --tail 100";
      dcps = "docker compose ps";
    };

    history = {
      size = 10000; # keep 10k lines
      ignoreAllDups = true; # drop older duplicate lines
      path = "$HOME/.zsh_history";
      # Never record destructive/verbose commands (avoid accidental re-runs).
      ignorePatterns = ["rm *" "pkill *"];
    };
  };
}
