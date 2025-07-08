{
  lib,
  pkgs,
  ...
}: let
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
in {
  home-manager.sharedModules = [
    (_: {
      programs = {
        firefox = {
          enable = true;
          package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
          };


          profiles = {
            default = {
              # choose a profile name; directory is /home/<user>/.mozilla/firefox/profile_0
              id = 0; # 0 is the default profile; see also option "isDefault"
              name = "default"; # name as listed in about:profiles
              isDefault = true; # can be omitted; true if profile ID is 0
              settings = {};
              bookmarks = [
              ];
              search = {
                force = true;
                default = "Startpage";
                privateDefault = "Startpage";
                order = [
                  "Google"
                ];
                engines = {
                  "Bing".metaData.hidden = true;
                  "Ebay".metaData.hidden = true;
                  "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
                };
              };
            };
          };
        };
      };
    })
  ];
}
