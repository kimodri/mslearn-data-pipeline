import requests, datetime, json

url = "https://learn.microsoft.com/api/catalog"
params = {'locale': 'en-us'}

fn = f"files/microsoft_learn_catalog_{datetime.datetime.now():%Y%m%d}.json"

response = requests.get(url, params=params, timeout=60)
response.raise_for_status()

# make this cloud based
with open(fn, "w", encoding="utf-8") as f:
    json.dump(response.json(), f, ensure_ascii=False)
    print("saved:", fn)
