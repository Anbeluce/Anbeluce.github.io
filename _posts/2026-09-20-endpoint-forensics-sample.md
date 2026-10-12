---
title: Lab Writeup - Endpoint Forensics Sample
description: "Category: Endpoint Forensics. Phân tích artifact Windows: Prefetch, Amcache, Registry và Event Logs."
date: 2026-09-20 09:00:00 +0700
categories: [Cyber Defenders, Endpoint Forensics]
tags: [writeup, cyber-defenders, endpoint-forensics]
---

## Artifacts

| Artifact | Vị trí |
| --- | --- |
| Prefetch | `C:\Windows\Prefetch` |
| Amcache | `C:\Windows\appcompat\Programs\Amcache.hve` |
| Event Logs | `C:\Windows\System32\winevt\Logs` |

## Tools

- Eric Zimmerman's tools (PECmd, AmcacheParser, EvtxECmd)
- Timeline Explorer
