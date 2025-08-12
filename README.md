# Yelp Reviews Sentiment and Data Analysis

A robust, end-to-end data analytics pipeline for large-scale sentiment and business intelligence analysis on Yelp’s open dataset. This project extracts, processes, and analyzes millions of Yelp reviews and business records using Python, AWS S3, and Snowflake—leveraging SQL and custom sentiment analysis within a cloud-based analytics environment.

Link to download the dataset: https://business.yelp.com/data/resources/open-dataset/

***

## 🚀 Project Overview

This project demonstrates the full analytics lifecycle: from ingesting raw Yelp JSON data (5GB+, 7M+ reviews), transforming and uploading to cloud storage, flattening and ingesting into Snowflake, enriching via sentiment analysis (TextBlob), and enabling rich business insights using advanced SQL queries.

***

## 🖼️ Visual Architecture

```
End to end data analytics project
Yelp reviews sentimental and data analysis

+--------------+      +---------+      +-----------+     +-------------------+      +-------------------+     +-------------------+
|    Yelp      |      | Python  |      | Amazon S3 |     | Snowflake Flatten |      | Sentiment         |     | Data Analysis     |
|   Reviews    | ---> | Program | ---> |  (JSONs)  | --> |     & Ingest      | -->  | UDF (TextBlob)    | --> | using SQL         |
| (7M reviews) |      |         |      |           |     |  (JSONs to table) |      |                   |     |                   |
+--------------+      +---------+      +-----------+     +-------------------+      +-------------------+     +-------------------+
                                          ^
                                          |
                             +----------------------------+
                             | Yelp Businesses            |
                             +----------------------------+
```

***

## ⚙️ Installation

### Prerequisites

- **Python 3.7+ and required Python library**
- **AWS CLI** (configured with valid credentials)
- **Snowflake account**
- **Download the dataset** (https://business.yelp.com/data/resources/open-dataset/)

## 📝 Usage Guide

1. **Split Large JSON Files**
    - Run the provided Python script to split massive review files into manageable chunks:
        ```sh
        python split.py
        ```

2. **Stage & Load Data in Snowflake**
    - Use the `busi_tbl_create.sql` and `review_tbl_create.sql` scripts to create tables and load data from S3.

3. **Create Sentiment Analysis UDF**
    - Deploy the custom Python UDF from `sentiment_gen_UDF.sql` to classify review sentiments within Snowflake.

4. **Run Business & Sentiment Analysis**
    - Utilize the queries in `SQL_queries.sql` to extract business intelligence, user activity, popular categories, and rich sentiment insights.

***

## ✨ Features

- **Handles Big Data:** Efficiently processes millions of reviews (5GB+) and business records (100MB+).
- **Python-based Preprocessing:** Splits massive JSONs for cloud upload and database ingestion.
- **Cloud Storage:** Scalable storage and access using Amazon S3.
- **Modern Data Warehouse:** Structured processing and flattening of JSON data in Snowflake.
- **Integrated Sentiment Analysis:** Uses custom Python UDF with TextBlob for real-time sentiment tagging.
- **Rich Analytics Interface:** Execute powerful SQL queries for business insights, trends, and user behavior.
- **Reproducible Pipeline:** Modular scripts and configurations for end-to-end automation.

***

## 🤝 Contributing

Contributions are welcome! Please open an issue or submit a pull request for improvements, bug fixes, or new features.

**How to Contribute:**
1. Fork the repository.
2. Create a feature branch (`git checkout -b feature/your-feature`).
3. Commit your changes (`git commit -am 'Add new feature'`).
4. Push to your branch and open a Pull Request.

***

## 📄 License

This project is provided for **academic and educational use only** per the [Yelp Dataset Terms of Use](https://www.yelp.com/dataset).  
Do **not** use for commercial purposes or public redistribution of the dataset.

***

**Contact:** Please refer to the repository issues for questions, or consult the project contributors for further information.

