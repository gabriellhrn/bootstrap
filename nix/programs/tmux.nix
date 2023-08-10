{ pkgs, ... }:

{
  home.packages = [
    pkgs.tmux
  ];

  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    terminal = "tmux-256color";
    historyLimit = 10000;

    plugins = with pkgs.tmuxPlugins; [
        battery
        continuum
        resurrect
        sensible

        {
          plugin = mkTmuxPlugin {
            pluginName = "kube-tmux";
            version = "2023-08-10";
            src = pkgs.fetchFromGitHub {
              owner = "jonmosco";
              repo = "kube-tmux";
              rev = "c127fc2181722c93a389534549a217aef12db288";
              sha256 = "2EMSV6z9FZHq20dkPna0qELSVIOIAnOHpiCLbG7adQQ=";
            };
          };
        }

        {
          plugin = catppuccin;
          extraConfig = ''
            set -g @catppuccin_flavour 'frappe' # latte, frappe, macchiato, mocha

            set -g @catppuccin_window_left_separator "█"
            set -g @catppuccin_window_middle_separator "█ "
            set -g @catppuccin_window_right_separator "██"
            set -g @catppuccin_window_number_position "left"

            set -g @catppuccin_window_status_icon_enable "yes"

            set -g @catppuccin_window_current_fill "number"
            set -g @catppuccin_window_default_fill "number"

            set -g @catppuccin_status_left_separator " "
            set -g @catppuccin_status_right_separator "█"
            set -g @catppuccin_status_connect_separator "yes"
            set -g @catppuccin_status_fill "icon"

            set -g @catppuccin_application_icon "󰙵"

            set -g @catppuccin_status_modules "application session battery kube date_time host"
            set -g @catppuccin_date_time_text "%Y-%m-%d %H:%M"
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
