import json
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
import time 

url = 'http://www.aiyads.com/zhujiang.html'
chrome_driver_path = 'chromedriver.exe'

chrome_options = Options()
chrome_options.add_argument('--headless')

caps = DesiredCapabilities.CHROME
caps['goog:loggingPrefs'] = {'performance': 'ALL'}

webdriver = webdriver.Chrome(
  executable_path=chrome_driver_path, options=chrome_options,desired_capabilities=caps
)

def process_browser_log_entry(entry):
    response = json.loads(entry['message'])['message']
    return response

with webdriver as driver:

    try:
        driver.get(url)
    except Exception as e:
        print(e)

    time.sleep(1)
    browser_log = driver.get_log('performance') 
    events = [process_browser_log_entry(entry) for entry in browser_log]
    events = [event for event in events if 'Network.responseReceived' in event['method'] and 'response' in event['params']] 
    events = [event for event in events if 'url' in event['params']['response']]
    events = [event for event in events if 'http://nclive.grtn.cn/zjpd/sd/live.m3u8?_upt=' in event['params']['response']['url']]
    print(events[0]['params']['response']['url'])
    # must close the driver after task finished
    driver.close()