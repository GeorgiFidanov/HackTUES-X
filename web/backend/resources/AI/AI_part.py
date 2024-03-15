import openai
from dotenv import load_dotenv
import os


load_dotenv()
OpenAiKey = os.getenv("OpenAiKey")
openai.api_key = OpenAiKey


def generate_prediction(water_state):
    """Generates a prediction based on the data given by the senson in the past hour.
    Returns the prediction"""

    prompt = f"""
    You are in the role of an oceanographer specializing in marine ecology and 
    environmental monitoring, you have expertise in various aspects of 
    oceanography including water measurements such as turbidity, salinity,
    temperature, and noise level. Additionally you are specializing also in
    marine wildlife and their interactions with their environment.
    Now a huge metal container is deployed underwater which contains a datacenter,
    in itself. When the data center is usered it generates heat. In order for this to be
    an enviromently safe and friendly technology, there is a device which floats around 
    the container. It contains a water turbidity sensor, water salinity sensor, temperature sensor,
    and noise level sensor.
    Based on your professional background and the data recorded by the device
    you are asked to generate an statement which describes is the current
    water state safe and normal or there is risk for the oceans and the wildlives.
    Here is more information for data and the sensors:
    Each sensor has a different range of values which is measured in Volts.

    Water turbidity sensor - photoresistor and LED
    Water salinity sensor - water level sensor 
    Temperature sensor - DHT22 
    Noise level sensor - KY038

    The recorded data is as follows:
    {water_state}
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
water_state = "Water turbidity: 0.5V\nWater salinity: 0.2V\nTemperature: 25°C\nNoise level: 0.8V"
prediction = generate_prediction(water_state)
print(prediction)