# Predicting and contextualizing city-level opioid overdose deaths across Massachusetts
#### An Insight Boston Fall 2019 consultation project with [Biobot Analytics](https://www.biobot.io/)

<br>

# Goals

I am an [Insight Health Data Science](https://www.insighthealthdata.com/) Fellow in the Boston, MA Fall 2019 cohort and this was my project.

The project was proposed to Insight by Biobot Analytics with the goal of:

* Developing a strategy for merging geospatial data at different resolutions
* Exploring publicly available opioid and non-opioid related datasets and their usefulness in understanding the opioid crisis

<br>

# Results

* [Blog post](https://medium.com/@dvakimova/predicting-and-contextualizing-opioid-overdose-deaths-across-massachusetts-b1bc59e43db8) discussing this work
* [Demo Slides](https://www.slideshare.net/DaryaAkimova/insight-week-4-demo-with-model-update) used to present this project

<br>

# Dependencies

### Python 

**Use:** Data preprocessing, EDA

* numpy
* pandas
* matplotlib
* seaborn
* goepandas


### R 

**Use:** Modeling, Figure generation

* tidyverse
* mgcv
* sf
* mgcViz

<br>

# Data


The raw datasets utilized in this project were to large to share on GitHub. The sources of each dataset can be found in the data/data_tracking.xlsx file.


<br>

# Notebooks

## Data cleaning and feature engineering

### Notebook 1: City health dashboard 500 cities opioid overdose deaths correlation EDA

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


<br>

### Notebook 2: Notebook to prep and explore the target MA yearly opioid overdose deaths table data

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


<br>

### Notebook 3: MA cencus block and town join, basic geospatial EDA

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
* Used in: `code/cleaning_and_eda/notebook_4_overdose_death_and_acs_by_census_block_merge_and_eda.ipynb`

Error on actual vs. estimated 2010 population counts after census block - town merge

* Local path: `data/tidy_data/census_block_town_match_2010pop_error.csv`
* In case need to refer to population estimate errors again
* Used in: `code/cleaning_and_eda/notebook_4_overdose_death_and_acs_by_census_block_merge_and_eda.ipynb`

pdf notebook report (in case notebook won't run)

* Local path: `products/notebook_3_ma_census_block_and_town_match.pdf`


<br>

### Notebook 4: Opioid overdose deaths and ACS dataset merge and EDA

**Filename:**

`code/cleaning_and_eda/notebook_4_overdose_death_and_acs_by_census_block_merge_and_eda.ipynb`

**Goals/Accomplishments:**
* Tried normalizing death count data to town population (turn raw counts into deaths per 10k residents values) - decided not to model the data this way - instead model the raw counts (can use the distributions meant for count data that can be very skewed)
* Pulled out some ACS demographics data and performed some EDA, feature engineering


**Inputs:**

Opioid overdose deaths per MA town/city, grouped by place of death occurence - used to compare to MA town survey shapefile to determine if towns match up.

* Local path: `data/tidy_data/ma_town_opioid_overdose_death_by_place_of_death_2014_to_2018.csv`
* created in notebook #2

Association of MA towns with 2010 census blocks (for ACS data merge) 

* Local path: `data/tidy_data/census_block_town_match.csv` 
* created in notebook #3

Error on actual vs. estimated 2010 population counts after census block - town merge

* Local path: `data/tidy_data/census_block_town_match_2010pop_error.csv`
* In case need to refer to population estimate errors again
* created in notebook #3

Census block-level 2017 American Community Survey data

* Local path: `data/raw_data/american_community_survey/R12288202_SL150.csv`
* Source: Biobot


**Outputs:**

Opioid overdose death count (by town for years 2014-2018) merged with ACS demogrpahics data

* Local path: `data/tidy_data/overdose_death_count_acs_merge.csv`

pdf output in case notebook doesn't run:

* Local path: `products/notebook_4_overdose_death_and_acs_by_census_block_merge_and_eda.pdf`


<br>

### Notebook 5: Medicare opioid and non-opioid prescriber datasets cleanup and town join

**Filename:**

`code/cleaning_and_eda/notebook_5_medicare_opioid_and_nonopioid_prescriber_cleanup_and_town_join.ipynb`


**Goals/Accomplishments:**

* Clean up/edit the opioid prescriber and all-drug prescriber Medicare Part D datsets (remove columns, tidy text, etc) 
* Associated the opioid prescribers with a town in the MA opioid overdose deaths dataset via zip code (using a Mass.gov shapefile with the correct set of town names)
* Associated the all-drugs prescribers with a town in the MA opioid overdose death count dataset (sidebar - this dataset came with a town column, but the town names did not match up well with the opioid overdose death count towns - see notebook for details). Strategy for association was to merge the all-drug prescribers with the opioid prescribers based on NPI (unique prescriber identifier) to associate the all-drug prescribers with a zip code. Then associated the all-drug prescribers with a town based on that zip code (from previous step, where the opioid prescribers were associated with a town)
* Extracted benzodiazepine prescription counts (not pretty, but the all-drug prescriber datasets for each year are big). These are rich datasets, worth exploring more for future directions.


**Inputs:**

Medicare Part D opioid prescription summary datasets - by prescriber - one dataset for each year for the years 2013-2017

Local paths:

* 2013: `data/raw_data/medicare_prescription_opioids/Medicare_Part_D_Opioid_Prescriber_Summary_File_2013.csv`
* 2014: `data/raw_data/medicare_prescription_opioids/Medicare_Part_D_Opioid_Prescriber_Summary_File_2014.csv`
* 2015: `data/raw_data/medicare_prescription_opioids/Medicare_Part_D_Opioid_Prescriber_Summary_File_2015.csv`
* 2016: `data/raw_data/medicare_prescription_opioids/Medicare_Part_D_Opioid_Prescriber_Summary_File_2016.csv`
* 2017: `data/raw_data/medicare_prescription_opioids/Medicare_Part_D_Opioid_Prescriber_Summary_File_2017.csv`


Medicare Part D all-drug prescription datasets - by prescriber - one dataset for each year for the years 2013-2017

Local paths:

* 2013: `data/raw_data/medicare_prescription_all_drugs/PartD_Prescriber_PUF_NPI_Drug_13.txt`
* 2014: `data/raw_data/medicare_prescription_all_drugs/PartD_Prescriber_PUF_NPI_Drug_14.txt`
* 2015: `data/raw_data/medicare_prescription_all_drugs/PartD_Prescriber_PUF_NPI_Drug_15.txt`
* 2016: `data/raw_data/medicare_prescription_all_drugs/PartD_Prescriber_PUF_NPI_Drug_16.txt`
* 2017: `data/raw_data/medicare_prescription_all_drugs/PartD_Prescriber_PUF_NPI_Drug_17.txt`

* Each of these files unzipped is 2.8 to 3GB of data 
* 2017 dataset loaded in at the start of the notebook to figure out how to best merge the medicare prescription datasets and the opioid overdose death count data, others are loaded in and processed later


Zip code - town assiation lists (copied from websites - need to add links):

Local paths

* `data/raw_data/shapefiles_and_geography_related/ma_town_zipcode_list.txt`
* `data/raw_data/shapefiles_and_geography_related/ma_town_zipcode_list_alt.txt`
* These were slightly useful

MA postal zip code shapefile with town associations

* Local path: `data/raw_data/shapefiles_and_geography_related/zipcodes_nt/ZIPCODES_NT_POLY.shp`
* Town names best match for the MA opioid overdose death count dataset
* Most matches came from this file

Opioid overdose death count data (by town and year) and ACS data merge:

* Local path: `data/tidy_data/overdose_death_count_acs_merge.csv`
* Output from notebook 4


Opioid prescriber dataset, with years 2013-2017 concatenated (rows stacked), duplicate town assignments to postal zip codes resolved:

* Local path: `data/tidy_data/medicare_partD_opioid_prescriber_all_years_no_ziptown_duplicates.csv`
* Created in notebook 6
* Used to assign benzodiazepine prescribers to a town (match by npi, year)


**Outputs:**

Inidividual prescribers by zip code, associated with town from opioid overdose death count dataset:

Local paths:

* 2013 dataset: `data/tidy_data/medicare_partD_opioid_prescriber_2013_w_zip_MAtown_v1.csv`
* 2014 dataset: `data/tidy_data/medicare_partD_opioid_prescriber_2014_w_zip_MAtown_v1.csv`
* 2015 dataset: `data/tidy_data/medicare_partD_opioid_prescriber_2015_w_zip_MAtown_v1.csv`
* 2016 dataset: `data/tidy_data/medicare_partD_opioid_prescriber_2016_w_zip_MAtown_v1.csv`
* 2017 dataset: `data/tidy_data/medicare_partD_opioid_prescriber_2017_w_zip_MAtown_v1.csv`
* Used in notebook 6
* Some prescribers have multiple town associations per year (resolved -sort of- in notebook 6)


Benzodiazepine prescription data years 2013-2017, with each prescriber associated with MA opioid overdose death town

* Local path: `data/tidy_data/med_partD_benzo_indiv_pres_w_town_merge_13_to_17.csv`

Summarized benzodiazepine prescription data years 2013-2017, grouped by town (from opioid overdose death dataset), year, and drug (out of the 3 benzo drugs in the dataset, by geneeric name)

* Local path: `data/tidy_data/med_partD_benzo_sum_w_town_merge_13_to_17.csv`

pdf report - in case notebook doesn't run

* Local path: `products/notebook_5_medicare_opioid_and_nonopioid_prescriber_cleanup_and_town_join.pdf`


<br>

### Notebook 6: MA opioid overdose death, ACS, and Medicare part D data merge

**Filename:**

`code/analysis/python_notebooks/notebook_6_ma_opioid_overdose_death_and_acs_and_partD_drug_match_by_town.ipynb`

**Goals/Accomplishments:**

* Resolved NPI prescribers being assigned to more than one town (zip code matched to more than one town most likely) - issue from notebook 5
* Filled in missing opioid prescription counts (simple fill in based on codebook suggestion)
* Associated towns (opioid overdose death rates + acs) and medicare drug spending/claim counts
* EDA on potential relationship between opioid overdose deaths and opioid or benzo claims


**Inputs:**

Opioid overdose death count data (by town and year) and ACS data merge:

* Local path: `data/tidy_data/overdose_death_count_acs_merge.csv`
* Output from notebook 4

Inidividual prescribers by zip code, associated with town from opioid overdose death count dataset:

Local paths:

* 2013 dataset: `data/tidy_data/medicare_partD_opioid_prescriber_2013_w_zip_MAtown_v1.csv`
* 2014 dataset: `data/tidy_data/medicare_partD_opioid_prescriber_2014_w_zip_MAtown_v1.csv`
* 2015 dataset: `data/tidy_data/medicare_partD_opioid_prescriber_2015_w_zip_MAtown_v1.csv`
* 2016 dataset: `data/tidy_data/medicare_partD_opioid_prescriber_2016_w_zip_MAtown_v1.csv`
* 2017 dataset: `data/tidy_data/medicare_partD_opioid_prescriber_2017_w_zip_MAtown_v1.csv`
* Output from notebook 5


**Outputs:**

Opioid prescriber dataset, with years 2013-2017 concatenated (rows stacked), duplicate town assignments to postal zip codes resolved:

* Local path: `data/tidy_data/medicare_partD_opioid_prescriber_all_years_no_ziptown_duplicates.csv`
* Used back in notebook 5 to assing the benzodiazepine prescribers to a town (so that things match up)


Opioid overdose death count data and ACS data, transformed to a long format

* Local path: `data/tidy_data/overdose_death_count_acs_merge_long_format.csv`
* For plotting
* Major change is that the individual death count years and the individual total population columns have each been gathered into one for each variable
* Opioid overdose death column converted to "death count next year" column (year has been shifted down by 1) to match modeling strategy (feature data from year before predicts death count per town the following year)


Merged opioid overdose death count data, ACS, and Medicare opioid prescription rates (summarized):

* Local path: `data/tidy_data/acs_medicare_opioid_stats_death_count_merge.csv`
* 294 towns after this merge (towns removed because no opioid prescribers in them, according to Medicare)
* Used for modeling (notebook 7)

pdf output in case notebook doesn't run:

* `products/


<br>

## Modeling

### Notebook 7: GAM modeling in R

**Filename:**

`code/analysis/R_model/gam_modeling.rmd`

**Goals/Accomplishments:**

* Create GAM model that use created feature datasets (ACS, medicare prescription data)  to predict opioid overdose death counts per town per year


**Inputs:**

MA town centroid coordinates:

* Local path: `data/tidy_data/ma_town_crs4326_coords.csv`
* Created in notebook #3

Summarized benzodiazepine prescription data years 2013-2017, grouped by town (from opioid overdose death dataset), year, and drug (out of the 3 benzo drugs in the dataset, by geneeric name)

* Local path: `data/tidy_data/med_partD_benzo_sum_w_town_merge_13_to_17.csv`
* Created in notebook #5


Merged opioid overdose death count data, ACS, and Medicare opioid prescription rates (summarized):

* Local path: `data/tidy_data/acs_medicare_opioid_stats_death_count_merge.csv`
* Created in notebook #6


**Outputs:**

Concurvity figure (full model) for blog:

* Local path: `figures/tidy_figures/full_model_concurvity.png`



<br>


### Notebook 8: Figure generation in R

**Filename:**

`code/analysis/R_model/.rmd`

**Goals/Accomplishments:**



**Inputs:**



**Outputs:**


<br>

