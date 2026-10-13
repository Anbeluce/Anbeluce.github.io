---
title: Hướng dẫn đăng bài
description: Bài mẫu giải thích cách đăng bài mới trên blog — qua dashboard Pages CMS hoặc tạo file Markdown — và các định dạng có thể dùng trong bài.
date: 2026-10-13 08:00:00 +0700
categories: [Getting Started]
tags: [huong-dan]
image:
  path: /assets/img/posts/getting-started.svg
  alt: Hướng dẫn đăng bài
---

Đây là bài mẫu duy nhất trên blog. Đọc xong thì bạn có thể xoá bài này đi.

## Cách 1: Đăng bài bằng dashboard (khuyên dùng)

1. Vào <https://app.pagescms.org>, đăng nhập GitHub, chọn repo `Anbeluce.github.io`.
2. Bấm **Bài viết → Add an entry**.
3. Điền các ô:

| Ô | Ý nghĩa |
| --- | --- |
| Filename | Tên file, dạng `YYYY-MM-DD-ten-bai.md` — viết không dấu, nối bằng `-` |
| Tiêu đề | Tiêu đề bài |
| Mô tả ngắn | Hiện dưới tiêu đề trên card trang chủ |
| Ngày đăng | Ngày giờ đăng bài (giờ Việt Nam) |
| Danh mục | Tối đa 2 cấp: thêm mục cha trước, mục con sau |
| Tags | Từ khoá, viết thường, nối bằng `-` |
| Ảnh bìa | Ảnh hiện bên phải card trang chủ (không bắt buộc) |
| Ghim | Đưa bài lên đầu trang chủ |
| Nội dung | Viết bằng Markdown (xem phần dưới) |

4\. Bấm **Save**. Khoảng 1–2 phút sau bài sẽ lên site.

> Nếu đặt **ngày đăng ở tương lai**, bài sẽ bị ẩn cho tới khi có lần build sau thời điểm đó.
{: .prompt-warning }

## Cách 2: Tạo file Markdown

Tạo file trong thư mục `_posts`{: .filepath }, ví dụ `_posts/2026-10-20-bai-moi.md`{: .filepath }, rồi commit và push:

{% raw %}
~~~markdown
---
title: Tiêu đề bài
description: Mô tả ngắn hiện trên trang chủ
date: 2026-10-20 20:00:00 +0700   # luôn ghi kèm +0700 (giờ Việt Nam)
categories: [CTF Writeups]
tags: [ctf, forensics]
image:
  path: /assets/img/posts/ten-anh.png
  alt: Mô tả ảnh
---

Nội dung bài viết bằng Markdown...
~~~
{% endraw %}

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
{: .prompt-info }

> Mẹo — dùng `{: .prompt-tip }`.
{: .prompt-tip }

> Cảnh báo — dùng `{: .prompt-warning }`.
{: .prompt-warning }

> Nguy hiểm — dùng `{: .prompt-danger }`.
{: .prompt-danger }

### Callout kiểu Notion

<aside>
💡 Bọc đoạn văn trong thẻ <code>&lt;aside&gt;...&lt;/aside&gt;</code> để có khung nổi bật như thế này.
</aside>

### Ảnh trong bài

Upload ảnh vào mục **Media** của dashboard (hoặc thư mục `assets/img/`{: .filepath }), rồi chèn:

{% raw %}
~~~markdown
![Mô tả ảnh](/assets/img/posts/ten-anh.png)
_Chú thích nằm dưới ảnh_
~~~
{% endraw %}

![Ảnh ví dụ](/assets/img/posts/default.svg)
_Ví dụ ảnh có chú thích_

### Bảng

| Công cụ | Dùng để |
| --- | --- |
| Wireshark | Phân tích gói tin |
| Volatility | Phân tích bộ nhớ |

## Card ghim trên trang chủ

Card **"Bắt đầu tại đây"** ở đầu trang chủ được cấu hình trong mục **Card ghim trang chủ** của dashboard (file `_data/pinned_categories.yml`{: .filepath }). Mỗi card trỏ tới một danh mục — tên danh mục phải trùng với danh mục trong bài viết.
