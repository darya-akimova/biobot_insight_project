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
* products/notebook_1_city_health_dash_500_cities_opioid_corr.pdf - pdf download of notebook


##### Notebook 2: ma_overdose_deaths_by_town_cleanup_and_explore

**Filename:**

`code/cleaning_and_eda/notebook_2_ma_overdose_deaths_by_town_cleanup_and_explore.ipynb`

**Goals/Accomplishments:**

* Explored and small changes to the opioid overdose death count datasets (changed columns, removed rows relating to outside of MA deaths or location unknown counts)
* Compared opioid overdose death count Table 1 (deaths binned by location of residence of decedent, MA residents only) and Table 2 (deaths binned by location of death occurence)
* Plots of the death count disributions, correlation between years


**Inputs:**

MA opioid overdose death counts by town/city derived from Mass.gov statistics, available as a pdf
(Opioid-related-Overdose-Deaths-by-City-Town-August-2019.pdf)
Original source: https://www.mass.gov/lists/current-opioid-statistics

Table 1 (deaths binned by location of residence of decedent, MA residents only)
* Local Path: `data/raw_data/raw_data/ma_opioid_overdose_death_counts/ma_overdose_death_by_town_2014_2018_table1.csv`

Table 2 (deaths binned by location of death occurence)
* Local Path: `data/raw_data/raw_data/ma_opioid_overdose_death_counts/ma_overdose_death_by_town_2014_2018_table2.csv`

**Outputs:**

* Opioid overdose deaths by MA town/city Table 1: /data/tidy_data/ma_town_opioid_overdose_death_by_place_of_resid_2014_to_2018.csv
* Opioid overdose deaths by MA town/city Table 2: /data/tidy_data/ma_town_opioid_overdose_death_by_place_of_death_2014_to_2018.csv
* pdf notebook report: products/notebook_2_ma_overdose_deaths_by_town_cleanup_and_explore.pdf


### Modeling

##### gam_modeling

**Filename:**

`code/analysis/R_model/gam_modeling.rmd`

**Goals/Accomplishments:**



**Inputs:**



**Outputs:**



### Results

* [Blog post](https://medium.com/@dvakimova/predicting-and-contextualizing-opioid-overdose-deaths-across-massachusetts-b1bc59e43db8) discussing this work
* [Demo Slides](https://www.slideshare.net/DaryaAkimova/insight-week-4-demo-179121957) used to present this project
