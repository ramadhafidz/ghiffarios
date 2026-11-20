{ ... }:

{
  programs.mangohud = {
    enable = true;
    settings = {
      # 1-Line Horizontal Layout
      horizontal = true;
      legacy_layout = false;
      hud_compact = true;
      horizontal_stretch = 0;

      # Filter hanya GPU NVIDIA (0000:01:00.0), hilangkan GPU0 Intel yang idle
      pci_dev = "0000:01:00.0";

      # Metrik penting saja
      fps = true;
      gpu_stats = true;
      gpu_temp = true;
      cpu_stats = true;
      cpu_temp = true;
      ram = true;
      vram = true;

      # Style & Ukuran Font Kecil
      position = "top-left";
      font_size = 14;
      font_size_text = 14;
      background_alpha = "0.25";
      round_corners = 6;
      no_display = false;         # tampil by default, toggle pakai keybind
      toggle_hud = "Shift_R+F12"; # Right Shift + F12 untuk toggle

      # Sembunyikan info yang tidak penting / bikin ramai
      engine_version = false;
      vulkan_driver = false;
      wine = false;
      frame_timing = false;
      frametime = false;
    };
  };
}
