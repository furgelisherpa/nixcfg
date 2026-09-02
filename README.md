# NixOS configuration

Flake-based NixOS + home-manager configuration for the host `core` (user `pstivy`).

## Deploying on a new machine

### 1. Prerequisites

- A NixOS (or Nix) install with flakes enabled and git available.
- Enable flakes in `nix.conf` (or with the flag `--extra-experimental-features "nix-command flakes"`):

```sh
nix-env -f '<nixpkgs>' -iA nixosModules.nix 2>/dev/null || true
```

### 2. Restore secrets

Before activating, the sops secrets must be decryptable. Copy these from your
backup onto the new machine:

```sh
# The age identity (private) key that unlocks the sops secrets.
mkdir -p ~/.config/sops/age
cp <backup>/keys.txt ~/.config/sops/age/keys.txt
chmod 600 ~/.config/sops/age/keys.txt
```

The age key is the **only** file needed to restore everything, including the
GPG signing key. SSH and git-identity secrets decrypt directly from
`secrets/secrets.yaml`, and the armored GPG secret key is also stored there as
a (separately) encrypted sops secret — home-manager re-imports it into the
keyring on activation if it is missing, so a fresh machine recovers commit
signing with no manual `gpg --import`.

### 3. Clone and enable

```sh
git clone git@github.com:furgelisherpa/nixcfg.git
cd nixcfg
```

### 4. Activate home configuration

```sh
# Verify everything evaluates
nix flake check

# Build (no activation) the home configuration
home-manager build --flake .#pstivy@core

# Activate
home-manager switch --flake .#pstivy@core
```

Home-manager renders the sops secrets at activation into:

- `~/.config/git/identity` — git name/email/signing key
- `~/.ssh/id_ed25519` and `~/.ssh/id_ed25519.pub`
- `~/.config/sops-nix/secrets/rendered/gpg/private-key.asc` — staged armored
  GPG key, imported into `~/.local/share/gnupg` by the
  `home.activation.importGpg` hook only when the keyring is missing

### 5. Activate system configuration (NixOS)

```sh
sudo nixos-rebuild switch --flake .#core
```

### 6. Verify

```sh
# SSH auth to GitHub
ssh -T git@github.com

# GPG-signed git commit verifies as good
git config --get user.signingkey
```

## Managing secrets

Encrypted secrets live in `secrets/secrets.yaml` (safe to commit). The age
private key at `~/.config/sops/age/keys.txt` is the decryption key and is
**never** committed.

Edit a secret (requires `sops` and the age key):

```sh
sops secrets/secrets.yaml
```

Add a new decryption key / secret entry, then update `.sops.yaml` and
`home-manager/modules/secrets.nix` as needed.
