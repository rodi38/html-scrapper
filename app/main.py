from fastapi import FastAPI, Request
from playwright.async_api import async_playwright
import asyncio

app = FastAPI()

async def fetch_html(url: str) -> str:
    async with async_playwright() as p:
        browser = await p.chromium.launch(headless=True)
        page = await browser.new_page()
        await page.goto(url, wait_until='load')
        await asyncio.sleep(15)  # tempo extra de espera, opcional
        html = await page.content()
        await browser.close()
        return html

@app.post("/scrape")
async def scrape(request: Request):
    data = await request.json()
    url = data.get("url")
    if not url:
        return {"error": "URL não fornecida"}
    try:
        html = await fetch_html(url)
        return {"html": html}
    except Exception as e:
        return {"error": str(e)}
