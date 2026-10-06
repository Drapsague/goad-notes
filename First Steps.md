---

---

The first thing I did is nmap the whole IP range.

```bash
  nmap 10.2.10.0/24 -sC -sV -T4 -Ao nmap
```

### We have 5 machines on the network:

- sevenkingdoms.local
  - Kingslanding - 10.2.10.10
  - north
    - Winterfell - 10.2.10.11
    - Castleblack - 10.2.10.12
     
- essos.local
  - Meereen - 10.2.10.13
  - Braavos - 10.2.10.14


On the Castleblack machine, we can see an smb auth with the Guest user.

![[2026-10-06_11-27-58.png]]
> **note** Note
> Nothing was found in the shares.

