{ ... }:

{
  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        renice = 10;          # Prioritaskan game process
      };
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;       # NVIDIA GPU
      };
    };
  };
}
