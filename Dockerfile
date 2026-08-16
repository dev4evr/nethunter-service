FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    curl \
    wget \
    unzip \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# تحميل cloudflared
RUN wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O /usr/local/bin/cloudflared && \
    chmod +x /usr/local/bin/cloudflared

# خادم صحي على port 8000
RUN echo "from http.server import HTTPServer, BaseHTTPRequestHandler\n\
class Handler(BaseHTTPRequestHandler):\n\
    def do_GET(self):\n\
        self.send_response(200)\n\
        self.end_headers()\n\
        self.wfile.write(b'OK')\n\
server = HTTPServer(('0.0.0.0', 8000), Handler)\n\
server.serve_forever()" > /health.py

CMD ["sh", "-c", "python3 /health.py & /usr/local/bin/cloudflared tunnel --url http://localhost:4444 --protocol http2"]
