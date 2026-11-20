{ pkgs, ... }:

{
  # ---------------------------------------------------------
  # Network Management (NetworkManager)
  # ---------------------------------------------------------
  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
    wifi = {
      powersave = false;
      macAddress = "permanent";
      scanRandMacAddress = false;
    };
    ethernet.macAddress = "permanent";
    settings = {
      "connection-ethernet" = {
        "match-device" = "type:ethernet";
        "ipv4.route-metric" = 100;
        "ipv6.route-metric" = 100;
      };
      "connection-wifi" = {
        "match-device" = "type:wifi";
        "ipv4.route-metric" = 300;
        "ipv6.route-metric" = 300;
      };
    };
  };

  # ---------------------------------------------------------
  # DNS-over-TLS (DoT via systemd-resolved)
  # Bypasses ISP DNS hijacking (IndiHome/TrustPositif)
  # ---------------------------------------------------------
  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNSOverTLS = "true";
      DNSSEC = "allow-downgrade";
      Domains = [ "~." ];
      FallbackDNS = [
        "9.9.9.9#dns.quad9.net"
        "149.112.112.112#dns.quad9.net"
        "2620:fe::fe#dns.quad9.net"
        "2620:fe::9#dns.quad9.net"
      ];
    };
  };

  networking.nameservers = [
    "1.1.1.1#cloudflare-dns.com"
    "1.0.0.1#cloudflare-dns.com"
    "2606:4700:4700::1111#cloudflare-dns.com"
    "2606:4700:4700::1001#cloudflare-dns.com"
  ];

  # ---------------------------------------------------------
  # Kernel & Latency Optimization (TCP BBR + Fair Queueing)
  # Low bufferbloat for gaming & simultaneous dev downloads
  # ---------------------------------------------------------
  boot.kernelModules = [ "tcp_bbr" ];
  boot.kernel.sysctl = {
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.default_qdisc" = "fq";
    "net.ipv4.tcp_fastopen" = 3;
    "net.ipv4.tcp_slow_start_after_idle" = 0;
    "net.ipv4.tcp_mtu_probing" = 1;

    # Buffer tuning for high-throughput downloads
    "net.core.rmem_max" = 16777216;
    "net.core.wmem_max" = 16777216;
    "net.ipv4.tcp_rmem" = "4096 87380 16777216";
    "net.ipv4.tcp_wmem" = "4096 65536 16777216";
  };

  # ---------------------------------------------------------
  # LAN Discovery (Avahi / mDNS) & Desktop Integration
  # Resolves 'ghiffari-workstation.local' on local network
  # ---------------------------------------------------------
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # KDE Connect (clipboard sharing, notification sync, file transfer)
  programs.kdeconnect.enable = true;

  # ---------------------------------------------------------
  # Firewall Configuration
  # ---------------------------------------------------------
  networking.firewall = {
    enable = true;
    # Common local dev web testing ports (accessible from home LAN)
    allowedTCPPorts = [
      3000
      5173
      8000
      8080
    ];
  };

  # ---------------------------------------------------------
  # Anti-DPI Service (SpoofDPI)
  # Safe user-space DPI evasion on 127.0.0.1:8088
  # ---------------------------------------------------------
  environment.systemPackages = [ pkgs.spoofdpi ];

  systemd.services.spoofdpi = {
    description = "SpoofDPI Anti-Censorship Proxy Service";
    after = [ "network.target" "systemd-resolved.service" ];
    wants = [ "systemd-resolved.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.spoofdpi}/bin/spoofdpi --listen-addr 127.0.0.1:8088 --dns-mode system --silent";
      Restart = "on-failure";
      RestartSec = "3s";
      DynamicUser = true;
      # Hardening
      ProtectSystem = "strict";
      ProtectHome = true;
      NoNewPrivileges = true;
      PrivateTmp = true;
    };
  };
}
