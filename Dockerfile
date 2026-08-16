FROM cloudflare/cloudflared:latest

# خلي الخدمة شغالة وتجاوز Health Check
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:4444 || exit 1

CMD ["tunnel", "--url", "http://localhost:4444", "--protocol", "http2"]
