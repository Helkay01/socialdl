from http.server import HTTPServer, BaseHTTPRequestHandler
import json
from yt_dlp import YoutubeDL

class YTDLPHandler(BaseHTTPRequestHandler):

    def do_POST(self):
        if self.path != "/yt":
            self.send_response(404)
            self.end_headers()
            return

        length = int(self.headers.get("Content-Length", 0))
        body = self.rfile.read(length)

        try:
            data = json.loads(body)
            url = data.get("url")
        except:
            url = None

        if not url:
            self._send_json(400, {"error": "Missing URL"})
            return

        try:
            ydl_opts = {"quiet": True, "skip_download": True, "format": "best"}
            with YoutubeDL(ydl_opts) as ydl:
                info = ydl.extract_info(url, download=False)
                result = {
                    "title": info.get("title"),
                    "thumbnail": info.get("thumbnail"),
                    "video_url": info.get("url")
                }

            self._send_json(200, result)

        except Exception as e:
            self._send_json(500, {"error": str(e)})

    def _send_json(self, status_code, data):
        payload = json.dumps(data).encode()
        self.send_response(status_code)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(payload)))
        self.end_headers()
        self.wfile.write(payload)


if __name__ == "__main__":
    HTTPServer(("0.0.0.0", 10000), YTDLPHandler).serve_forever()
