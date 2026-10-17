# My Blog

Blog Jekyll dùng theme [Chirpy](https://github.com/cotes2020/jekyll-theme-chirpy) (MIT), tùy biến tông vàng + ảnh nền. Viết và sửa bài trực tiếp bằng file (IDE/git) — không dùng dashboard admin nào.

## Tùy biến chính

| File | Nội dung |
| --- | --- |
| `_config.yml` | Tên site, tagline, avatar, timezone, social, `theme_mode: dark`, `paginate` |
| `_includes/metadata-hook.html` | Toàn bộ CSS tùy biến (màu vàng chủ đạo ở `--color-primary`, ảnh nền + lớp phủ, hover nút/tag/card, nav active, callout `<aside>`) |
| `_layouts/home.html` | Trang chủ: card ghim danh mục, card có ảnh bìa + viền xanh |
| `_data/theme.yml` | Tên blog, tagline, avatar, ảnh nền, độ phủ, màu chủ đạo/phụ, font — đọc bởi `_plugins/theme-settings.rb` |
| `_data/pinned_categories.yml` | Các card "Pinned Category" ở đầu trang chủ |
| `_data/contact.yml` | Icon mạng xã hội ở cuối sidebar |
| `_data/status.yml` | Khung trạng thái online (GitHub activity, Discord presence) ở sidebar |
| `_tabs/about.md` | Trang About |
| `assets/img/` | `avatar.svg`, `bg/bg.svg`, ảnh bìa trong `posts/` — thay bằng ảnh của bạn |

## Đăng bài mới

Tạo file `_posts/YYYY-MM-DD-ten-bai.md`{: .filepath }:

```markdown
---
title: Tiêu đề bài
description: Mô tả ngắn hiện trên trang chủ
date: 2026-10-20 20:00:00 +0700   # luôn ghi kèm +0700 (giờ Việt Nam)
categories: [CTF Writeups]
tags: [ctf, forensics]
pin: false      # true = ghim lên đầu trang chủ
draft: false    # true = ẩn bài khỏi toàn bộ site, không build ra trang
image:
  path: /assets/img/posts/ten-anh.png
  alt: Mô tả ảnh
---

Nội dung bài viết bằng Markdown...
```

**Quan trọng khi viết:** giữa các đoạn văn, trước/sau bảng, trước/sau khối code phải có **một dòng trống**. Thiếu dòng trống, Markdown sẽ gộp nhiều đoạn/dòng bảng thành một khối lộn xộn — xem [_posts/2026-10-13-huong-dan-dang-bai.md](_posts/2026-10-13-huong-dan-dang-bai.md) để biết cú pháp đầy đủ (khung ghi chú màu, callout, bảng, link, ảnh).

**Kiểm tra link trước khi push:** `[chữ](duong-dan)` mà `duong-dan` không phải URL thật (thiếu `https://`, hoặc trỏ tới file không có trên site) sẽ làm build GitHub Actions fail (bước `htmlproofer` kiểm tra mọi link nội bộ). Muốn nhắc tới tên file mà không link đi đâu, dùng `` `ten-file.py` `` (code, không phải link).

Commit và push lên `main`, GitHub Actions tự build và deploy, khoảng 1–2 phút sau lên site.

## Chạy local (Docker, không cần cài Ruby)

```bash
docker run --rm -it -v "${PWD}:/site" -v blog-gems:/usr/local/bundle -w /site -p 4000:4000 ruby:3.3 bash -c "bundle install && bundle exec jekyll serve -H 0.0.0.0 --force_polling"
```

Mở http://localhost:4000 để xem trước khi push — phát hiện lỗi build hoặc link hỏng sớm hơn là chờ GitHub Actions.

## Deploy lên GitHub Pages

1. Tạo repo `<username>.github.io`, push code lên nhánh `main`.
2. Repo → Settings → Pages → Source: **GitHub Actions** (workflow có sẵn ở `.github/workflows/pages-deploy.yml`).
3. Điền `url: "https://<username>.github.io"` trong `_config.yml`.
