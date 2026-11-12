# GOAD Write Up

A learning log of my walkthrough of [GOAD (Game of Active Directory)](https://github.com/Orange-Cyberdefense/GOAD) — see [the README](README.md) for the full intro and lab references.

> **GitHub readers:** the clean, GitHub-rendered version of these notes lives on the [github branch](https://github.com/Drapsague/goad-notes/tree/github) — auto-generated from this space on every sync.

## The notes

Read in order:

- [First Steps](First-Steps.md) — nmap sweep, machine map, first SMB footholds
- [Enumerate](Enumerate.md) — AS-REP roasting
- [Delegation](Delegation.md) — constrained delegation rabbit hole

## Lab at a glance

- Machines: 5 across `sevenkingdoms.local`, `north.*` and `essos.local`
- Toolbelt: nmap, nxc, ldapsearch, impacket, BloodHound

## Recently updated

<!--#lua query[ from p = index.tag "page" where p.name ~= "README" and p.name ~= "index" and not p.name:match("^System") and not p.name:match("^tools") order by p.lastModified desc select { Name = p.name, Modified = p](%20from%20p%20%3D%20index.tag%20%22page%22%20where%20p.name%20~%3D%20%22README%22%20and%20p.name%20~%3D%20%22index%22%20and%20not%20p.name%3Amatch(%22%5ESystem%22)%20and%20not%20p.name%3Amatch(%22%5Etools%22)%20order%20by%20p.lastModified%20desc%20select%20%7B%20Name%20%3D%20p.name%2C%20Modified%20%3D%20p.lastModified%20%7D%20.md) -->
| Name         | Modified   |
| ------------ | ---------- |
| First-Steps  | 2026-10-23 |
| Enumerate    | 2026-10-23 |
| Delegation   | 2026-10-13 |
<!--/lua-->
<!-- Baked section: renders everywhere (GitHub too). Refresh inside
     SilverBullet with "Baked Sections: Update" (Ctrl-Shift-b). -->