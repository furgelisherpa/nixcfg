{
  config,
  pkgs,
  ...
}: let
  userscriptsPath = "${config.home.homeDirectory}/.local/share/qutebrowser/userscripts";
in {
  programs.qutebrowser = {
    enable = true;

    package = pkgs.qutebrowser.override {
      python3 = pkgs.python3.withPackages (ps: [ps.adblock]);
    };

    settings = {
      content = {
        javascript.clipboard = "access";
        blocking.method = "hosts";
      };

      statusbar.show = "never";

      tabs = {
        position = "left";
        show = "switching";
      };

      content.cookies.accept = "no-3rdparty";

      fonts = {
        statusbar = "10pt Jetbrains Mono Nerd Font";
        hints = "10pt Jetbrains Mono Nerd Font";
        completion.entry = "10pt Jetbrains Mono Nerd Font";
      };

      colors = {
        tabs = {
          bar.bg = "#0d1117";
          even = {
            bg = "#0d1117";
            fg = "#17f501";
          };
          odd = {
            bg = "#0d1117";
            fg = "#17f501";
          };
          selected.even = {
            bg = "#0d1117";
            fg = "#ffffff";
          };
          selected.odd = {
            bg = "#0d1117";
            fg = "#ffffff";
          };
        };

        statusbar.normal = {
          bg = "#0d1117";
          fg = "#ffffff";
        };

        hints = {
          bg = "#0d1117";
          fg = "#17f501";
          match.fg = "#ffffff";
        };

        completion = {
          category = {
            bg = "#0d1117";
            fg = "#17f501";
          };
          even.bg = "#0d1117";
          odd.bg = "#0d1117";
          fg = "#17f501";
          match.fg = "#ffffff";
          item.selected = {
            bg = "#999999";
            fg = "#000000";
          };
        };
      };
    };

    extraConfig = ''
      # Cookies - site-specific
      config.set("content.cookies.accept", "no-3rdparty", "chrome-devtools://*")
      config.set("content.cookies.accept", "no-3rdparty", "devtools://*")

      # Accept-Language header
      config.set("content.headers.accept_language", "", "https://matchmaker.krunker.io/*")

      # User agent
      config.set("content.headers.user_agent", "Mozilla/5.0 ({os_info}; rv:136.0) Gecko/20100101 Firefox/139.0", "https://accounts.google.com/*")

      # Images
      config.set("content.images", True, "chrome-devtools://*")
      config.set("content.images", True, "devtools://*")

      # JavaScript
      config.set("content.javascript.enabled", True, "chrome-devtools://*")
      config.set("content.javascript.enabled", True, "devtools://*")
      config.set("content.javascript.enabled", True, "chrome://*/*")
      config.set("content.javascript.enabled", True, "qute://*/*")

      # Local content access
      config.set("content.local_content_can_access_remote_urls", True, "file://${userscriptsPath}/*")
      config.set("content.local_content_can_access_file_urls", False, "file://${userscriptsPath}/*")

      # Default Editor
      c.editor.command = ["emacsclient", "-c", "-a", "emacs", "{file}"]
    '';
  };
}
