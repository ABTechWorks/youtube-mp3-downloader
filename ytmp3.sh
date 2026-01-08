#!/bin/bash

[ -f cookies.conf ] && source cookies.conf

read -p "Enter YouTube Video URL: " URL

if [ -z "$URL" ]; then
    echo "❌ No URL provided. Exiting..."
    exit 1
fi

if [[ "$URL" == *"music.youtube.com"* ]]; then
    URL="${URL/music.youtube.com/www.youtube.com}"
    echo "🎶 Converted YouTube Music link to regular YouTube link:"
    echo "➡️  $URL"
fi

OUTPUT_DIR="downloads"

mkdir -p "$OUTPUT_DIR"

echo "🎵 Downloading audio from: $URL"

yt-dlp \
  --cookies "$COOKIES_FILE" \
  --extract-audio \
  --audio-format mp3 \
  --audio-quality 0 \
  -o "$OUTPUT_DIR/%(title)s.%(ext)s" \
  "$URL"

if [ $? -eq 0 ]; then
    echo "✅ Download complete! MP3 saved in '$OUTPUT_DIR/'"
else
    echo "❌ Download failed. Try using a regular YouTube link or check login permissions."
fi

