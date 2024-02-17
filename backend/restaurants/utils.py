import pickle
import warnings

warnings.filterwarnings("ignore", category=UserWarning)

with open("models/model.pkl", "rb") as f:
    regr = pickle.load(f)

with open("models/encoder.pkl", "rb") as f:
    enc = pickle.load(f)

recipes = {
    'Meals': [
        {'name': 'Rice', 'quantity': 0.2},
        {'name': 'Sambar', 'quantity': 0.2},
        {'name': 'Rasam', 'quantity': 0.2},
        {'name': 'Curd', 'quantity': 0.2},
        {'name': 'Pickle', 'quantity': 0.05}
    ],
    'Masala Dosa': [
        {'name': 'Dosa batter', 'quantity': 0.2},
        {'name': 'Potato masala', 'quantity': 0.2},
        {'name': 'Chutney', 'quantity': 0.1},
        {'name': 'Sambar', 'quantity': 0.2}
    ],
    'Uzhunnu Vada': [
        {'name': 'Urad dal', 'quantity': 0.2},
        {'name': 'Onion', 'quantity': 0.1},
        {'name': 'Green chillies', 'quantity': 0.05},
        {'name': 'Curry leaves', 'quantity': 0.02},
        {'name': 'Salt', 'quantity': 'to taste'}
    ],
    'Puri Masala': [
        {'name': 'Wheat flour', 'quantity': 0.4},
        {'name': 'Potatoes', 'quantity': 0.3},
        {'name': 'Spices', 'quantity': 'as needed'},
        {'name': 'Oil', 'quantity': 'for frying'}
    ],
    'Biriyani': [
        {'name': 'Basmati rice', 'quantity': 0.2},
        {'name': 'Chicken or vegetables', 'quantity': 0.1},
        {'name': 'Spices', 'quantity': 'as needed'},
        {'name': 'Yogurt', 'quantity': 0.05}
    ],
    'Parippu Vada': [
        {'name': 'Toor dal', 'quantity': 0.2},
        {'name': 'Chana dal', 'quantity': 0.1},
        {'name': 'Onion', 'quantity': 0.1},
        {'name': 'Green chillies', 'quantity': 0.05},
        {'name': 'Curry leaves', 'quantity': 0.02},
        {'name': 'Salt', 'quantity': 'to taste'}
    ],
    'Puttum Kadala': [
        {'name': 'Puttu powder', 'quantity': 0.2},
        {'name': 'Chana curry', 'quantity': 0.2}
    ]
}


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
    assert day in ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday',
                   'Sunday'], "day must be one of 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'"
    assert food_item in ['Meals', 'Masala Dosa', 'Uzhunnu Vada', 'Puri Masala', 'Biriyani', 'Parippu Vada',
                         'Puttum Kadala'], "food_item must be one of Meals, Masala Dosa, Uzhunnu Vada, Puri Masala, Biriyani, Parippu Vada, Puttum Kadala"

    categorical_values = enc.transform([[day, food_item, events, festival]])
    n_customers = regr.predict([[categorical_values[0][0], categorical_values[0][1], categorical_values[0][2],
                                 event_size, categorical_values[0][3]]])

    total_food_items = 7  # Assuming 7 different food items
    normalized_customers = round(event_size / total_food_items + (n_customers[
        0]))
    return normalized_customers
