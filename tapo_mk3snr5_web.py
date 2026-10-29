#!/home/alex/printer_data/config/scripts/tapo_env/bin/python3
import asyncio
import subprocess
from flask import Flask, render_template_string, redirect, request, url_for

app = Flask(__name__)

async def set_tapo_state(state):
    script_path = "/home/alex/printer_data/config/scripts/tapo_mk3snr5_control.py"
    # Führt das Konsolenskript für Nr. 5 aus
    subprocess.run([script_path, state])

HTML_TEMPLATE = """
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Prusa MK3S Nr. 5 Power</title>
    <style>
        body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; background: #121212; color: #e0e0e0; text-align: center; padding-top: 50px; }
        .card { background: #1e1e1e; max-width: 400px; margin: 0 auto; padding: 30px; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.5); }
        h2 { margin-bottom: 25px; color: #ffffff; }
        .btn { display: block; width: 100%; padding: 15px; margin: 15px 0; font-size: 18px; font-weight: bold; border: none; border-radius: 8px; cursor: pointer; text-decoration: none; color: white; transition: background 0.2s; box-sizing: border-box; }
        .btn-on { background: #2e7d32; }
        .btn-on:hover { background: #388e3c; }
        .btn-off { background: #c62828; }
        .btn-off:hover { background: #d32f2f; }
        .btn-back { background: #424242; font-size: 14px; padding: 10px; margin-top: 20px; }
        .btn-back:hover { background: #616161; }
    </style>
</head>
<body>
    <div class="card">
        <h2>Prusa MK3S Nr. 5 Power</h2>
        <a href="/on" class="btn btn-on">EINSCHALTEN & NEU STARTEN</a>
        <a href="/off" class="btn btn-off">AUSSCHALTEN</a>
        <a href="javascript:history.back()" class="btn btn-back">← Zurück zur vorherigen Seite</a>
    </div>
</body>
</html>
"""

@app.route("/")
def index():
    return render_template_string(HTML_TEMPLATE)

@app.route("/on")
def turn_on():
    asyncio.run(set_tapo_state("on"))
    return redirect(request.referrer or url_for('index'))

@app.route("/off")
def turn_off():
    asyncio.run(set_tapo_state("off"))
    return redirect(request.referrer or url_for('index'))

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5001)
