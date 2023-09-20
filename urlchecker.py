from flask import Flask, request, jsonify
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
import time

app = Flask(__name__)
service = Service(ChromeDriverManager().install())
options = webdriver.ChromeOptions()
driver = webdriver.Chrome(service=service, options=options)

@app.route('/check_url', methods=['GET'])
def check_url():
    url = 'https://www.ipqualityscore.com/threat-feeds/malicious-url-scanner'
    input_value = request.args.get('a')

    if input_value is None:
        return jsonify({"error": "Missing 'a' parameter."}), 400

    driver.get(url)

    input_field = driver.find_element(By.ID, "url")
    input_field.send_keys(input_value)
    time.sleep(3)
    input_field.send_keys(Keys.ENTER)

    wait = WebDriverWait(driver, 10)
    result = wait.until(EC.presence_of_element_located((By.XPATH, "/html/body/section[1]/div[2]/div[1]/div/div[4]/table/tbody/tr[1]/td[2]")))
    activity = driver.find_element(By.XPATH, "/html/body/section[1]/div[2]/div[1]/div/div[4]/table/tbody/tr[2]/td[2]")

    result_text = result.text
    activity_text = activity.text

    if "Suspicious" in result_text or "Suspicious" in activity_text:
        response = {"status": "UNSAFE"}
    else:
        response = {"status": "SAFE"}

    return jsonify(response)

if __name__ == '__main__':
    app.run(debug=True)
