{ ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font";
      size = 11;
    };
    settings = {
      enable_audio_bell = false;
      confirm_os_window_close = 0;
      window_padding_width = 8;
      background_opacity = "0.88";
      scrollback_lines = 10000;
    };
  };
}
