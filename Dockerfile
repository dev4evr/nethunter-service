FROM ngrok/ngrok:latest

# ضع التوكن الخاص بك بين علامتي التنصيص بدلاً من YOUR_AUTHTOKEN
ENV NGROK_AUTHTOKEN="2w5IRycFQhPA2WLWjtRPKWRbG3n_3oLA93n88Ep5qPoL4sdg7"

CMD ["http", "4444"]
