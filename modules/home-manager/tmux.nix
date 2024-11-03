{ pkgs, ... }:
{
    programs.tmux = {
        enable = true;
        shell = "${pkgs.fish}/bin/fish";
        terminal = "tmux-256color";
        historyLimit = 100000;
        extraConfig = ''
            set -g default-terminal "tmux-256color"
            set -ag terminal-overrides ",xterm-256color:RGB"

            set-option -g prefix C-a
            unbind-key C-b
            bind-key C-a send-prefix
  
            set -g mouse on
  
            # Change splits to match nvim and easier to remember
            # Open new split at cwd of current split
            unbind %
            unbind '"'
            bind '\' split-window -h -c "#{pane_current_path}"
            bind - split-window -v -c "#{pane_current_path}"

            unbind l
            bind h select-pane -L
            bind j select-pane -D
            bind k select-pane -U
            bind l select-pane -R
  
            # Use vim keybindings in copy mode
            set-window-option -g mode-keys vi
  
            # v in copy mode starts making selection
            bind-key -T copy-mode-vi v send-keys -X begin-selection
            bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
            bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
  
            # Easier reload of config
            bind r source-file ~/.config/tmux/tmux.conf
  
            set-option -g status-position top
  
            # make Prefix p paste the buffer.
            unbind p
            bind p paste-buffer
        '';
    };
}
