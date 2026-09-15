"""
Generates one QR code per restaurant table for Plates & Pours.
Each QR encodes a URL like: https://YOUR-DOMAIN/order?table=3
Scanning it opens the Flutter web ordering app pre-loaded to that table.

Usage:
    pip install qrcode[pil]
    python generate_table_qr.py
"""

import os
import qrcode

# --- EDIT THESE TWO VALUES FOR YOUR SETUP ---
BASE_URL = "https://platesandpours.web.app/order"  # your deployed Firebase Hosting URL
NUM_TABLES = 10                                     # how many tables you have
# ---------------------------------------------

OUTPUT_DIR = "qr_codes"
os.makedirs(OUTPUT_DIR, exist_ok=True)

for table_id in range(1, NUM_TABLES + 1):
    url = f"{BASE_URL}?table={table_id}"
    img = qrcode.make(url, box_size=10, border=4)
    filename = os.path.join(OUTPUT_DIR, f"table_{table_id}.png")
    img.save(filename)
    print(f"Table {table_id}: {url}  ->  {filename}")

print("\nDone. Print each PNG and place it on its matching table.")
