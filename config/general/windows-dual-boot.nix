{ config, pkgs, ... }:
{
  # Windows dual boot system time issue fix.
  time.hardwareClockInLocalTime = true;
}