#!/usr/bin/env bash

# Inspired by dotfiles from olimorris
# https://github.com/olimorris/dotfiles

main() {
    ####
    # COLOR PALETTE
    # Based on Snazzy: https://github.com/sindresorhus/hyper-snazzy
    local color_blue="#57c7ff"
    local color_cyan="#9aedfe"
    local color_gray="#5c6370"
    local color_green="#5af78e"
    local color_magenta="#ff6ac1"
    local color_red="#ff5c57"
    local color_white="#f1f1f0"
    local color_yellow="#f3f99d"

    local color_fg="#eff0eb"
    local color_bg="#282a36"
    local color_buffer="#939aa3"
    local color_border="#222430"
    local color_cursor="#97979b"
    local color_selection="#97979b"


    ####
    # PLUGINS

    # prefix highlight
    tmux set-option -g @prefix_highlight_prefix_prompt "PREFIX"
    tmux set-option -g @prefix_highlight_fg "$color_bg"
    tmux set-option -g @prefix_highlight_bg "$color_yellow"

    tmux set-option -g @prefix_highlight_show_copy_mode "on"
    tmux set-option -g @prefix_highlight_copy_mode_attr "bg=$color_magenta,fg=$color_bg"
    tmux set-option -g @prefix_highlight_copy_prompt " COPY "

    tmux set-option -g @prefix_highlight_show_sync_mode "on"
    tmux set-option -g @prefix_highlight_sync_mode_attr "bg=$color_red,fg=$color_bg"
    tmux set-option -g @prefix_highlight_sync_prompt " SYNC "

    tmux set-option -g @prefix_highlight_empty_prompt "  TMUX  "
    tmux set-option -g @prefix_highlight_empty_attr "bg=$color_blue,fg=$color_bg"

    ###
    # OPTIONS

    ###
    # Color definitions
    # Based on tmux-snazzy: https://github.com/ivnvxd/tmux-snazzy/

    # window title
    tmux set-window-option -g window-status-separator "  "
    tmux set-window-option -g window-status-style fg="$color_cyan",bg=default,bright
    tmux set-window-option -g window-status-current-style fg="$color_green",bg=default,bright

    # window status bar title
    tmux setw -g window-status-format "#[fg=$color_gray]#I: #[noitalics]#W"
    tmux setw -g window-status-current-format "#[fg=$color_magenta]#I: #[fg=$color_buffer,noitalics,bold]#W"

    # message text
    tmux set-option -g message-style bg="$color_blue,fg=$color_bg"

    # pane border
    tmux set-option -g pane-border-style fg="$color_blue"
    tmux set-option -g pane-active-border-style fg="$color_green"

    # pane number
    tmux set-option -g display-panes-active-colour "$color_red"
    tmux set-option -g display-panes-colour "$color_green"
    
    # mode style
    tmux set-window-option -g mode-style bg="$color_magenta,fg=$color_bg"

    # clock
    tmux set-window-option -g clock-mode-colour "$color_magenta"

    # status bar
    tmux set-option -g status on
    tmux set-option -g status-justify left
    tmux set-option -g status-position bottom
    tmux set-option -g status-interval 5
    tmux set-option -g status-style bg="$color_bg,fg=$color_fg"

    # status bar left
    tmux set-option -g status-left-length 100
    tmux set-option -g status-left-style NONE

    local host_local="#[bg=$color_white#,fg=$color_bg] #H "
    local host_remote="#[bg=$color_yellow#,fg=$color_bg] #H "

    local ssh_status="#{?#{pane_ssh_connected},$host_remote,$host_local}#[default]"
    local tmux_status="#{prefix_highlight}"
    local session_status=" #S "

    tmux set-option -g status-left "$ssh_status$tmux_status $session_status "

    # status bar right
    tmux set-option -g status-right-length 100
    tmux set-option -g status-right-style NONE

    local resource_usage="#{sysmon_cpu_usage_fg_color} #{sysmon_mem_usage_fg_color}#[default]"
    local datetime="#[fg=$color_magenta] %H:%M #[default]"

    tmux set-option -g status-right "$resource_usage $datetime"
}

main
