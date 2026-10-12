---
title: Sample CTF Quals Forensics Writeup
description: Writeup mẫu cho mảng Forensics ở một vòng loại CTF. Thay bằng writeup thật của bạn — các bài viết nằm trong thư mục _posts.
date: 2026-10-05 10:00:00 +0700
categories: [CTF Writeups]
tags: [ctf, forensics]
---

## Challenge 1 — Disk Image

Đề cho một file ảnh đĩa `evidence.E01`{: .filepath }. Mở bằng **FTK Imager**, duyệt phân vùng *NTFS* và kiểm tra thư mục người dùng.

```bash
# Kiểm tra hash trước khi phân tích
sha256sum evidence.E01
```

> Luôn verify hash của evidence trước khi làm việc.
{: .prompt-info }

## Challenge 2 — Memory Dump

```bash
vol -f memory.raw windows.pslist
vol -f memory.raw windows.cmdline
```

Tìm tiến trình đáng ngờ, sau đó dump và phân tích tiếp.

> Flag mẫu: `CTF{this_is_a_placeholder}`
{: .prompt-tip }
