# Security profile for moderate linux kernel harderning. (v5.4)
# see: https://madaidans-insecurities.github.io/guides/linux-hardening.html
# REVIEW: last reviewed: 29/12/2021
{ config, lib, pkgs, ... }:
let
  inherit (lib) optionals;
in
{
  # jemalloc alternative
  environment.memoryAllocator.provider = "scudo";
  environment.variables.SCUDO_OPTIONS = "ZeroContents=1";

  # Disable kernel module loading once the system is fully initialised.
  # Module loading is disabled until the next reboot.
  security.lockKernelModules = true;

  # Side effect: disables hibernation
  security.protectKernelImage = true;

  # Mitigate Meltdown and prevent some KASLR bypasses.
  security.forcePageTableIsolation = true;

  # Restrict use of user namespaces to CAP_SYS_ADMIN capability.
  # This is required by podman to run containers in rootless mode.
  security.unprivilegedUsernsClone = config.virtualisation.containers.enable;

  # Flush l1 cache before entering guests.
  security.virtualisation.flushL1DataCache = "always";
  # Supplements cache flushing. No SMT/hyperthreading.
  security.allowSimultaneousMultithreading = true;

  security.apparmor.enable = true;
  security.apparmor.killUnconfinedConfinables = true;

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_hardened;
    kernelParams = [
      # Enable slab sanity checks, redzoning and poisoning.
      "slub_debug=FZP"
      # Enable zeroing of memory during allocation and free time.
      "init_on_alloc=1" "init_on_free=1"
      # Randomise page allocator freelists.
      "page_alloc.shuffle=1"
    ];
    kernel.sysctl = {
      # Hide kernel pointers from processes without the CAP_SYSLOG capability.
      "kernel.kptr_restrict"=1;
      # Prevent information leak from kernel logging to screen during boot.
      "kernel.printk"=3333;
      # Restrict loading TTY line disciplines to the CAP_SYS_MODULE capability.
      "dev.tty.ldisc_autoload"=0;
      # Make it so a user can only use the secure attention key which is required to access root securely.
      "kernel.sysrq"=4;
      # Protect against SYN flooding.
      "net.ipv4.tcp_syncookies"=1;
      # Protect against time-wait assasination.
      "net.ipv4.tcp_rfc1337"=1;

      # Enable strict reverse path filtering (that is, do not attempt to route
      # packets that "obviously" do not belong to the iface's network; dropped
      # packets are logged as martians).
      "net.ipv4.conf.all.log_martians" = true;
      "net.ipv4.conf.all.rp_filter" = "1";
      "net.ipv4.conf.default.log_martians" = true;
      "net.ipv4.conf.default.rp_filter" = "1";

      # Protect against SMURF attacks and clock fingerprinting via ICMP timestamping.
      "net.ipv4.icmp_echo_ignore_all" = "1";

      # Ignore incoming ICMP redirects (note: default is needed to ensure that the
      # setting is applied to interfaces added after the sysctls are set)
      "net.ipv4.conf.all.accept_redirects" = false;
      "net.ipv4.conf.all.secure_redirects" = false;
      "net.ipv4.conf.default.accept_redirects" = false;
      "net.ipv4.conf.default.secure_redirects" = false;
      "net.ipv6.conf.all.accept_redirects" = false;
      "net.ipv6.conf.default.accept_redirects" = false;

      # Ignore outgoing ICMP redirects (this is ipv4 only)
      "net.ipv4.conf.all.send_redirects" = false;
      "net.ipv4.conf.default.send_redirects" = false;

      # Restrict abritrary use of ptrace to the CAP_SYS_PTRACE capability.
      "kernel.yama.ptrace_scope"=2;
    };
    blacklistedKernelModules = [
     # Obscure network protocols
      "dccp"      # Datagram Congestion Control Protocol
      "sctp"      # Stream Control Transmission Protocol
      "rds"       # Reliable Datagram Sockets
      "tipc"      # Transparent Inter-Process Communication
      "n-hdlc"    # High-level Data Link Control
      "netrom"    # NetRom
      "x25"       # X.25
      "ax25"      # Amatuer X.25
      "rose"      # ROSE
      "decnet"    # DECnet
      "econet"    # Econet
      "af_802154" # IEEE 802.15.4
      "ipx"       # Internetwork Packet Exchange
      "appletalk" # Appletalk
      "psnap"     # SubnetworkAccess Protocol
      "p8022"     # IEEE 802.3
      "p8023"     # Novell raw IEEE 802.3
      "can"       # Controller Area Network
      "atm"       # ATM
     # Old or rare or insufficiently audited filesystems
      "adfs"
      "affs"
      "bfs"
      "befs"
      "cramfs"
      "efs"
      "erofs"
      "exofs"
      "freevxfs"
      "f2fs"
      "hfs"
      "hfsplus"
      "squashfs"
      "jffs2"
      "minix"
      "nilfs2"
      "ntfs"
      "omfs"
      "qnx4"
      "qnx6"
      "sysv"
      "udf"
    # Miscellaneous
      "vivid"     # Video Test Driver (unnecessary)
      #"uvcvideo"  # Webcam
    ] ++ optionals (!config.modules.network.enable) [
      "iwlwifi"    # NIC
    ] ++ optionals (!config.modules.network.bluetooth.enable) [
      "bluetooth" # Bluetooth
      "btusb"     # Bluetooth
    ];
  };

}
