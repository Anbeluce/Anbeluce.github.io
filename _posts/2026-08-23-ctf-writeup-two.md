---
title: Sample CTF 2026 Writeup
description: Welcome to this sample CTF writeup! It shows how a multi-challenge writeup looks with headings, code blocks and prompts.
date: 2026-08-23 10:00:00 +0700
categories: [CTF Writeups]
tags: [ctf, network]
---

## Packet Capture

Mở file `capture.pcapng`{: .filepath } bằng Wireshark và lọc theo HTTP:

```text
http.request.method == "POST"
```

## Log Analysis

```python
import re
with open("access.log") as f:
    for line in f:
        if re.search(r"(union|select).*from", line, re.I):
            print(line.strip())
```

> Đây là nội dung mẫu.
{: .prompt-warning }
