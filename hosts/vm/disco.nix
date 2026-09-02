{
  disko.devices = {
    disk.main = {
      type = "disk";
      device = "/dev/sda";

      content = {
        type = "gpt";

        partitions = {
          ESP = {
            size = "1G";

            type = "EF00";

            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };

          root = {
            size = "100%";

            content = {
              type = "btrfs";

              subvolumes = {
                "@root" = {
                  mountpoint = "/";
                };

                "@home" = {
                  mountpoint = "/home";
                };

                "@nix" = {
                  mountpoint = "/nix";
                };

                "@log" = {
                  mountpoint = "/var/log";
                };

                "@snapshots" = {
                  mountpoint = "/.snapshots";
                };
              };
            };
          };
        };
      };
    };
  };
}