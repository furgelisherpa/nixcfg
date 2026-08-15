{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";

    initContent = ''
      export GPG_TTY=$(tty)

      export LESS_TERMCAP_mb=$'\e[1;31m'
      export LESS_TERMCAP_md=$'\e[1;36m'
      export LESS_TERMCAP_me=$'\e[0m'
      export LESS_TERMCAP_so=$'\e[1;44;33m'
      export LESS_TERMCAP_se=$'\e[0m'
      export LESS_TERMCAP_us=$'\e[1;32m'
      export LESS_TERMCAP_ue=$'\e[0m'

      export LESSOPEN="| ${pkgs.highlight}/bin/highlight -O ansi %s 2>/dev/null"

      autoload -Uz add-zsh-hook vcs_info

      add-zsh-hook precmd vcs_info

      zstyle ':vcs_info:git:*' formats ' (%b)'
      zstyle ':vcs_info:*' enable git

      setopt PROMPT_SUBST

      PROMPT='%n@%F{red}%m%f:%1~%F{yellow}''${vcs_info_msg_0_}%f $ '
    '';

    completionInit = "autoload -U compinit && compinit";

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Quality-of-life aliases: safer defaults, prettier output, common shortcuts
    shellAliases = {
      cp = "cp -iv";
      mv = "mv -iv";
      rm = "rm -vI";
      rsync = "rsync -vrPlu";
      mkd = "mkdir -pv";
      ls = "lsd -h --color=auto --group-directories-first";
      tree = "lsd --tree";
      grep = "grep --color=auto";
      diff = "diff --color=auto";
      ccat = "highlight --out-format=ansi";
      ip = "ip -color=auto";
      bc = "bc -lq";
      python = "python3";
      ffmpeg = "ffmpeg -hide_banner";
      sdn = "shutdown -h now";
      emacs = "setsid -f emacsclient -c -a 'emacs' >/dev/null 2>&1";
      nvimdiff = "nvim -d";
      gl = "git log --oneline";
      findstr = "grep -rE --exclude-dir=node_modules --exclude-dir=.git --exclude-dir=lib --exclude-dir=hooks --exclude-dir=.next";
      yt = "yt-dlp --embed-metadata -i --extractor-args \"youtube:player_client=android\"";
      yta = "yt -x --extract-audio --audio-format mp3 --audio-quality 0";
      ytt = "yt --skip-download --write-thumbnail";
      ytv = "yt -f \"bestvideo[height<=1080]+bestaudio/best[height<=1080]\" --merge-output-format mkv";
      ytp = "ytv -ciw -o \"%(playlist_index)s - %(title)s.%(ext)s\"";
      yap = "yta -o \"%(title)s.%(ext)s\"";

      # Docker shortcuts
      dps = "docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'";
      dpsa = "docker ps -a --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'";
      dex = "docker exec -it";
      dlog = "docker logs -f --tail 100";
      dimg = "docker images";
      dstop = "docker stop $(docker ps -q)";
      drm = "docker rm $(docker ps -a -q)";
      dprune = "docker system prune -a --volumes -f";

      # Docker Compose shortcuts
      dc = "docker compose";
      dcup = "docker compose up -d";
      dcdown = "docker compose down";
      dcv = "docker compose down -v";
      dcrebuild = "docker compose up -d --build";
      dclog = "docker compose logs -f --tail 100";
      dcps = "docker compose ps";
    };

    history = {
      size = 10000;
      ignoreAllDups = true;
      path = "$HOME/.zsh_history";
      ignorePatterns = ["rm *" "pkill *" "cp *"];
    };
  };
}
