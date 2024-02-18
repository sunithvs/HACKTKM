import pickle
import warnings

warnings.filterwarnings("ignore", category=UserWarning)
from .models import food_items, days
with open("models/model.pkl", "rb") as f:
    regr = pickle.load(f)

with open("models/encoder.pkl", "rb") as f:
    enc = pickle.load(f)



def predict_customers(day: str, food_item: str, events: bool, event_size: int, festival: bool):
    """
    Predicts the number of customers for a given day, food item, event, event size, and festival.
    Parameters:
    day (str): The day of the week. Must be one of 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'.
    food_item (str): The food item being served.
    events (bool): Whether there is an event on the day.
    event_size (int): The size of the event (number of people).
    festival (bool): Whether there is a festival on the day.
    Returns:
    int: The predicted number of customers.
    Raises:
    AssertionError: If the day is not one of 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'.
    AssertionError: If the food item is not one of Meals, Masala Dosa, Uzhunnu Vada, Puri Masala, Biriyani, Parippu Vada, Puttum Kadala.
    """
    assert day in days, "day must be one of 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'"
    assert food_item in food_items, "food_item must be one of Meals, Masala Dosa, Uzhunnu Vada, Puri Masala, Biriyani, Parippu Vada, Puttum Kadala"

    categorical_values = enc.transform([[day, food_item, events, festival]])
    n_customers = regr.predict([[categorical_values[0][0], categorical_values[0][1], categorical_values[0][2],
                                 event_size, categorical_values[0][3]]])

    total_food_items = len(food_items)
    normalized_customers = round(event_size / total_food_items + (n_customers[
        0]))
    return normalized_customers
