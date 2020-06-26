from pandas import read_csv, DataFrame


def load_iris_data() -> DataFrame:
    """Load iris data and return pandas.DataFrame"""
    return read_csv(
        'https://raw.githubusercontent.com/mwaskom/seaborn-data/master/iris.csv'
    )
