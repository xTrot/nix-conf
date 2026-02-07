{
  flake.diskoConfigurations.performus = {
    disko.devices = {
      disk.nvme0 = {
        device = "/dev/disk/by-id/nvme-Samsung_SSD_980_PRO_1TB_S5P2NG0R611311V";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              name = "boot";
              size = "1M";
              type = "EF02";
            };
            esp = {
              name = "ESP";
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            swap = {
              name = "swap";
              size = "35G";
              content = {
                type = "swap";
                resumeDevice = true;
              };
            };
            root = {
              name = "root";
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
      disk.nvme1 = {
        device = "/dev/disk/by-id/nvme-Samsung_SSD_970_PRO_512GB_S463NF0KA32862D";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            root = {
              name = "secondary";
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/mnt/secondary/";
              };
            };
          };
        };
      };
      hdd0 = {
        device = "/dev/disk/by-id/ata-ST4000DM004-2CV104_ZFN1R4MA";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            data = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "tank";
              };
            };
          };
        };
      };
      hdd1 = {
        device = "/dev/disk/by-id/ata-ST4000DM004-2CV104_ZFN31YWZ";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            data = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "tank";
              };
            };
          };
        };
      };
      hdd2 = {
        device = "/dev/disk/by-id/ata-ST4000DM004-2CV104_ZFN39NJK";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            data = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "tank";
              };
            };
          };
        };
      };
      hdd3 = {
        device = "/dev/disk/by-id/ata-ST4000DM004-2CV104_ZFN3A516";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            data = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "tank";
              };
            };
          };
        };
      };
    };
    zpool = {
      zroot = {
        type = "zpool";
        mode = "mirror";
        rootFsOptions = {
          compression = "lz4";
          "com.sun:auto-snapshot" = "true";
        };
        datasets = {
          vault = {
            type = "filesystem";
            mountpoint = "/mnt/vault/";
          };
        };
      };
      tank = {
        type = "zpool";
        topology = {
          vdev = [
            {
              mode = "mirror";
              members = ["hdd0-data" "hdd1-data"];
            }
            {
              mode = "mirror";
              members = ["hdd2-data" "hdd3-data"];
            }
          ];
        };
        mountpoint = "/mnt/data";
      };
    };
  };
}
