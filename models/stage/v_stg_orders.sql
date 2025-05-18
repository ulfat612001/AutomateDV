{%- set yaml_metadata -%}
source_model: 'raw_order'
derived_columns:
  RECORD_SOURCE: '!ORDERS SYSTEM'
hashed_columns:
  ORDER_PK: 'ORDERKEY'
  CUSTOMER_PK: 'CUSTKEY'
  CUSTOMER_ORDER_PK: 
    - 'ORDERKEY'
    - 'CUSTKEY'
  ORDER_HASHDIFF:
    is_hashdiff: true
    columns:
      - 'ORDERKEY'
      - 'CUSTKEY'
      - 'ORDERSTATUS'
      - 'TOTALPRICE'
      - 'ORDERDATE'
      - 'ORDERPRIORITY'
      - 'CLERK'
      - 'SHIPPRIORITY'
      - 'COMMENT'
      - 'ORDERPRIORITYBUCKET'
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