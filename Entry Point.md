
We got a password for the account `samwell.tarky`.

Now let's try SMB enumeration.
  ![[images/2026-10-06_15-34-23.png]]
We do not have more rights than the anonymous auth.
In the `NETLOGON` and `SYSVOL` shares we can get powershell scripts with credentials in it.
  ![[images/2026-10-06_15-39-17.png]]
> **danger** Danger
> Will need to test this secret in base64 later !

Before re-scanning everything with the new credz, I'm going to try to connect to LDAP with the `samwell.tarly` account.

```bash
  nxc ldap winterfell -u 'samwell.tarly' -p 'Heartsbane' \
    -d "north.sevenkingdoms.local" --users
```
  ![[images/2026-10-06_15-50-16.png]]
Nothing new here, but sometimes we can get more users from LDAP than from SMB RIDs.

  
  ![[images/2026-10-07_10-55-04.png]]

