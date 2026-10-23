AD-notes

Personal notes and writeups from working through **GOAD (Game of Active Directory)**, the vulnerable Active Directory lab by [Orange Cyberdefense](https://github.com/Orange-Cyberdefense/GOAD).

This repo is a learning log: how the lab is set up, what I tried, what worked, and the concepts behind each step. It's written for my own reference, but hopefully it's useful to anyone else learning AD security in a lab environment.

## About GOAD

GOAD is a self-hosted lab built to practice Active Directory attack and defense techniques safely. It ships a multi-domain forest themed on *Game of Thrones* (`sevenkingdoms.local`, `north.sevenkingdoms.local`, `essos.local`) with intentionally misconfigured machines.

> **Lab only.** Everything here is done against my own GOAD instance in an isolated environment. These techniques are for authorized testing and education — don't use them against systems you don't own or have explicit permission to test.

## Lab setup

- **Version:** _TODO — e.g. GOAD / GOAD-Light / GOAD-Mini_
- **Provider:** _TODO — VirtualBox / VMware / Proxmox / cloud_
- **Attacker box:** _TODO — Kali / your distro_

## Contents

Notes are organized by attack phase:

- `01-recon/` — enumeration and information gathering
- `02-initial-access/` — getting the first foothold
- `03-lateral-movement/` — moving between hosts and users
- `04-privilege-escalation/` — local and domain privilege escalation
- `05-domain-dominance/` — forest/domain takeover and persistence

_(Adjust these as the notes grow.)_

## Notes

- Hostnames, IPs, and credentials in here come from the lab and may differ from your own deployment.
- Nothing in this repo is tied to a real/production environment.

## References

- [GOAD by Orange Cyberdefense](https://github.com/Orange-Cyberdefense/GOAD)
- [The Hacker Recipes](https://www.thehacker.recipes/)

