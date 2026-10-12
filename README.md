# My Blog

Blog Jekyll dùng theme [Chirpy](https://github.com/cotes2020/jekyll-theme-chirpy) (MIT), tùy biến tông xanh lá + ảnh nền.

## Tùy biến chính

| File | Nội dung |
| --- | --- |
| `_config.yml` | Tên site, tagline, avatar, timezone, social, `theme_mode: dark`, `paginate` |
| `_includes/metadata-hook.html` | Toàn bộ CSS tùy biến (màu, ảnh nền + lớp phủ, hover nút/tag/card, nav active, callout `<aside>`) |
| `_layouts/home.html` | Trang chủ: card ghim danh mục, card có ảnh bìa + viền xanh |
| `_data/pinned_categories.yml` | Các card "Pinned Category" ở đầu trang chủ |
| `_data/contact.yml` | Icon mạng xã hội ở cuối sidebar |
| `_tabs/about.md` | Trang About |
| `assets/img/` | `avatar.svg`, `bg/bg.svg`, ảnh bìa trong `posts/` — thay bằng ảnh của bạn |

Bài viết mới: tạo file `_posts/YYYY-MM-DD-ten-bai.md` với front matter `title`, `description`, `date`, `categories`, `tags`, và tuỳ chọn `image.path`.

## Chạy local (Docker, không cần cài Ruby)

```bash
docker run --rm -it -v "${PWD}:/site" -v blog-gems:/usr/local/bundle -w /site -p 4000:4000 ruby:3.3 bash -c "bundle install && bundle exec jekyll serve -H 0.0.0.0 --force_polling"
```

Mở http://localhost:4000

## Dashboard admin online (Pages CMS)

Sau khi đã push lên GitHub:

1. Vào https://app.pagescms.org, bấm **Sign in with GitHub**, cấp quyền cho repo `<username>.github.io`.
2. Chọn repo và nhánh `main`. Menu bên trái gồm Bài viết, Trang About, Card ghim trang chủ, Icon mạng xã hội và Media.
3. Bấm **Lưu** sẽ tạo một commit vào repo. GitHub Actions tự build lại, khoảng 1–2 phút sau site được cập nhật (theo dõi ở tab **Actions** của repo).

Cấu hình nằm trong `.pages.yml`.

## Dashboard admin local (jekyll-admin)

Khi server local đang chạy, mở http://localhost:4000/admin để:

- **Posts**: viết bài mới, sửa, xoá bài (soạn Markdown, điền front matter như title, date, categories, tags, image)
- **Pages**: sửa các trang như About, Categories...
- **Data Files**: sửa `_data/*.yml` (card ghim trang chủ, icon mạng xã hội)
- **Static Files**: upload ảnh vào `assets/`
- **Configuration**: sửa `_config.yml` (sửa xong cần khởi động lại server)

Dashboard ghi trực tiếp vào file trong thư mục này. Sau đó commit và push để site trên GitHub Pages được cập nhật.
Dashboard **chỉ chạy ở local** và không xuất hiện trên site đã deploy.

## Deploy lên GitHub Pages

1. Tạo repo `<username>.github.io`, push code lên nhánh `main`.
2. Repo → Settings → Pages → Source: **GitHub Actions** (workflow có sẵn ở `.github/workflows/pages-deploy.yml`).
3. Điền `url: "https://<username>.github.io"` trong `_config.yml`.
