{ lib, pkgs, config, ... }:

let
  venvDir = "${config.home.homeDirectory}/.local/share/python/user";
  pipPackages = [
    "tidekeeper[gui]"
  ];
  requirementsText = ''
    ${lib.concatStringsSep "\n" pipPackages}
  '';
  requirementsFile = pkgs.writeText "python-user-requirements.txt" requirementsText;
  requirementsHash = builtins.hashString "sha256" requirementsText;
  stateFile = "${venvDir}/.requirements.sha256";
in
{
  # Keep the managed venv first so python/pip resolve to the declarative environment.
  home.sessionPath = [ "${venvDir}/bin" ];

  # Declarative package sync: edit `pipPackages` above and rebuild.
  home.activation.syncDeclarativePythonVenv = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    need_rebuild=0

    if [ ! -x "${venvDir}/bin/python" ]; then
      need_rebuild=1
    elif [ ! -f "${stateFile}" ]; then
      need_rebuild=1
    elif [ "$(cat "${stateFile}")" != "${requirementsHash}" ]; then
      need_rebuild=1
    fi

    if [ "$need_rebuild" -eq 1 ]; then
      $DRY_RUN_CMD rm -rf "${venvDir}"
      $DRY_RUN_CMD ${pkgs.python3}/bin/python -m venv "${venvDir}"
      $DRY_RUN_CMD "${venvDir}/bin/python" -m pip install --upgrade pip setuptools wheel
      $DRY_RUN_CMD "${venvDir}/bin/python" -m pip install --upgrade --requirement "${requirementsFile}"
      $DRY_RUN_CMD printf '%s\n' "${requirementsHash}" > "${stateFile}"
    fi
  '';
}
