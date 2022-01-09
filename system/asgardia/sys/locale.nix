{ config, pkgs, ... }:

{
  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  location.provider = "geoclue2";
}
