{ lib, pkgs, ... }:

let
  desiredFlatpaks = import ../../home/modules/flatpaks.nix;
  lockedFlatpaks = builtins.fromJSON (builtins.readFile ../../flatpak-lock.json);
  missingLockedFlatpaks = builtins.filter (
    id: !(lib.any (flatpak: flatpak.id == id) lockedFlatpaks)
  ) desiredFlatpaks;
  flatpakLock = pkgs.writeShellApplication {
    name = "flatpak-lock";
    runtimeInputs = [ pkgs.flatpak pkgs.jq pkgs.coreutils ];
    text = ''
      set -euo pipefail

      output="''${1:-$HOME/git/nix/flatpak-lock.json}"
      tmp=$(mktemp)

      desired_apps=$(cat <<'EOF'
${lib.concatStringsSep "\n" desiredFlatpaks}
EOF
)

      if [ -n "$desired_apps" ]; then
        while IFS= read -r app; do
          [ -n "$app" ] || continue

          if ! flatpak --user info "$app" > /dev/null 2>&1; then
            echo "Skipping $app because it is not installed." >&2
            continue
          fi

          ref=$(flatpak --user info --show-ref "$app")
          commit=$(flatpak --user info --show-commit "$app")
          origin=$(flatpak --user info --show-origin "$app")

          jq -n \
            --arg id "$app" \
            --arg origin "$origin" \
            --arg ref "$ref" \
            --arg commit "$commit" \
            '{ id: $id, origin: $origin, ref: $ref, commit: $commit }'
        done <<EOF | jq -s 'sort_by(.id)' > "$tmp"
$desired_apps
EOF
      else
        printf '[]\n' > "$tmp"
      fi

      mv "$tmp" "$output"
      echo "Wrote $output"
    '';
  };
in
{
  services.flatpak.enable = true;
  environment.systemPackages = [ flatpakLock ];

  environment.sessionVariables.XDG_DATA_DIRS = [
    "/var/lib/flatpak/exports/share"
    "/home/klar/.local/share/flatpak/exports/share"
  ];

  system.userActivationScripts.flatpakManagement = {
    text = let
      jq = pkgs.jq;
      desiredFlatpaksJson = builtins.toJSON desiredFlatpaks;
      lockedFlatpaksJson = builtins.toJSON lockedFlatpaks;
      missingLockedFlatpaksJson = builtins.toJSON missingLockedFlatpaks;
    in ''
      desired_flatpaks=(${lib.escapeShellArgs desiredFlatpaks})
      desired_flatpaks_json=${lib.escapeShellArg desiredFlatpaksJson}
      locked_flatpaks_json=${lib.escapeShellArg lockedFlatpaksJson}
      missing_locked_flatpaks_json=${lib.escapeShellArg missingLockedFlatpaksJson}

      ${pkgs.flatpak}/bin/flatpak --user remote-add --if-not-exists flathub \
        https://flathub.org/repo/flathub.flatpakrepo

      installed_flatpaks=$(${pkgs.flatpak}/bin/flatpak --user list --app --columns=application 2>/dev/null || true)

      for installed in $installed_flatpaks; do
        if ! printf '%s' "$desired_flatpaks_json" | ${jq}/bin/jq -e --arg id "$installed" 'index($id)' > /dev/null; then
          echo "Removing $installed because it is not declared."
          ${pkgs.flatpak}/bin/flatpak --user uninstall -y --noninteractive "$installed"
        fi
      done

      printf '%s' "$missing_locked_flatpaks_json" | ${jq}/bin/jq -r '.[]' | while IFS= read -r app; do
        [ -n "$app" ] || continue
        echo "Installing $app from flathub because it is missing from the lockfile."
        ${pkgs.flatpak}/bin/flatpak --user install -y flathub "$app"
      done

      printf '%s' "$locked_flatpaks_json" | ${jq}/bin/jq -c '.[]' | while IFS= read -r app; do
        id=$(printf '%s' "$app" | ${jq}/bin/jq -r '.id')
        origin=$(printf '%s' "$app" | ${jq}/bin/jq -r '.origin')
        ref=$(printf '%s' "$app" | ${jq}/bin/jq -r '.ref')
        commit=$(printf '%s' "$app" | ${jq}/bin/jq -r '.commit')

        if ! printf '%s' "$desired_flatpaks_json" | ${jq}/bin/jq -e --arg id "$id" 'index($id)' > /dev/null; then
          continue
        fi

        echo "Ensuring $id is installed from $origin at $commit."
        ${pkgs.flatpak}/bin/flatpak --user install -y --or-update "$origin" "$ref"
        ${pkgs.flatpak}/bin/flatpak --user update -y --commit="$commit" "$ref"
      done

      ${pkgs.flatpak}/bin/flatpak --user uninstall --unused -y
    '';
  };
}