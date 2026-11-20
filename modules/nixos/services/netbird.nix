{ ... }:

{
  services.netbird = {
    enable = true;
    useRoutingFeatures = "both";
  };

  # Trust NetBird VPN tunnel interface (wt0) so authenticated devices on the private mesh
  # can access services (SSH, dev servers, etc.) without public firewall exposure.
  networking.firewall.trustedInterfaces = [ "wt0" ];
}
