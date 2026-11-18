{ pkgs, ... }:

let
  pokefetch = pkgs.writeScriptBin "pokefetch" ''
    #!${pkgs.bash}/bin/bash
    export PATH="${pkgs.lib.makeBinPath (with pkgs; [ pokeget-rs fastfetch gnused gawk coreutils ])}:$PATH"

    pokemon="''${1:-random}"
    sprite=$(pokeget "$pokemon" --hide-name 2>/dev/null)
    if [[ -z "$sprite" ]]; then
      sprite=$(pokeget random --hide-name)
    fi

    FETCHER="fastfetch --logo none"
    FETCHER_HEIGHT=$($FETCHER | wc -l)
    EXTRA_PADDING_H=2
    EXTRA_PADDING_W=0
    WIDTH=38

    height=$(echo "$sprite" | wc -l)
    pad_top=$((($FETCHER_HEIGHT - $height) / 2))
    pad_top=$((pad_top + EXTRA_PADDING_H))
    (( pad_top < 0 )) && pad_top=0

    # Strip ANSI color codes to get true visible width
    sprite_width=$(
      printf '%s\n' "$sprite" \
      | sed -E 's/\x1B\[[0-9;]*[a-zA-Z]//g' \
      | awk '{ if (length > max) max = length } END { print max }'
    )

    pad_Left=$((($WIDTH - sprite_width) / 2))
    pad_Right=$((($WIDTH - sprite_width + 1) / 2))
    pad_Left=$((pad_Left + EXTRA_PADDING_W))
    pad_Right=$((pad_Right + EXTRA_PADDING_W))
    (( pad_Left < 0 )) && pad_Left=0
    (( pad_Right < 0 )) && pad_Right=0

    echo "$sprite" | fastfetch --file-raw - --logo-padding-top "$pad_top" --logo-padding-left "$pad_Left" --logo-padding-right "$pad_Right"
  '';
in
{
  home.packages = with pkgs; [
    pokeget-rs
    fastfetch
    pokefetch
  ];

  programs.fastfetch = {
    enable = true;
  };
}
