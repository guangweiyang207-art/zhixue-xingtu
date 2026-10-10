import os
import struct
import zlib

OUT = r"c:\Users\Lenovo\Desktop\RuoYi-App-master\static\images\tabbar"
SIZE = 81


def write_png(path, rgba_rows):
    def chunk(tag, data):
        return struct.pack(">I", len(data)) + tag + data + struct.pack(">I", zlib.crc32(tag + data) & 0xFFFFFFFF)

    raw = b"".join(b"\x00" + b"".join(bytes(px) for px in row) for row in rgba_rows)
    compressed = zlib.compress(raw, 9)
    ihdr = struct.pack(">IIBBBBB", SIZE, SIZE, 8, 6, 0, 0, 0)
    png = b"\x89PNG\r\n\x1a\n" + chunk(b"IHDR", ihdr) + chunk(b"IDAT", compressed) + chunk(b"IEND", b"")
    with open(path, "wb") as f:
        f.write(png)


def blank():
    return [(0, 0, 0, 0) for _ in range(SIZE)]


def canvas():
    return [blank() for _ in range(SIZE)]


def set_px(rows, x, y, color):
    if 0 <= x < SIZE and 0 <= y < SIZE:
        rows[y][x] = color


def hex_color(h, a=255):
    h = h.lstrip("#")
    return (int(h[0:2], 16), int(h[2:4], 16), int(h[4:6], 16), a)


def draw_line(rows, x0, y0, x1, y1, color, width=4):
    dx = abs(x1 - x0)
    dy = abs(y1 - y0)
    sx = 1 if x0 < x1 else -1
    sy = 1 if y0 < y1 else -1
    err = dx - dy
    x, y = x0, y0
    while True:
        for oy in range(-width // 2, width // 2 + 1):
            for ox in range(-width // 2, width // 2 + 1):
                set_px(rows, x + ox, y + oy, color)
        if x == x1 and y == y1:
            break
        e2 = 2 * err
        if e2 > -dy:
            err -= dy
            x += sx
        if e2 < dx:
            err += dx
            y += sy


def draw_rect_outline(rows, x0, y0, x1, y1, color, width=4):
    draw_line(rows, x0, y0, x1, y0, color, width)
    draw_line(rows, x1, y0, x1, y1, color, width)
    draw_line(rows, x1, y1, x0, y1, color, width)
    draw_line(rows, x0, y1, x0, y0, color, width)


def fill_rect(rows, x0, y0, x1, y1, color):
    for y in range(min(y0, y1), max(y0, y1) + 1):
        for x in range(min(x0, x1), max(x0, x1) + 1):
            set_px(rows, x, y, color)


def draw_circle_outline(rows, cx, cy, r, color, width=4):
    for angle in range(0, 360):
        import math

        rad = math.radians(angle)
        x = int(cx + r * math.cos(rad))
        y = int(cy + r * math.sin(rad))
        for oy in range(-width // 2, width // 2 + 1):
            for ox in range(-width // 2, width // 2 + 1):
                set_px(rows, x + ox, y + oy, color)


def draw_home(rows, color):
    draw_line(rows, 40, 22, 18, 38, color)
    draw_line(rows, 18, 38, 18, 62, color)
    draw_line(rows, 18, 62, 62, 62, color)
    draw_line(rows, 62, 62, 62, 38, color)
    draw_line(rows, 62, 38, 40, 22, color)
    draw_rect_outline(rows, 34, 46, 47, 62, color)


def draw_calendar(rows, color):
    draw_rect_outline(rows, 20, 24, 61, 62, color)
    draw_line(rows, 20, 34, 61, 34, color)
    draw_line(rows, 30, 18, 30, 28, color)
    draw_line(rows, 51, 18, 51, 28, color)


def draw_chat(rows, color):
    draw_rect_outline(rows, 18, 22, 58, 50, color)
    fill_rect(rows, 28, 50, 36, 58, color)
    fill_rect(rows, 30, 33, 34, 37, color)
    fill_rect(rows, 47, 33, 51, 37, color)


def draw_mine(rows, color):
    draw_circle_outline(rows, 40, 36, 18, color)
    draw_circle_outline(rows, 40, 34, 8, color)
    for x in range(26, 55):
        y = 58 - abs(x - 40) // 2
        draw_line(rows, x, y, x, 62, color, 2)


icons = {
    "home": draw_home,
    "book": draw_calendar,
    "ai": draw_chat,
    "mine": draw_mine,
}

os.makedirs(OUT, exist_ok=True)
for name, fn in icons.items():
    for suffix, hex_c in [("", "#9E9E9E"), ("_", "#6B5AED")]:
        rows = canvas()
        fn(rows, hex_color(hex_c))
        write_png(os.path.join(OUT, f"{name}{suffix}.png"), rows)

print("icons generated")
