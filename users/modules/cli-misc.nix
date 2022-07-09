{ pkgs, ... }:

{
  home.packages = with pkgs; [
    wget
    curl
    fd

    ## alphine comes with busybox
    ## so manually install the proper alternatives
    ## see also bat-and-friends.nix
    exa # aliases set in zsh.nix: programs.zsh.shellAliases 
    diffutils
    less

    # for polybar
    inotify-tools
  ];
}
