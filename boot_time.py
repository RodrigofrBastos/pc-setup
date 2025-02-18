import psutil
from datetime import datetime
import requests


def get_boot_time():
    """Get the boot time of the system in seconds since the epoch."""
    boot_time_timestamp = psutil.boot_time()
    boot_time = datetime.fromtimestamp(boot_time_timestamp)
    return boot_time

def get_location():
    try:
        response = requests.get("https://ipinfo.io")
        location_data = response.json()
        location = location_data['city'] + ", " + location_data['region'] + ", " + location_data['country']
        return location
    except Exception as e:
        return f"Error getting location: {e}"


if __name__ == "__main__":
    boot_time = get_boot_time()
    location = get_location()
    print(boot_time)
    print(location)