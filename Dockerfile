FROM cloudflare/cloudflared:latest
CMD ["tunnel", "--url", "http://localhost:4444"]
