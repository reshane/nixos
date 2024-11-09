{ pkgs, ... }:
{
    programs.alacritty = {
        enable = true;
        settings = {
            shell.program = ${pkgs.fish}/bin/fish;
            env.TERM = screen-256color;
            window = {
                opacity = 0.5;
                dimensions = {
                    columns = 0;
                    lines = 0;
                };
            };
            padding = {
                x = 2;
                y = 2;
            };
        };
    };
}
