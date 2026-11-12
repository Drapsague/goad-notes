# This page is dedicated to the understanding of LSA secrets

## What is the difference between --lsass and --lsa with nxc ?

```bash
  nxc smb <ip> -u '' -p '' --lsass #1
  --
  nxc smb <ip> -u '' -p '' --lsa #2
```

Let's try this on the GOAD and see the results.
  ![2026-10-25_11-25-23](images/2026-10-25_11-25-23.png)
   ![2026-10-25_11-24-59](images/2026-10-25_11-24-59.png)
So the command is getting flagged by Windows Defender. But why ?

Let's see if there is any difference with --lsa.
  ![2026-10-25_11-26-51](images/2026-10-25_11-26-51.png)
Ok so with --lsa nothing is flagged and we successfully dumped the lsa secrets. Windows Defender saw nothing.


## Why ?

If we look at the netexec code for `--lsa` and `-M lsassy` it is two different implementation. They don't do the same thing. `--lsa` uses


  ![2026-10-25_14-13-59](images/2026-10-25_14-13-59.png)
 
![2026-10-25_14-14-16](images/2026-10-25_14-14-16.png)
I'm going to explain the difference here. For now I have a pptx but it is not suitable for the note taking style.

--lsa is about retrieving the secrets from `HKLM/SECURITY` while `-M lsassy` is about dumping the `lsass.exe` process memory. 