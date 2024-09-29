{pkgs, ...}: {
  options = {};

  config = let
    #Script taken from noboilerplate https://github.com/0atman/noboilerplate/blob/main/scripts/38-nixos.md
    rebuildScript = pkgs.writeShellScriptBin "hm-rebuild" ''
      set -e #exit on an error
      pushd ~/.home-manager

      # Early return if no changes were detected (thanks @singiamtel!)
      echo -e "===================================\n  Detecting Changes...\n==================================="
      if git diff --quiet '*.nix'; then
          read -p "No changes detected, build anyways? [Y|n] " -n 1 -r
          echo
          if [[ ! $REPLY =~ ^[Yy]$ ]]
          then
              echo "No changes detected, exiting."
              popd
              exit 0
          fi
      fi
      git diff --minimal --ignore-blank-lines --color -U0 '*.nix' | cat
      git add .

      # Autoformat your nix files
      echo -e "===================================\nFormating...\n==================================="
      ${pkgs.alejandra}/bin/alejandra . &>/dev/null \
        || ( ${pkgs.alejandra}/bin/alejandra . ; echo "formatting failed!" && exit 1)

      echo -e "===================================\nRebuilding home-manager...\n==================================="
      home-manager switch --flake .#eda
      current=$(home-manager generations | head -n 1)

      echo -e "===================================\nCommiting changes...\n==================================="
      git commit -am "$current"
      ${pkgs.libnotify}/bin/notify-send -e "Home Manager Succesfully Rebuild"

      popd
    '';
  in {
    home.packages = [
      rebuildScript
    ];
  };
}
