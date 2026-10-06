
We got a password for the account `samwell.tarky`.

Now let's try SMB enumeration.
  ![[images/2026-10-06_15-34-23.png]]
We do not have more rights than the anonymous auth.
In the `NETLOGON` and `SYSVOL` shares we can get powershell scripts with credentials in it.
  ![[images/2026-10-06_15-39-17.png]]
Before re-scan everything with the new credz, I'm going to try to connect to LDAP with the `samwell.tarly` account.

```bash
  nxc ldap 
```