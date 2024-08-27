import http.server
import socketserver
import os
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# Get PORT from environment variable or use default 8000
PORT = int(os.getenv("PORT", 8000))


class MyHandler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/plain")
        self.end_headers()
        self.wfile.write(b"Hello, World!")


with socketserver.TCPServer(("", PORT), MyHandler) as httpd:
    print(f"Serving at port {PORT}")
    httpd.serve_forever()
