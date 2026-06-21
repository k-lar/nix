{ pkgs, ... }:

let
  hexToInt = pkgs.lib.trivial.fromHexString;

  map = src: dst: {
    HIDKeyboardModifierMappingSrc = hexToInt src;
    HIDKeyboardModifierMappingDst = hexToInt dst;
  };
in
{
  system.keyboard = {
    enableKeyMapping = true;
    userKeyMapping = [
      # ESC <-> Caps Lock
      (map "0x700000029" "0x700000039")
      (map "0x700000039" "0x700000029")
    ];
  };
}
