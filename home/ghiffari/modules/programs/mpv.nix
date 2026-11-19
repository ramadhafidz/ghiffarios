{ pkgs, ... }:

let
  # Fast, interactive YouTube CLI searcher powered by yt-dlp, fzf, and mpv
  yts = pkgs.writeShellScriptBin "yts" ''
    set -euo pipefail

    audio_only=false
    query=""

    while [[ $# -gt 0 ]]; do
      case "$1" in
        -a|--audio)
          audio_only=true
          shift
          ;;
        -h|--help)
          echo "Penggunaan: yts [OPSI] [QUERY]"
          echo "Mencari video YouTube langsung via terminal dan memutarnya di MPV."
          echo ""
          echo "Opsi:"
          echo "  -a, --audio    Putar mode audio saja (tanpa jendela video)"
          echo "  -h, --help     Tampilkan bantuan ini"
          echo ""
          echo "Shortcut di menu pencarian:"
          echo "  ENTER          Putar video yang dipilih"
          echo "  TAB            Pilih beberapa video (multi-select antrean)"
          echo "  Ctrl+A         Putar dalam mode audio saja"
          echo "  Ctrl+Y         Salin URL video ke clipboard"
          exit 0
          ;;
        *)
          if [[ -z "$query" ]]; then
            query="$1"
          else
            query="$query $1"
          fi
          shift
          ;;
      esac
    done

    if [[ -z "$query" ]]; then
      read -r -p "🔍 Cari YouTube: " query
    fi

    if [[ -z "$query" ]]; then
      echo "Pencarian dibatalkan."
      exit 0
    fi

    echo "🔎 Mencari \"$query\" di YouTube..."

    results=$(${pkgs.yt-dlp}/bin/yt-dlp "ytsearch25:$query" \
      --flat-playlist \
      --ignore-errors \
      --no-warnings \
      --print "%(id)s	[%(duration_string)s]	%(uploader)s	%(title)s" \
      | ${pkgs.gawk}/bin/awk -F'\t' 'length($1) == 11')

    if [[ -z "$results" ]]; then
      echo "❌ Tidak ada hasil ditemukan untuk: \"$query\""
      exit 1
    fi

    selected=$(echo "$results" | ${pkgs.fzf}/bin/fzf \
      --delimiter="\t" \
      --with-nth="2.." \
      --prompt="▶ Putar di MPV > " \
      --header="ENTER: Putar | TAB: Pilih banyak | Ctrl+A: Audio | Ctrl+Y: Salin URL" \
      --multi \
      --preview="echo -e 'Judul:   {4}\nChannel: {3}\nDurasi:  {2}\nURL:     https://youtu.be/{1}'" \
      --preview-window="down:4:wrap" \
      --bind="ctrl-y:execute-silent(echo -n 'https://youtu.be/{1}' | ${pkgs.wl-clipboard}/bin/wl-copy && ${pkgs.libnotify}/bin/notify-send 'yts' 'URL disalin ke clipboard')+abort" \
      --expect="ctrl-a")

    if [[ -z "$selected" ]]; then
      exit 0
    fi

    key=$(head -n 1 <<< "$selected")
    items=$(tail -n +2 <<< "$selected")

    if [[ "$key" == "ctrl-a" ]]; then
      audio_only=true
    fi

    urls=()
    while IFS=$'\t' read -r id _ _ _; do
      if [[ -n "$id" ]]; then
        urls+=("https://youtu.be/$id")
      fi
    done <<< "$items"

    if [[ ''${#urls[@]} -eq 0 ]]; then
      exit 0
    fi

    mpv_args=()
    if [[ "$audio_only" == true ]]; then
      mpv_args+=("--no-video")
    fi

    echo "▶ Memutar ''${#urls[@]} video di MPV..."
    exec ${pkgs.mpv}/bin/mpv "''${mpv_args[@]}" "''${urls[@]}"
  '';
in
{
  programs.mpv = {
    enable = true;

    scripts = with pkgs.mpvScripts; [
      uosc        # Modern, minimalist on-screen controller & menu
      thumbfast   # High-performance thumbnail previews on seekbar
      mpris       # Media player remote controls for KDE Plasma & Latte Dock
    ];

    config = {
      # Video & Hardware Acceleration
      vo = "gpu-next";
      gpu-api = "auto";
      hwdec = "auto-safe";

      # Audio
      volume = 100;
      volume-max = 150;
      audio-pitch-correction = "yes";

      # Subtitles
      sub-auto = "fuzzy";
      sub-font = "sans-serif";
      sub-font-size = 38;
      sub-border-size = 2;
      sub-shadow-offset = 1;
      slang = "id,ind,en,eng";
      alang = "ja,jpn,en,eng,id,ind";

      # Screenshots
      screenshot-format = "png";
      screenshot-png-compression = 8;
      screenshot-directory = "~/Pictures/Screenshots";
      screenshot-template = "mpv-screenshot-%F-%P";

      # UI & Window (Opsi A: Frame jendela aktif + uosc modern controller)
      border = "yes";
      osc = "no";
      osd-bar = "no";
      keep-open = "yes";
      save-position-on-quit = "yes";

      # Streaming & Hardware Decoding (Quadro P620 Pascal NVDEC)
      # Pascal supports VP9/H.264/HEVC hwdec, but lacks AV1. Prioritize VP9/H.264:
      ytdl-format = "bestvideo[vcodec!*='av01'][vcodec!*='av1']+bestaudio/best";
      ytdl-raw-options = "cookies-from-browser=firefox";
    };

    bindings = {
      # Seeking
      "RIGHT" = "seek 5";
      "LEFT" = "seek -5";
      "UP" = "seek 30";
      "DOWN" = "seek -30";
      "Shift+RIGHT" = "no-osd seek 1 exact";
      "Shift+LEFT" = "no-osd seek -1 exact";

      # Volume
      "WHEEL_UP" = "add volume 2";
      "WHEEL_DOWN" = "add volume -2";

      # Speed
      "[" = "multiply speed 0.9";
      "]" = "multiply speed 1.1";
      "BS" = "set speed 1.0";

      # Shortcuts & uosc menus
      "tab" = "script-binding uosc/toggle-ui";
      "m" = "cycle mute";
      "f" = "cycle fullscreen";
      "s" = "screenshot";
      "S" = "screenshot video";
    };
  };

  home.packages = with pkgs; [
    yt-dlp
    ff2mpv-rust
    ytfzf       # Official/popular community terminal YouTube client with thumbnails
    chafa       # High-quality terminal graphics for ytfzf thumbnails
    yts         # Custom ultra-fast interactive search & play CLI
  ];

  # Firefox native messaging host for ff2mpv extension
  home.file.".mozilla/native-messaging-hosts/ff2mpv.json".source =
    "${pkgs.ff2mpv-rust}/lib/mozilla/native-messaging-hosts/ff2mpv.json";

  # uosc configuration (Subtle persistent progress line + hover controls)
  home.file.".config/mpv/script-opts/uosc.conf".text = ''
    progress=always
    progress_size=3
    timeline_style=line
    timeline_line_width=3
    timeline_persistency=paused
    controls_persistency=paused
  '';
}
