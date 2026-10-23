# GOAD Write Up

A learning log of my walkthrough of [GOAD (Game of Active Directory)](https://github.com/Orange-Cyberdefense/GOAD) — see [[README|the README]] for the full intro and lab references.

> **GitHub readers:** the clean, GitHub-rendered version of these notes lives on the [github branch](https://github.com/Drapsague/goad-notes/tree/github) — auto-generated from this space on every sync.

## The notes

Read in order:

- [[First-Steps|First Steps]] — nmap sweep, machine map, first SMB footholds
- [[Enumerate]] — AS-REP roasting
- [[Delegation]] — constrained delegation rabbit hole

## Lab at a glance

- Machines: 5 across `sevenkingdoms.local`, `north.*` and `essos.local`
- Toolbelt: nmap, nxc, ldapsearch, impacket, BloodHound

## Recently updated

<!--#lua query[[ from p = index.tag "page" where p.name ~= "README" and p.name ~= "index" and not p.name:match("^System") and not p.name:match("^tools") order by p.lastModified desc select { Name = p.name, Modified = p.lastModified } ]] -->
| Name         | Modified   |
| ------------ | ---------- |
| First-Steps  | 2026-10-23 |
| Enumerate    | 2026-10-23 |
| Delegation   | 2026-10-13 |
<!--/lua-->
<!-- Baked section: renders everywhere (GitHub too). Refresh inside
     SilverBullet with "Baked Sections: Update" (Ctrl-Shift-b). -->