{pkgs, ...}: {
  options = {};

  config = let
    #Script taken from noboilerplate https://github.com/0atman/noboilerplate/blob/main/scripts/38-nixos.md
    homeManagerBuild = pkgs.writeShellScriptBin "hm-build" ''
      set -e #exit on an error
      pushd ~/.home-manager

      # Early return if no changes were detected (thanks @singiamtel!)
      echo -e "===================================\n  Detecting Changes...\n==================================="
      git diff --minimal --ignore-blank-lines --color -U0 '*.nix' | cat
      if git diff --quiet '*.nix'; then
          read -p "No changes detected, build anyways? (y|N) " -n 1 -r
          echo
          if [[ ! $REPLY =~ ^[Yy]$ ]]
          then
              echo "No changes detected, exiting."
              popd
              exit 0
          fi
      fi

      #If not already flagged
      if [[ ! $REPLY =~ ^[Yy]$ ]]
      then
          read -p "Continue? (Y|n)" -n 1 -r
          echo
          if [[ ! $REPLY =~ ^[Yy]$ ]]
              then
                  echo "exiting..."
                  popd
                  exit 0
          fi
      fi

      git add .

      # Autoformat your nix files
      echo -e "===================================\nFormating...\n==================================="
      ${pkgs.alejandra}/bin/alejandra . &>/dev/null \
        || ( ${pkgs.alejandra}/bin/alejandra . ; echo "formatting failed!" && exit 1)

      echo -e "===================================\nRebuilding home-manager...\n==================================="
      home-manager switch --flake .#eda &>.home-manager-switch.log || (cat .home-manager-switch.log | grep --color error && exit 1)
      echo -e "\033[0;32mSuccess!\033[0m"
      current=$(home-manager generations | head -n 1)

      echo -e "===================================\nCommiting changes...\n==================================="
      git commit -am "$current"
      ${pkgs.libnotify}/bin/notify-send -e "Home Manager Succesfully Rebuild"

      popd
    '';
    nixBuild = pkgs.writeShellScriptBin "nix-build" ''
      set -e #exit on an error
      pushd ~/.nixos

      # Early return if no changes were detected (thanks @singiamtel!)
      echo -e "===================================\n  Detecting Changes...\n==================================="
      git diff --minimal --ignore-blank-lines --color -U0 '*.nix' | cat
      if git diff --quiet '*.nix'; then
          read -p "No changes detected, build anyways? (y|N) " -n 1 -r
          echo
          if [[ ! $REPLY =~ ^[Yy]$ ]]
          then
              echo "No changes detected, exiting."
              popd
              exit 0
          fi
      fi

      #If not already flagged
      if [[ ! $REPLY =~ ^[Yy]$ ]]
      then
          read -p "Continue? (Y|n)" -n 1 -r
          echo
          if [[ ! $REPLY =~ ^[Yy]$ ]]
              then
                  echo "exiting..."
                  popd
                  exit 0
          fi
      fi

      git add .

      # Autoformat your nix files
      echo -e "===================================\nFormating...\n==================================="
      ${pkgs.alejandra}/bin/alejandra . &>/dev/null \
        || ( ${pkgs.alejandra}/bin/alejandra . ; echo "formatting failed!" && exit 1)

      echo -e "===================================\nRebuilding home-manager...\n==================================="
      sudo nixos-rebuild switch --flake .#default &>.nixos-switch.log || (cat .nixos-switch.log | grep --color error && exit 1)
      echo -e "\033[0;32mSuccess!\033[0m"
      current=$(nixos-rebuild list-generations | grep current)

      echo -e "===================================\nCommiting changes...\n==================================="
      git commit -am "$current"
      ${pkgs.libnotify}/bin/notify-send -e "Home Manager Succesfully Rebuild"
      popd
    '';
  in {
    home.packages = [
      homeManagerBuild
      nixBuild
    ];
  };
}
