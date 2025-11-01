import json, os
import requests
import datetime, logging
import azure.functions as func

app = func.FunctionApp()

@app.timer_trigger(
    arg_name="myTimer",
    schedule = "0 11 * * *",
    run_on_startup=False
)
@app.blob_output(
    arg_name="outputBlob",
    path="files/microsoft_learn_catalog_{datetime:yyMMdd}.json",
    connection="OutputStorageConnection"
)
def ExtractFunction(myTimer: func.TimerRequest, outputBlob: func.Out[str]) -> None:
    logging.info("Timer trigger starting data extraction.")

    url = "https://learn.microsoft.com/api/catalog"
    params = {"locale": "en-us"}
    
    try:
        logging.info("Fetching Microsoft Learn catalog data...")
        response = requests.get(url, params=params, timeout=60)
        response.raise_for_status()
        data = response.json()

        # Serialize to JSON string
        json_string = json.dumps(data, indent=2)

        # Set the output: the Host handles the connection and the file name creation
        outputBlob.set(json_string)

        logging.info(f"Upload completed to container 'files'!")
        
    except requests.exceptions.RequestException as e:
        logging.error(f"Error fetching data from API: {e}")
    except Exception as e:
        logging.error(f"An unexpected error occurred: {e}")