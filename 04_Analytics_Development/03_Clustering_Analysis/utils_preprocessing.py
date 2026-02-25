import pandas as pd
def preprocess_laptop_features(df: pd.DataFrame) -> pd.DataFrame:
    """
    Performs core feature engineering required for clustering/regression.

    Transformations:
    - Converts cpu_tier to ordered numeric scale
    - Converts is_touchscreen to binary (0/1)
    - Ensures ssd_gb is binary
    - Creates cpu_tier_numeric column

    Returns:
        Transformed dataframe copy
    """

    df = df.copy()

    tier_map = {
        "Entry": 1,
        "Lower-Mid": 2,
        "Mid": 3,
        "Upper-Mid": 4,
        "High": 5
    }

    if "cpu_tier" in df.columns:
        df["cpu_tier_numeric"] = df["cpu_tier"].map(tier_map)


    if "is_touchscreen" in df.columns:
        df["is_touchscreen"] = df["is_touchscreen"].map({"No": 0, "Yes": 1})


    if "ssd_gb" in df.columns:
        df["ssd_indicator"] = df["ssd_gb"].apply(lambda x: 1 if x > 0 else 0)

    return df
    

#  Hardware-Based Feature Set
def get_hardware_features(df: pd.DataFrame) -> pd.DataFrame:
    """
    Returns feature set for hardware-based clustering.
    Excludes price to avoid pricing bias.
    """

    features = [
        "ram_gb",
        "total_storage_gb",
        "cpu_tier_numeric",
        "clock_speed_ghz",
        "screen_size_inch",
        "weight_kg",
        "is_touchscreen",
        "ssd_indicator"
    ]

    return df[features]


#  Market-Based Feature Set
def get_market_features(df: pd.DataFrame) -> pd.DataFrame:
    """
    Returns feature set for market-based clustering.
    Includes price for positioning analysis.
    """

    features = [
        "ram_gb",
        "total_storage_gb",
        "cpu_tier_numeric",
        "clock_speed_ghz",
        "screen_size_inch",
        "weight_kg",
        "is_touchscreen",
        "ssd_indicator",
        "Price"
    ]

    return df[features]