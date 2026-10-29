# This page is dedicated to NTML Relay attack

> **note** Note
> Don't worry I will explain in details what is NTLM Relay attack


There are many different NTLM relay attacks, we are going to focus on the most basic one. So If a user search for an SMB share that does not exist, the machine is going to ask the DNS for the machine IP, but as it doest exist the DNS does not know the answer. So it passes it to the LLMR protocol, which will broadcast a message like "Who is ..." with the NTLM challenge to authenticate. We can then relay the challenge and send it to another machine. At least in theory.

To perform the attack we need to understand how the authentication works
  ![[images/2026-10-29_16-57-15.png]]
So the client ask the server for info about its version over SMB for instance, if it's signed or which hashing algorithm it uses (e.g NTLMv1, NTLMv2) 


## How to identify candidates machine for the attack

  ![[images/2026-10-23_17-26-55.png]]
![[images/2026-10-23_17-27-31.png]]
So here are the machines against we are going to test the attack.



