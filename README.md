# Predicting and contextualizing city-level opioid overdose deaths across Massachusetts
#### An Insight Boston Fall 2019 consultation project with [Biobot Analytics](https://www.biobot.io/)

### Goals

I am an [Insight Health Data Science](https://www.insighthealthdata.com/) Fellow from the Boston, MA Fall 2019 and this was my project.

The project was proposed to Insight by Biobot Analytics with the goal of:

* Developing a strategy for merging geospatial data at different resolutions
* Exploring publicly available opioid and non-opioid related datasets and their usefulness in understanding the opioid crisis


### Dependencies

#### Python 

**Use:** Data preprocessing, EDA

* numpy
* pandas
* matplotlib
* seaborn
* goepandas
* folium (not crucial to main project)


#### R 

**Use:** Modeling, Figure generation

* tidyverse
* mgcv
* sf


### Data

#### Raw Data:

##### **City Health dashboard data at city-level**

**Source:** [City Health Dashboard](https://www.cityhealthdashboard.com/)

https://www.cityhealthdashboard.com/data-access

**Data Acquired:** 9/15/2019

**Local Path:** `data/raw_data/500_cities_data/CHDB_data_city_all v7_0.csv`

**Fields:**

Full data codebook was included along with the datasets as part of the download, but particular fields utilized for this analysis were:


Name        |  Content
------------|----------
state_abbr  | State abbreviation
city_name   | City name
metric_name | Metric name (text - specific socioeconomic or health metric)
group_name  | Demographic group
est         | Estimate (-999 = not applicable, blank = censored or unavailable)

**Use:** 

### Data cleaning and feature engineering

##### Notebook 1: city_health_dash_500_cities_opioid_corr

**Filename:**

`code/analysis/python_notebooks/notebook_1_city_health_dash_500_cities_opioid_corr.ipynb`

**Goals/Accomplishments:**

* Explored 500 cities dashboard data to identify potential socioeconomic and health metrics that may be associated with opioid overdose deaths using spearman correlation
* Generated plot of correlations

**Inputs:**

City Health dashboard data at city-level:

* Original Source: https://www.cityhealthdashboard.com/data-access
* Local Path: `data/raw_data/500_cities_data/CHDB_data_city_all v7_0.csv`

**Outputs:**

* data/tidy_data/500_cities_totpop_metric_pivot_table.csv
* figures/tidy_figures/500_cities_opioid_corr.png

### Modeling


### Results

* [Blog post](https://medium.com/@dvakimova/predicting-and-contextualizing-opioid-overdose-deaths-across-massachusetts-b1bc59e43db8) discussing this work
* [Demo Slides](https://www.slideshare.net/DaryaAkimova/insight-week-4-demo-179121957) used to present this project
