{ ... }:

{
  zramSwap.enable = true;
  zramSwap.memoryPercent = 50;

  # fallback swap tuning
  boot.kernel.sysctl = {
    "vm.swappiness" = 180;
  };
}
