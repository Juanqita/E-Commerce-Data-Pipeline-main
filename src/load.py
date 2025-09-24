from typing import Dict
from pandas import DataFrame
from sqlalchemy.engine.base import Engine


def load(data_frames: Dict[str, DataFrame], database: Engine):
    for table_name, df in data_frames.items():
        with database.connect() as conn:
            df.to_sql(
            table_name,
            con=conn,
            if_exists="replace",
            index=False
    )
            

