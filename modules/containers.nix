{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    podman
    podman-compose
    skopeo
  ];

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
}