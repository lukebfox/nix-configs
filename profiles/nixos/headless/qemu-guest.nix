# Common configuration for virtual machines running under QEMU (using
# virtio).
{ ... }:
{
  services.qemuGuest.enable = true;
}
