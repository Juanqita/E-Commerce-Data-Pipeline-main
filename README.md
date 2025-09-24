# 🛒 E-Commerce Data Pipeline

Hi! this projectimplements a **data pipeline** for the Olist e-commerce dataset, including data extraction, loading into a SQLite database, SQL queries, and visualizations using Python (pandas, SQLAlchemy, matplotlib, plotly).

## 🚀 Project Structure
E-Commerce-Data-Pipeline-main/
│── src/ # Source code (extract, load, transform, plots)
│── queries/ # SQL queries
│── tests/ # Unit tests with pytest
│── data/ # Original and/or derived CSVs
│── requirements.txt # Dependencies
│── README.md # This file
│── .gitignore # Files ignored by Git


---

## ⚙️ Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/ecommerce-data-pipeline.git
cd ecommerce-data-pipeline

2. Create a virtual environment and install dependencies:
```bash
python -m venv venv
source venv/bin/activate   # Linux / Mac
venv\Scripts\activate      # Windows

pip install -r requirements.txt

## ▶️ Usage
1. Load the data and create the SQLite database:
from src.extract import extract
from src.load import load
from src.transform import run_queries
from src.config import ENGINE

# Extract CSVs and load them into the DB
csv_dataframes = extract("data", csv_table_mapping, public_holidays_url)
load(data_frames=csv_dataframes, database=ENGINE)

# Run queries
results = run_queries(database=ENGINE)

2. Visualize results (example):
from src.plots import plot_top_10_revenue_categories
df = results["top_10_revenue_categories"]
plot_top_10_revenue_categories(df)

##🧪 Testing

Run unit tests with:
pytest tests/

##📊 Main Dependencies
- Python 3.12
- pandas
- SQLAlchemy
- matplotlib
- plotly
- pytest

##✨ Author

Developed as part of an AnyoneAI academic sprint project.
Made by Juan Camilo Peláez Machado.
.
