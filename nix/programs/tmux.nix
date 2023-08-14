{ pkgs, ... }:

let
  catppuccin-tmux = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "catppuccin";
    version = "unstable-2023-08-11d";
    src = pkgs.fetchFromGitHub {
      owner = "gabriellhrn";
      repo = "catppuccin-tmux";
      rev = "main";
      sha256 = "XHq1RiQ3v6VpeXFqycHVblgSKsbBv5WoXB6jMTvhZSE=";
    };
  };

in
{
  home.packages = [
    pkgs.gnused
    pkgs.tmux
  ];

  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    terminal = "tmux-256color";
    historyLimit = 10000;

    plugins = with pkgs.tmuxPlugins; [
        sensible

        {
          plugin = catppuccin-tmux;
          extraConfig = ''
            set -g @catppuccin_flavour 'frappe' # latte, frappe, macchiato, mocha

            set -g @catppuccin_window_left_separator "█"
            set -g @catppuccin_window_middle_separator "█ "
            set -g @catppuccin_window_right_separator "██"
            set -g @catppuccin_window_number_position "left"

            set -g @catppuccin_window_status_icon_enable "yes"

            set -g @catppuccin_window_current_fill "number"
            set -g @catppuccin_window_default_fill "number"
            set -g @catppuccin_window_current_text "#{b:pane_current_path}"
            set -g @catppuccin_window_default_text "#{b:pane_current_path}"

            set -g @catppuccin_status_left_separator " "
            set -g @catppuccin_status_right_separator "█"
            set -g @catppuccin_status_connect_separator "yes"
            set -g @catppuccin_status_fill "icon"

            set -g @catppuccin_application_icon "󰙵"

            set -g @catppuccin_status_modules "application session battery kube date_time host"
            set -g @catppuccin_date_time_text "%Y-%m-%d %H:%M"
          '';
        }

        {
          plugin = battery;
        }

        {
          plugin = resurrect;
        }

        {
          plugin = continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
            set -g @continuum-boot 'on'
            set -g @continuum-save-interval '10'
          '';
        }
    ];

    extraConfig = ''
        # change prefix: C-b -> C-a
        unbind C-b
        set -g prefix C-a
        bind-key C-a send-prefix

        # default Esc behaviour causes delay in vim
        set -s escape-time 0

        # better plane splitting commands
        bind c new-window -c "#{pane_current_path}"
        bind L split-window -h -c "#{pane_current_path}"
        bind l split-window -v -c "#{pane_current_path}"
        unbind "\""
        unbind %

        # set r to reload config file
        bind r source-file ~/.tmux.conf \; display-message "Config reloaded!"
        bind R source-file ~/.tmux.conf \; display-message "Config reloaded!"

        # navigate between panes using Alt-arrow
        bind -n M-Left select-pane -L
        bind -n M-Right select-pane -R
        bind -n M-Up select-pane -U
        bind -n M-Down select-pane -D

        # set vi navigation
        setw -g mode-keys vi

        bind -T copy-mode-vi v send-keys -X begin-selection
        bind -T copy-mode-vi y send-keys -X copy-pipe "xclip -in -selection clipboard"

        # scrolling
        setw -g mouse on
        set -g history-limit 10000
    '';
  };
}
