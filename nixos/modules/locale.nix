{...}: {
  # --- module: locale.nix --------------------------------------------------
  # Owns timezone + internationalisation locale.

  # Timezone. Asia/Kathmandu = Nepal (UTC+05:45, no DST). Keep in sync with
  # the user's location so clocks/`date`/cron are correct.
  time.timeZone = "Asia/Kathmandu";

  # Single UTF-8 English locale. `en_US.UTF-8` is the pragmatic default for an
  # English UI; Devanagari/other content is handled per-application via input
  # methods rather than the system locale (see emacs typing-trainer module).
  i18n.defaultLocale = "en_US.UTF-8";
}
