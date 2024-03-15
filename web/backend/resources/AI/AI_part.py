import openai
from dotenv import load_dotenv
import os


load_dotenv()
OpenAiKey = os.getenv("OpenAiKey")
openai.api_key = OpenAiKey


def generate_prediction(water_state, location):
    """Generates a prediction based on the data given by the senson in the past hour.
    Returns the prediction"""

    prompt = f"""
    You are in the role of an oceanographer specializing in marine ecology and
    environmental monitoring. You have expertise in various aspects of
    oceanography including water measurements such as turbidity, salinity,
    temperature, and noise level. Additionally you are specializing also in
    marine wildlife and their interactions with their environment.
    Now a huge metal container is deployed underwater. It is located 40 meters from the coast
    and within 40 meters of depth. That container contains a datacenter,
    in itself. When the data center is used, it generates heat. In order for this to be
    an environmentally safe and friendly technology, there is a device which floats around 
    the container. It contains a water turbidity sensor, water salinity sensor, temperature sensor,
    and noise level sensor. The container is located at {location}
    Based on your professional background and the data recorded by the device
    you are asked to generate an statement which describes is the current
    water state safe and normal or there is risk for the oceans and the wildlife.
    Here is more information for data and the sensors:
    Each sensor has a different range of values which is measured in Volts.
    You'll need to convert the recorded data to a value which is measured in the specific unit.
    For reference the lowest value can be 0V and the highest value can be 3.3V

    Water turbidity sensor - photoresistor and LED
    Water salinity sensor - water level sensor 
    Temperature sensor - DHT22 
    Noise level sensor - KY038

    The recorded data is as follows:
    {water_state}

    At the end display the expected value for the location(display the location aswell)
    Then compare the input data to that expected data for that location (which is around 40 meters below surface).
    """
    try:
        # Generate the response
        response = openai.chat.completions.create(
            model="gpt-3.5-turbo",
            messages=[{"role": "system", "content": prompt}],
            temperature=0.2
        )
        # Extract the completion text
        
        statement = response.choices[0].message.content
        return statement
    except Exception as e:
        return f"An error occurred: {e}"

# Example usage:
    
data = [
  {
    "id": 1,
    "temperature": 2.5,
    "noise": 0.8,
    "salinity": 0.2,
    "murkiness": 0.5,
    "device_id": 1,
    "created_at": None,
    "updated_at": None
  },
  {
    "id": 2,
    "temperature": 2.8,
    "noise": 0.8,
    "salinity": 0.2,
    "murkiness": 0.5,
    "device_id": 1,
    "created_at": None,
    "updated_at": None
  },
    {
    "id": 3,
    "temperature": 2.6,
    "noise": 0.8,
    "salinity": 0.2,
    "murkiness": 0.5,
    "device_id": 1,
    "created_at": None,
    "updated_at": None
  },
    {
    "id": 4,
    "temperature": 3,
    "noise": 0.8,
    "salinity": 0.2,
    "murkiness": 0.5,
    "device_id": 1,
    "created_at": None,
    "updated_at": None
  },
    {
    "id": 5,
    "temperature": 2.9,
    "noise": 0.8,
    "salinity": 0.2,
    "murkiness": 0.5,
    "device_id": 1,
    "created_at": None,
    "updated_at": None
  },
    {
    "id": 6,
    "temperature": 3.3,
    "noise": 0,
    "salinity": 0.2,
    "murkiness": 0.5,
    "device_id": 1,
    "created_at": None,
    "updated_at": None
  }
]


location = "42.651333947569825, 23.354033461941654"
prediction = generate_prediction(data, location)
print(prediction)