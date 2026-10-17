---
title: Hướng dẫn đăng bài
description: Bài mẫu giải thích cách tạo, ẩn và quản lý bài trên blog bằng
  cách tạo file trực tiếp — cùng các định dạng Markdown có thể dùng.
date: 2026-10-13 08:00:00 +0700
categories:
  - Getting Started
tags:
  - guide
image:
  path: /assets/img/posts/getting-started.svg
  alt: Hướng dẫn đăng bài
pin: false
draft: true
---
Đây là bài mẫu duy nhất trên blog. Đọc xong thì bạn có thể xoá bài này đi.

## Đăng bài mới

Blog này không có dashboard — viết bài bằng cách tạo file `.md` trong thư mục `_posts`{: .filepath }, rồi commit và push lên GitHub.

1. Tạo file, đặt tên theo đúng dạng `YYYY-MM-DD-ten-bai.md`{: .filepath }, ví dụ `_posts/2026-10-20-bai-moi.md`{: .filepath }.
2. Dán nội dung mẫu dưới đây vào, sửa lại cho bài của bạn:

{% raw %}

```markdown
---
title: Tiêu đề bài
description: Mô tả ngắn hiện trên trang chủ
date: 2026-10-20 20:00:00 +0700   # luôn ghi kèm +0700 (giờ Việt Nam)
categories: [CTF Writeups]
tags: [ctf, forensics]
pin: false      # true = ghim lên đầu trang chủ
draft: false    # true = ẩn bài khỏi toàn bộ site
image:
  path: /assets/img/posts/ten-anh.png
  alt: Mô tả ảnh
---

Nội dung bài viết bằng Markdown...
```

{% endraw %}

3. Commit và push lên nhánh `main`. GitHub Actions tự build, khoảng 1–2 phút sau bài lên site — theo dõi ở tab **Actions** của repo.

> Nếu đặt **ngày đăng ở tương lai**, bài sẽ bị ẩn cho tới khi có lần build sau thời điểm đó.
> {: .prompt-warning }

## Ẩn bài / đăng bài (quản lý bài)

Mỗi bài có trường `draft` trong front matter:

- **`draft: true`** — bài bị giấu khỏi toàn bộ site: không hiện ở trang chủ, danh mục, tìm kiếm, RSS... File vẫn nằm trong repo, chỉ không build ra trang.
- **`draft: false`** (mặc định) — bài hiển thị công khai như bình thường.

Dùng khi viết dở hoặc chưa muốn công bố — đặt `draft: true` thay vì xoá bài, rồi đổi lại `false` khi sẵn sàng đăng.

## Trước khi push: hai lỗi build hay gặp nhất

**Thiếu dòng trống.** Giữa các đoạn văn, trước/sau bảng, trước/sau khối code phải có **một dòng trống**. Thiếu dòng trống, Markdown sẽ gộp nhiều câu/dòng bảng thành một khối lộn xộn thay vì hiển thị tách bạch — xem mục **Định dạng** bên dưới để biết cách viết đúng.

**Link không phải URL thật.** `[chữ](duong-dan)` mà `duong-dan` không có `https://` ở đầu sẽ bị Jekyll hiểu là đường dẫn **nội bộ trên chính site**. Bước kiểm tra link trong GitHub Actions (html-proofer) sẽ chặn build nếu đường dẫn đó không tồn tại. Muốn nhắc tới tên file mà không link đi đâu, dùng `` `ten-file.py` `` (code, không phải link); muốn link ra ngoài thì nhớ `https://`.

> Chạy thử ở máy trước khi push giúp bắt lỗi sớm hơn — xem hướng dẫn "Chạy local" trong [README.md](https://github.com/Anbeluce/Anbeluce.github.io/blob/main/README.md){: .filepath }.
> {: .prompt-tip }

## Định dạng có thể dùng trong bài

### Chữ và danh sách

**In đậm**, *in nghiêng*, `code ngắn`, [đường link](https://anbeluce.github.io).

- Danh sách gạch đầu dòng
- Mục thứ hai

1. Danh sách đánh số
2. Mục thứ hai

### Khối code

```bash
# Code có tô màu và nút copy
echo "Hello"
```

```python
def hello():
    print("Hello")
```

### Khung ghi chú

> Ghi chú thông tin — thêm dòng `{: .prompt-info }` ngay dưới trích dẫn.
> {: .prompt-info }

> Mẹo — dùng `{: .prompt-tip }`.
> {: .prompt-tip }

> Cảnh báo — dùng `{: .prompt-warning }`.
> {: .prompt-warning }

> Nguy hiểm — dùng `{: .prompt-danger }`.
> {: .prompt-danger }

### Callout kiểu Notion

💡 Bọc đoạn văn trong thẻ `<aside>...</aside>` để có khung nổi bật như thế này.

### Ảnh trong bài

Thêm ảnh vào thư mục `assets/img/posts/`{: .filepath } (qua Git, không có chỗ upload riêng), rồi chèn:

{% raw %}

```markdown
![Mô tả ảnh](/assets/img/posts/ten-anh.png)
_Chú thích nằm dưới ảnh_
```

{% endraw %}

![Ảnh ví dụ](/assets/img/posts/default.svg)
*Ví dụ ảnh có chú thích*

### Bảng

| Công cụ    | Dùng để           |
| ---------- | ----------------- |
| Wireshark  | Phân tích gói tin |
| Volatility | Phân tích bộ nhớ  |

## Card ghim trên trang chủ

Card **"Bắt đầu tại đây"** ở đầu trang chủ được cấu hình trong file `_data/pinned_categories.yml`{: .filepath }. Mỗi card trỏ tới một danh mục — tên danh mục phải trùng với danh mục trong bài viết.
