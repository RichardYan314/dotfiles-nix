{ pkgs, colorscheme, ... }:

let               
  custom-panel-launch = pkgs.writeScriptBin "custom-panel-launch" ''
    #!/${pkgs.stdenv.shell}                                             
                                          
    killall -q polybar
                                                    
    polybar main &                               
  '';
  custom-script-sysmenu = pkgs.writeScriptBin "custom-script-sysmenu" ''
    #!/${pkgs.stdenv.shell}       
                              
    if [ -z "$@" ]; then            
      echo -en "Shutdown\0icon\x1fsystem-shutdown\n"
      echo -en "Logout\0icon\x1fsystem-log-out\n"                 
      echo -en "Suspend\0icon\x1fsystem-suspend\n"                          
      echo -en "Reboot\0icon\x1fsystem-restart\n"
      echo -en "Lock\0icon\x1fsystem-lock\n"
    else
      if [ "$1" = "Shutdown" ]; then
        systemctl -i poweroff
      elif [ "$1" = "Exit" ]; then
        killall xmonad                                                
      elif [ "$1" = "Reboot" ]; then                                                                        
        systemctl reboot
      elif [ "$1" = "Suspend" ]; then
        systemctl suspend                 
      elif [ "$1" = "Lock" ]; then
        i3lock-fancy -p -t ""
      fi
    fi
  '';
in
{
  imports = [
    ./datetime/index.nix
  ];

  home.packages = with pkgs; [
    custom-panel-launch             
    custom-script-sysmenu
  ];

  services.polybar = {
    enable = true;
    config = (import ./mytheme.nix) { colors = colorscheme; };
    script = ""; # let xmonad execute custom-panel-launch instead, so environment variables are properly set
  };
}
