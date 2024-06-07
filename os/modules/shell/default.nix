{pkgs, ...}: let
  powerlevel10k = pkgs.fetchFromGitHub {
    owner = "romkatv";
    repo = "powerlevel10k";
    rev = "v1.20.0";
    hash = "sha256-ES5vJXHjAKw/VHjWs8Au/3R+/aotSbY7PWnWAMzCR8E=";
  };
  fzf-tab = pkgs.fetchFromGitHub {
    owner = "Aloxaf";
    repo = "fzf-tab";
    rev = "v1.1.2";
    hash = "sha256-Qv8zAiMtrr67CbLRrFjGaPzFZcOiMVEFLg1Z+N6VMhg=";
  };
  zsh-shift-select = pkgs.fetchFromGitHub {
    owner = "jirutka";
    repo = "zsh-shift-select";
    rev = "v0.1.1";
    hash = "sha256-4kUUBH2GTMb/d6PUNiSNFogkvDUSwMX823j4xsroJKs=";
  };
  hostfetch = import ./hostfetch.nix pkgs;
in {
  environment.systemPackages = with pkgs; [fzf eza fd micro];
  environment.shellAliases = {
    edit = "$EDITOR";
    open = "xdg-open";
    ls = "eza --icons=always --group-directories-first";
    lt = "eza --tree --icons=always --group-directories-first";
    la = "eza -al --icons=always --time-style=relative --color-scale-mode=gradient --color-scale --group-directories-first";
  };

  environment.localBinInPath = true;
  programs.nano.enable = false;
  environment.variables = {
    EDITOR = "${./edit.sh}";
    GOPATH = "$HOME/.local/share/go";
    NIXOS_OZONE_WL = "1"; # Ask Electron and Chromium apps to run in wayland mode
    MOZ_ENABLE_WAYLAND = "1"; # Ask firefox to run in wayland mode
  };

  users.defaultUserShell = pkgs.zsh;

  # Prevent the new user dialog
  system.userActivationScripts.empty-zshrc = {text = "touch .zshrc";};

  programs.zsh = {
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    vteIntegration = true;
    enable = true;
    interactiveShellInit = ''
      # hostfetch
      [[ $SHLVL -eq 1 ]] && ${hostfetch}/bin/hostfetch

      # bind up and down
      typeset -g -A key
      key[Up]="''${terminfo[kcuu1]}"
      key[Down]="''${terminfo[kcud1]}"
      [[ -n "''${key[Up]}"        ]] && bindkey -- "''${key[Up]}"         up-line-or-search
      [[ -n "''${key[Down]}"      ]] && bindkey -- "''${key[Down]}"       down-line-or-search

      # zsh-shift-select
      source ${zsh-shift-select}/zsh-shift-select.plugin.zsh

      # fzf-tab
      autoload -U compinit; compinit
      source ${fzf-tab}/fzf-tab.plugin.zsh
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS} # set list-colors to enable filename colorizing

      # powerlevel10k
      source ${powerlevel10k}/powerlevel10k.zsh-theme
      source ${./powerlevel10k.zsh}
    '';
  };
}
