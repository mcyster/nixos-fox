
# Nixos config for `fox`

This is the `/etc/nixos` directory on  `fox`.


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
- Fine-grained tokens
- Geneate new Token
  - Only selected Repositories
    - mcyster/nixos-fox
  - Repository Persmissiones
    - Actions: read/write
    - 
- Copy token put in environment variable

