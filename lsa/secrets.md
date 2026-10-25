# This page is dedicated to the understanding of LSA secrets

## What is the difference between --lsass and --lsa with nxc ?

```bash
  nxc smb <ip> -u '' -p '' --lsass #1
  --
  nxc smb <ip> -u '' -p '' --lsa #2
```

Let's try this on the GOAD and see the results.
  ![[images/2026-10-25_11-25-23.png]]
   ![[images/2026-10-25_11-24-59.png]]
So the command is getting flagged by Windows Defender. But why ?

Let's see if there is any difference with --lsa.
  ![[images/2026-10-25_11-26-51.png]]
Ok so with --lsa nothing is flagged and we successfully dumped the lsa secrets. Windows Defender saw nothing.


## Why ?

