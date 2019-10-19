# Predicting and contextualizing city-level opioid overdose deaths across Massachusetts
#### An Insight Boston Fall 2019 consultation project with [Biobot Analytics](https://www.biobot.io/)

## Goals

I am an [Insight Health Data Science](https://www.insighthealthdata.com/) Fellow in the Boston, MA Fall 2019 cohort and this was my project.

The project was proposed to Insight by Biobot Analytics with the goal of:

* Developing a strategy for merging geospatial data at different resolutions
* Exploring publicly available opioid and non-opioid related datasets and their usefulness in understanding the opioid crisis


## Dependencies

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


## Data

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


## Notebooks

### Data cleaning and feature engineering

#### Notebook 1: city_health_dash_500_cities_opioid_corr

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

Subsett of the city  health dashboard dataset: city-level, general population only:

* Local path: data/tidy_data/500_cities_totpop_metric_pivot_table.csv
* Used to create plot below

Plot of spearman correlation coefficients between city-level opioid overdose deaths and all other metrics (500 cities, app. 1 year worth of data)

* Local path: `figures/tidy_figures/500_cities_opioid_corr.png`

pdf download of notebook (in case notebook won't run)

* Local path: `products/notebook_1_city_health_dash_500_cities_opioid_corr.pdf`



#### Notebook 2: ma_overdose_deaths_by_town_cleanup_and_explore

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

* Local Path: `data/raw_data/ma_opioid_overdose_death_counts/ma_overdose_death_by_town_2014_2018_table1.csv`

Table 2 (deaths binned by location of death occurence)

* Local Path: `data/raw_data/ma_opioid_overdose_death_counts/ma_overdose_death_by_town_2014_2018_table2.csv`


**Outputs:**

Opioid overdose deaths by MA town/city Table 1

* Local path: `data/tidy_data/ma_town_opioid_overdose_death_by_place_of_resid_2014_to_2018.csv`

Opioid overdose deaths by MA town/city Table 2

* Local path: `data/tidy_data/ma_town_opioid_overdose_death_by_place_of_death_2014_to_2018.csv`
* Used in: `code/cleaning_and_eda/notebook_3_ma_census_block_and_town_match.ipynb`

pdf notebook report (in case notebook won't run)

* Local path: `products/notebook_2_ma_overdose_deaths_by_town_cleanup_and_explore.pdf`



#### Notebook 3: ma_overdose_deaths_by_town_cleanup_and_explore

**Filename:**

`code/cleaning_and_eda/notebook_3_ma_census_block_and_town_match.ipynb`

**Goals/Accomplishments:**

* Derived latitude and longitude of the centroid of each of the 351 towns/municipalities in the MA opioid overdose dataset to use as the geospatial component when building a model.
* Joined towns (351 towns/cities in the MA opioid overdose dataset) and 2010 census blocks to pull in the American Community Survey demographics data and use it as predictors of opioid overdose deaths per year per town.
* Explored the merge error by comparing the 2010 population counts from the town survey shapefile and the sum after merge of the 2010 population counts from the census block shapefile 


**Inputs:**

Opioid overdose deaths per MA town/city, grouped by place of death occurence - used to compare to MA town survey shapefile to determine if towns match up.

* Local path: `data/tidy_data/ma_town_opioid_overdose_death_by_place_of_death_2014_to_2018.csv`
* created in notebook #2

MA town survey shapefile

* Local path: `data/raw_data/shapefiles_and_geography_related/townssurvey_shp/TOWNSSURVEY_POLYM.shp`
* Original source: https://docs.digital.mass.gov/dataset/massgis-data-community-boundaries-towns-survey-points

2010 Census Block shapefile - used to merge towns/cities with the census blocks within them:

* Local path: `data/raw_data/shapefiles_and_geography_related/CENSUS2010_BLK_BG_TRCT_SHP/CENSUS2010BLOCKGROUPS_POLY.shp`
* Original source: https://docs.digital.mass.gov/dataset/massgis-data-datalayers-2010-us-census


**Outputs:**

MA tows with centroid x/y points for modeling

* Local path: `data/tidy_data/ma_town_crs4326_coords.csv` 
* Used in: `code/analysis/R_model/gam_modeling.rmd`

Association of MA towns with 2010 census blocks (for ACS data merge) 

* Local path: `data/tidy_data/census_block_town_match.csv` 
* Not perfect, some errors (see notebook for analysis), but will go with this because a perfect match may take too much time

pdf notebook report (in case notebook won't run)

* Local path: `products/notebook_3_ma_census_block_and_town_match.pdf`


### Modeling

#### gam_modeling

**Filename:**

`code/analysis/R_model/gam_modeling.rmd`

**Goals/Accomplishments:**



**Inputs:**



**Outputs:**



## Results

* [Blog post](https://medium.com/@dvakimova/predicting-and-contextualizing-opioid-overdose-deaths-across-massachusetts-b1bc59e43db8) discussing this work
* [Demo Slides](https://www.slideshare.net/DaryaAkimova/insight-week-4-demo-179338716) used to present this project
