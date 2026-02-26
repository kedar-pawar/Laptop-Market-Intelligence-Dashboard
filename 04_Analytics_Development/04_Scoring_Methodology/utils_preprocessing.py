import pandas as pd

def preprocess(df):

    cpu_mapping = {
        "Entry": 1,
        "Lower-Mid": 2,
        "Mid": 3,
        "Upper-Mid": 4,
        "High": 5
    }

    df["cpu_tier"] = df["cpu_tier"].map(cpu_mapping)
    df["is_touchscreen"] = df["is_touchscreen"].map({"Yes":1, "No":0})


    return df
