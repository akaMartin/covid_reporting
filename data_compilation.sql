/*/ Table Structure
select
  --state_name,
  --county_name,
  --date
  --covid_cases
  --vaccination_rate
  --prior covid infection rate
  --median_age
  --median_income
  --backelors degree percent
  --symptom searches week earlier
  --Mobility Data
/*/

select distinct
  cas.state_name,
  cen.area_name,
  infrequent_maskers,
  sum(confirmed_cases)
from (
  select distinct
    area_name,
    county_fips_code
  from `bigquery-public-data.census_utility.fips_codes_all` as cen
  where summary_level_name='state-county'
  ) as cen
join
  (
  select state_name,county_fips_code,confirmed_cases from `bigquery-public-data.covid19_nyt.us_counties`
  ) as cas
  on cas.county_fips_code=cen.county_fips_code
join
  (
  select county_fips_code,never+rarely as infrequent_maskers from `bigquery-public-data.covid19_nyt.mask_use_by_county`
  ) as msk
  on msk.county_fips_code=cen.county_fips_code
group by 1,2,3
/*/
select
  state_name,
  county,
from `bigquery-public-data.covid19_nyt.us_counties`
/*/
