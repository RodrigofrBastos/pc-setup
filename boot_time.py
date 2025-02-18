import psutil
from datetime import datetime, timedelta
import requests
from openpyxl import Workbook, load_workbook


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

def set_data_xlsx(time, location):
    try:
        try:
            wb = load_workbook('horario_de_chegada.xlsx')
            sheet = wb.active
            # Format the boot time into separate parts
            day_month_year = boot_time.strftime("%d/%m/%Y")
            hour_minute = boot_time.strftime("%H:%M")
            
            # Add the fixed times
            time_lunch = "12:00"
            time_ret_lunch = "13:00"
            
            # Add 7 hours to the boot time
            seven_hours_later = boot_time + timedelta(hours=7)
            seven_hour_minute = seven_hours_later.strftime("%H:%M")
            
            # Append the data to the next row
            sheet.append([day_month_year, hour_minute, time_lunch, time_ret_lunch, seven_hour_minute, location])
            
        except FileNotFoundError:
            wb = Workbook
            sheet = wb.active
            sheet.append(['Data','Entrada','Saída (Alomoço)','Retorno (Almoço)','Saída','Localização'])
            return "Could not access file"
        
        wb.save('horario_de_chegada.xlsx')
        print("save")
    except Exception as e:
        return f"Error writing to Excel: {e}"
    
if __name__ == "__main__":
    boot_time = get_boot_time()
    location = get_location()
    set_data_xlsx(boot_time, location)