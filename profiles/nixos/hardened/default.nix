# Security profile for moderate linux kernel harderning. (v5.4)
# see: https://madaidans-insecurities.github.io/guides/linux-hardening.html
{ config, lib, pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_hardened;
    kernelParams = [
      # Disable hibernation (can allow replacing kernel).
      "nohibernate"
      # Mitigate heap exploitation by overwriting objects from merged caches.
      "slab_nomerge"
      # Enable slab sanity checks and redzoning.
      "slub_debug=FZ"
      # Enable zeroing of memory during allocation and free time.
      "init_on_alloc=1" "init_on_free=1"
      # Randomise page allocator freelists.
      "page_alloc.shuffle=1"
      # Mitigate Meltdown and prevent some KASLR bypasses by forcing page table isolation.
      "pti=on"
      # Flush l1 cache before entering guests.
      "kvm-intel.vmentry_l1d_flush=always"
      # Remove obsolete vsyscall and potential ROP attack target.
      "vsyscall=0"
    ];
    kernel.sysctl = {
      # Hide kernel pointers from processes without the CAP_SYSLOG capability.
      "kernel.kptr_restrict"=1;
      # Restricts the kernel log to CAP_SYSLOG capability.
      "kernel.dmesg_restrict"=1;
      # Prevent information leak from kernel logging to screen during boot.
      "kernel.printk"=3333;
      # Enable JIT hardening techniques such as constant binding.
      "net.core.bpf_jit_harden"=2;
      # Restrict loading TTY line disciplines to the CAP_SYS_MODULE capability.
      "dev.tty.ldisc_autoload"=0;
      # Prevent replacing the running kernel image.
      "kernel.kexec_load_disabled"=1;
      # Make it so a user can only use the secure attention key which is required to access root securely.
      "kernel.sysrq"=4;
      # Restrict use of user namespaces to CAP_SYS_ADMIN capability.
      "kernel.unprivileged_userns_clone"=0;
      # Protect against SYN flooding.
      "net.ipv4.tcp_syncookies"=1;
      # Protect against time-wait assasination.
      "net.ipv4.tcp_rfc1337"=1;
      # Protect against IP spoofing by enabling source validation.
      "net.ipv4.conf.all.rp_filter"=1;
      "net.ipv4.conf.default.rp_filter"=1;
      # Protect against smurf attacks and clock fingerprinting via ICMP timestamping.
      "net.ipv4.icmp_echo_ignore_all"=1;
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
      "omfs"
      "qnx4"
      "qnx6"
      "sysv"
      "udf"
     # Miscellaneous
      "vivid"     # Video Test Driver (unnecessary)
      #"bluetooth" # Bluetooth
      #"btusb"     # Bluetooth
      #"uvcvideo"  # Webcam
    ];
  };

  # TODO more fine-grained approach using capabilities.
  security.sudo.enable = true;

  # Prevent loading of kernel modules during runtime.
  security.lockKernelModules = true;
}
