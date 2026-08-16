FROM python:3.10-slim

RUN apt-get update && apt-get install -y curl wget unzip && rm -rf /var/lib/apt/lists/*

RUN wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O /usr/local/bin/cloudflared && chmod +x /usr/local/bin/cloudflared

RUN echo "from http.server import HTTPServer, BaseHTTPRequestHandler\nclass Handler(BaseHTTPRequestHandler):\n    def do_GET(self):\n        self.send_response(200)\n        self.end_headers()\n        self.wfile.write(b'OK')\nserver = HTTPServer(('0.0.0.0', 8000), Handler)\nserver.serve_forever()" > /health.py

CMD ["sh", "-c", "python3 /health.py & /usr/local/bin/cloudflared tunnel --url http://localhost:4444 --protocol http2"]
