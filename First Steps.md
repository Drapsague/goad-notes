
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

---

On the Castleblack machine, we can see an smb auth with the `Guest` user.

![[2026-10-06_11-27-58.png]]
We get two user from the last share remark: `jon.snow` and `samwell.tarly`. 
> **note** Note
> Nothing was found in the shares.

There is also a 80 port with IIS running. And there is an upload page. I think we can maybe get a shell with this but we will get to it later.

![[2026-10-06_14-05-16.png]]

