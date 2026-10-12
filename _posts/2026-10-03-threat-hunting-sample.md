---
title: Lab Writeup - Threat Hunting Sample
description: "Category: Threat Hunting. Mô tả mẫu cho một lab săn tìm mối đe doạ trong môi trường Active Directory."
date: 2026-10-03 09:00:00 +0700
categories: [Cyber Defenders, Threat Hunting]
tags: [writeup, cyber-defenders, threat-hunting]
---

## Description

Bạn là analyst được giao điều tra cảnh báo bất thường trên domain controller.

## Questions

### Q1. Tiến trình đáng ngờ đầu tiên là gì?

```text
index=windows EventCode=4688 | stats count by ParentProcessName, NewProcessName
```

### Q2. Tài khoản nào bị Kerberoast?

```text
index=windows EventCode=4769 TicketEncryptionType=0x17
```

> Kết quả trên chỉ là ví dụ.
{: .prompt-info }
