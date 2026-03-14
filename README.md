
# NixOS config for `fox`

This is the `/etc/nixos` directory on `fox`, managed as a Nix flake.

## Rebuild

```
sudo nixos-rebuild switch --flake /etc/nixos
```

## Full Upgrade

```
nix flake update --flake /etc/nixos && sudo nixos-rebuild switch --flake /etc/nixos
```

## Restore Backup

```
PAT=XXXXXXXXXXXXX   # PAT key from github

cd /etc
git clone "https://mcyster:$PAT@github.com/mcyster/nixos-fox.git" nixos
```

## Update Backup

```
PAT=XXXXXXXXXXXXX   # PAT key from github

cd /etc/nixos
# make changes
# git add -A
# git commit -m "Message"

git push "https://mcyster:$PAT@github.com/mcyster/nixos-fox.git"
```

## Generate a PAT

Goto [github tokens](https://github.com/settings/tokens)
- Generate New Token
  - Generate new token (classic)
    - Note: nixos-backup
    - Expiration: 30 days
    - Selected scopes: repo
    - Generate Token
  - Copy token, put in environment variable PAT
