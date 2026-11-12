
So we have `jeor.mormont` credentials. Let's enumerate  shares on differents machines.
 ![[images/2026-11-12_17-44-17.png]]
We can see that the we have RW rights on the `ADMIN$` share. That is a good news, we can maybe have a winrm shell on the machine.
  ![[images/2026-11-12_17-47-02.png]]
Ok so we can use evil-winrm to have a shell but I think dumping LSA secrets, SAM db and dpapi is a faster way.
  ![[images/2026-11-12_17-48-35.png]]
Let's go ! Now we can do a lot of things. First with the SAM db we see the NT Hash of the Administrator account so we can now authenticate as the Administrator to most things in the machine.
  ![[images/2026-11-12_17-50-11.png]]
So we are now Admin on the `CASTLEBLACK` machine which is a DC. Let's dump ldap and import everything in BloodHound.





  