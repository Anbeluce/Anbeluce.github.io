---
title: Hướng dẫn đăng bài
description: Bài mẫu giải thích cách đăng, ẩn và quản lý bài trên blog — không
  cần biết Markdown — và các định dạng có thể dùng khi cần viết nâng cao.
date: 2026-10-13 08:00:00 +0700
categories:
  - Getting Started
tags:
  - guide
image:
  path: /assets/img/posts/getting-started.svg
  alt: Hướng dẫn đăng bài
pin: false
---
Đây là bài mẫu duy nhất trên blog. Đọc xong thì bạn có thể xoá bài này đi.

## Đăng bài — không cần biết Markdown

1. Vào [app.pagescms.org](https://app.pagescms.org), đăng nhập GitHub, chọn repo `Anbeluce.github.io`.
2. Bấm mục **⭐ Viết bài → Add an entry**.
3. Soạn như soạn Word bình thường: gõ chữ, bôi đen để in đậm/nghiêng, gõ **`/`** để chèn tiêu đề, danh sách, ảnh...
4. Điền thêm các ô bên cạnh nội dung:

| Ô | Ý nghĩa |
| --- | --- |
| Tiêu đề | Tiêu đề bài |
| Mô tả ngắn | Hiện dưới tiêu đề trên card trang chủ |
| Ngày đăng | Ngày giờ đăng bài (giờ Việt Nam) |
| Danh mục | Tối đa 2 cấp: thêm mục cha trước, mục con sau |
| Tags | Từ khoá, viết thường, nối bằng `-` |
| Ảnh bìa | Ảnh hiện bên phải card trang chủ (không bắt buộc) |
| Ghim | Đưa bài lên đầu trang chủ |
| Ẩn bài | Xem mục **Ẩn bài / đăng bài** bên dưới |

5. Bấm **Save**. Khoảng 1–2 phút sau bài lên site.

> Nếu đặt **ngày đăng ở tương lai**, bài sẽ bị ẩn cho tới khi có lần build sau thời điểm đó.
> {: .prompt-warning }

## Ẩn bài / đăng bài (quản lý bài)

Mỗi bài có ô **"Ẩn bài (nháp, chưa đăng)"**:

- **Bật** — bài bị giấu khỏi toàn bộ site: không hiện ở trang chủ, danh mục, tìm kiếm, RSS... Bài vẫn nằm trong dashboard, chỉ bạn thấy được.
- **Tắt** (mặc định) — bài hiển thị công khai như bình thường.

Dùng khi viết dở hoặc chưa muốn công bố — bật ô này thay vì xoá bài, sau đó tắt đi khi sẵn sàng đăng.

Ở mục **⭐ Viết bài**, danh sách bài có thêm cột trạng thái này để bạn nhìn nhanh bài nào đang ẩn.

## Khi nào cần "Bài viết (nâng cao)"

Mục **⭐ Viết bài** soạn trực quan là đủ cho hầu hết bài viết. Chỉ cần mở **Bài viết (nâng cao)** khi bài có:

- Khung ghi chú màu (info/tip/warning/danger) hoặc callout kiểu Notion — xem ví dụ bên dưới.
- Đoạn Markdown bạn muốn kiểm soát từng ký tự, ví dụ copy từ nơi khác sang.

Mục này cho gõ Markdown thô trực tiếp — chính là những gì bạn thấy ở phần **Định dạng** dưới đây.

> Mẹo: trong mục ⭐ Viết bài, khung soạn có nút chuyển **Editor / Source** ở góc. Bấm **Source** là gõ được Markdown thô y như mục nâng cao, không cần đổi mục.
> {: .prompt-tip }

## Gõ tắt trong khung soạn trực quan

Nút **/** chỉ liệt kê một phần. Phần lớn ký hiệu Markdown bên dưới gõ thẳng vào bài là tự đổi định dạng ngay, không cần mở menu nào cả — mình đã thử từng cái trong bảng này trực tiếp trên dashboard.

| Gõ | Ra kết quả |
| --- | --- |
| `**chữ**` | **In đậm** |
| `*chữ*` | *In nghiêng* |
| `~~chữ~~` | ~~Gạch ngang~~ |
| `` `chữ` `` | `Code ngắn` |
| `# `, `## `, `### ` đầu dòng | Tiêu đề lớn/vừa/nhỏ |
| `- ` đầu dòng | Danh sách gạch đầu dòng |
| `1. ` đầu dòng | Danh sách đánh số |
| `> ` đầu dòng | Khung trích dẫn |
| ` ``` ` rồi Enter | Khối code (gõ ` ```js ` để tô màu đúng ngôn ngữ) |
| `---` rồi Enter | Đường kẻ ngang |
| Bôi đen chữ | Hiện thanh công cụ nhỏ: đậm, nghiêng, gạch chân, gạch ngang, code, chèn link |

Bôi đen một đoạn xong gõ **Ctrl+K** là chèn link nhanh, không cần bấm nút.

**Không có trong khung soạn trực quan**, chỉ làm được ở chế độ **Source** hoặc mục **Bài viết (nâng cao)**:

- Checklist (`- [ ]`)
- Khung ghi chú màu (info/tip/warning/danger) và callout `<aside>` của theme — đây là cú pháp riêng của Chirpy, không phải Markdown chuẩn, nên không engine soạn trực quan nào hiểu được.

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

Upload ảnh vào mục **Media** của dashboard (hoặc thư mục `assets/img/`{: .filepath }), rồi chèn:

{% raw %}

```markdown
![Mô tả ảnh](/assets/img/posts/ten-anh.png)
_Chú thích nằm dưới ảnh_
```

{% endraw %}

![Ảnh ví dụ](/assets/img/posts/default.svg)
*Ví dụ ảnh có chú thích*

### Bảng

| Công cụ | Dùng để |
| --- | --- |
| Wireshark | Phân tích gói tin |
| Volatility | Phân tích bộ nhớ |

## Tạo file trực tiếp (cho ai quen Git)

Tạo file trong thư mục `_posts`{: .filepath }, ví dụ `_posts/2026-10-20-bai-moi.md`{: .filepath }, rồi commit và push:

{% raw %}

```markdown
---
title: Tiêu đề bài
description: Mô tả ngắn hiện trên trang chủ
date: 2026-10-20 20:00:00 +0700   # luôn ghi kèm +0700 (giờ Việt Nam)
categories: [CTF Writeups]
tags: [ctf, forensics]
draft: false   # bật true để ẩn bài
image:
  path: /assets/img/posts/ten-anh.png
  alt: Mô tả ảnh
---

Nội dung bài viết bằng Markdown...
```

{% endraw %}

## Card ghim trên trang chủ

Card **"Bắt đầu tại đây"** ở đầu trang chủ được cấu hình trong mục **Card ghim trang chủ** của dashboard (file `_data/pinned_categories.yml`{: .filepath }). Mỗi card trỏ tới một danh mục — tên danh mục phải trùng với danh mục trong bài viết.
