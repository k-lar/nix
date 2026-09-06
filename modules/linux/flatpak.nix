{ lib, pkgs, ... }:

{
  services.flatpak.enable = true;

  environment.sessionVariables.XDG_DATA_DIRS = [
    "/var/lib/flatpak/exports/share"
    "/home/klar/.local/share/flatpak/exports/share"
  ];

  system.userActivationScripts.flatpakManagement = {
    text = let
      grep = pkgs.gnugrep;
      desiredFlatpaks = [
        "io.missioncenter.MissionCenter"
      ];
    in ''
      desired_flatpaks=(${lib.escapeShellArgs desiredFlatpaks})

      ${pkgs.flatpak}/bin/flatpak --user remote-add --if-not-exists flathub \
        https://flathub.org/repo/flathub.flatpakrepo

      installed_flatpaks=$(${pkgs.flatpak}/bin/flatpak --user list --app --columns=application 2>/dev/null || true)

      for installed in $installed_flatpaks; do
        if ! printf '%s\n' "''${desired_flatpaks[@]}" | ${grep}/bin/grep -Fxq -- "$installed"; then
          echo "Removing $installed because it is not declared."
          ${pkgs.flatpak}/bin/flatpak --user uninstall -y --noninteractive "$installed"
        fi
      done

      for app in "''${desired_flatpaks[@]}"; do
        echo "Ensuring $app is installed."
        ${pkgs.flatpak}/bin/flatpak --user install -y flathub "$app"
      done

      ${pkgs.flatpak}/bin/flatpak --user uninstall --unused -y
      ${pkgs.flatpak}/bin/flatpak --user update -y
    '';
  };
}