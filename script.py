#!/usr/bin/env python3
import sys
import json
import yt_dlp

url = sys.argv[1]

ydl_opts = {
    "quiet": True,
    "skip_download": True,
    "format": "bestvideo+bestaudio/best",
}

with yt_dlp.YoutubeDL(ydl_opts) as ydl:
    info = ydl.extract_info(url, download=False)

    result = {
        "id": info.get("id"),
        "title": info.get("title"),
        "duration": info.get("duration"),
        "uploader": info.get("uploader"),
        "view_count": info.get("view_count"),
        "thumbnail": info.get("thumbnail"),
        "formats": []
    }

    for f in info.get("formats", []):
        if f.get("url"):
            result["formats"].append({
                "format_id": f.get("format_id"),
                "ext": f.get("ext"),
                "resolution": f.get("resolution"),
                "fps": f.get("fps"),
                "vcodec": f.get("vcodec"),
                "acodec": f.get("acodec"),
                "filesize": f.get("filesize"),
                "url": f.get("url")
            })

    print(json.dumps(result, ensure_ascii=False))
