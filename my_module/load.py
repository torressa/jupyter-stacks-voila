from pandas import read_csv, DataFrame


def load_iris_data(path: str = '/home/jovyan/work/data/test.csv') -> DataFrame:
    """Load iris data and return pandas.DataFrame"""
    return read_csv(path)
