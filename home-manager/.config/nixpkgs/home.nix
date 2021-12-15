{ config, pkgs, ... }: {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "nullrequest";
  home.homeDirectory = "/home/nullrequest";
  services.gpg-agent = {
    enable = true;
    extraConfig = ''
      pinentry-program ${pkgs.pinentry.qt}/bin/pinentry
    '';
  };
  programs.bat.enable = true;
  programs.neovim.enable = true;
  programs.gpg = { 
      enable = true; 
  };

  # install zsh, load zshrc
  programs.zsh = {
    enable = true;
    initExtraBeforeCompInit = builtins.readFile ../../../zsh/.zshrc;
  };
  # This defines packages
  home.packages = with pkgs; [
    ark
    nixfmt
    kde-gtk-config
    nextcloud-client
    nordic
    rust-analyzer
    unzip
    cinnamon.warpinator
    neofetch
    git-crypt
    niv
    any-nix-shell
    stow
    python310
    tree
    clangStdenv
    bear
    wget
    clang
    clang-tools
    flatpak-builder
    rustup
    discover
    binutils
    pinentry-qt
    ksshaskpass
    bpytop
 ];

  programs.git = {
    enable = true;
    userName = "Luna D Dragon";
    userEmail = "advaith.madhukar@gmail.com";
    extraConfig = {
      color.ui = true;
      pull.rebase = true;
      merge.conflictstyle = "diff3";
      diff.algorithm = "patience";
      protocol.version = "2";
      core.commitGraph = true;
      gc.writeCommitGraph = true;
    };
    signing = {
      key = null;
      signByDefault = true;
      gpgPath = "gpg";
    };
  };
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.

  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
