{ ... }:

{
  # In-RAM compressed swap via zstd
  # Memberikan virtual memory headroom hingga ~24-32GB tanpa menggunakan SSD/disk swap
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 100;
    priority = 100;
  };

  # OOM protection — kill offending process sebelum freeze total
  systemd.oomd = {
    enable = true;
    enableRootSlice = true;
    enableUserSlices = true;
    enableSystemSlice = true;
  };

  # Kernel tweaks untuk gaming & zram
  boot.kernel.sysctl = {
    # Swappiness tinggi (180) adalah standar resmi untuk zram:
    # Kernel secara agresif memadatkan memory idle (background Discord/browser) ke zstd zram
    # daripada membuang disk page cache yang menyebabkan game stuttering saat loading asset.
    "vm.swappiness" = 180;

    # Optimal untuk zram: baca/tulis 1 page (4KB) per-I/O tanpa readahead disk overhead
    "vm.page-cluster" = 0;

    # Split lock detection off — beberapa game Windows (via Proton) trigger ini
    # dan menyebabkan massive performance drop
    "kernel.split_lock_mitigate" = 0;
  };
}
