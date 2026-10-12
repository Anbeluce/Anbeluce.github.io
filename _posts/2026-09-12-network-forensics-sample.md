---
title: Lab Writeup - Network Forensics Sample
description: "Category: Network Forensics. Phân tích lưu lượng mạng để xác định C2 và dữ liệu bị đánh cắp."
date: 2026-09-12 09:00:00 +0700
categories: [Cyber Defenders, Network Forensics]
tags: [writeup, cyber-defenders, network-forensics, network]
---

## Tìm C2

```bash
tshark -r traffic.pcap -T fields -e ip.dst -e dns.qry.name | sort | uniq -c | sort -nr | head
```

> Chú ý các truy vấn DNS có entropy cao.
{: .prompt-tip }
