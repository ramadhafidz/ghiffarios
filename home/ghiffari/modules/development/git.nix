{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Hafidz Ramadhan";
        email = "hrghiffari@gmail.com";
      };
      init.defaultBranch = "main";
      pull.rebase = false;
      # Integrasi SSH commit signing dengan 1Password
      gpg.format = "ssh";
      "gpg \"ssh\"".program = "${pkgs._1password-gui}/bin/op-ssh-sign";
    };
  };
}
