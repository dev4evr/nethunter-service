FROM cloudflare/cloudflared:latest

# نضيف تطبيق بسيط يستمع على المنفذ 8000 عشان Koyeb يرضى
RUN apt-get update && apt-get install -y python3
RUN echo "from http.server import HTTPServer, BaseHTTPRequestHandler\n\
class Handler(BaseHTTPRequestHandler):\n\
    def do_GET(self):\n\
        self.send_response(200)\n\
        self.end_headers()\n\
        self.wfile.write(b'OK')\n\
server = HTTPServer(('0.0.0.0', 8000), Handler)\n\
server.serve_forever()" > /health.py

CMD ["sh", "-c", "python3 /health.py & cloudflared tunnel --url http://localhost:4444 --protocol http2"]
