{%- set yaml_metadata -%}
source_model: 'raw_customer'
derived_columns:
  NATION_KEY: 'CUSTOMER_NATION_KEY'
  REGION_KEY: 'CUSTOMER_REGION_KEY'
  RECORD_SOURCE: '!CUSTOMERS SYSTEM'
hashed_columns:
  CUSTOMER_PK: 'CUSTOMERKEY'
  CUSTOMER_NATION_PK: 'CUSTOMER_NATION_KEY'
  CUSTOMER_REGION_PK: 'CUSTOMER_REGION_KEY'
  REGION_PK: 'CUSTOMER_REGION_KEY'
  NATION_PK: 'CUSTOMER_NATION_KEY'
  NATION_REGION_PK:
    - 'CUSTOMER_NATION_KEY'
    - 'CUSTOMER_REGION_KEY'
  LINK_CUSTOMER_NATION_PK:
    - 'CUSTOMERKEY'
    - 'CUSTOMER_NATION_KEY'
  CUSTOMER_HASHDIFF:
    is_hashdiff: true
    columns:
      - 'CUSTOMERKEY'
      - 'CUSTOMER_ACCTBAL'
      - 'CUSTOMER_ADDRESS'
      - 'CUSTOMER_PHONE'
      - 'CUSTOMER_COMMENT'
      - 'CUSTOMER_NAME'
      - 'CUSTOMER_NATION_KEY'
      - 'CUSTOMER_NATION_NAME'
      - 'CUSTOMER_REGION_KEY'
      - 'CUSTOMER_REGION_NAME'
  CUSTOMER_REGION_HASHDIFF:
    is_hashdiff: true
    columns:
      - 'CUSTOMER_REGION_KEY'
      - 'CUSTOMER_REGION_NAME'
  CUSTOMER_NATION_HASHDIFF:
    is_hashdiff: true
    columns:
      - 'CUSTOMER_NATION_KEY'
      - 'CUSTOMER_NATION_NAME'
      - 'CUSTOMER_NATION_COMMENT'
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{% set source_model = metadata_dict['source_model'] %}

{% set derived_columns = metadata_dict['derived_columns'] %}

{% set hashed_columns = metadata_dict['hashed_columns'] %}

WITH staging AS (
{{ automate_dv.stage(include_source_columns=true,
                     source_model=source_model,
                     derived_columns=derived_columns,
                     hashed_columns=hashed_columns,
                     ranked_columns=none) }}
)

SELECT *,
       {{ var('load_date') }} AS LOAD_DATE,
       {{ var('load_date') }} AS EFFECTIVE_FROM
FROM staging
