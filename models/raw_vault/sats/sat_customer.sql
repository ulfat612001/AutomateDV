{%- set source_model = "v_stg_customer" -%}
{%- set src_pk = "CUSTOMER_PK" -%}
{%- set src_hashdiff = "CUSTOMER_HASHDIFF" -%}
{%- set src_payload = ["CUSTOMER_NAME", "CUSTOMER_ADDRESS", "CUSTOMER_PHONE",
                       "CUSTOMER_ACCTBAL", "CUSTOMER_MKTSEGMENT", "CUSTOMER_COMMENT","CUSTOMER_NATION_KEY","CUSTOMER_NATION_NAME","CUSTOMER_REGION_NAME"] -%}
{%- set src_eff = "EFFECTIVE_FROM" -%}
{%- set src_ldts = "LOAD_DATE" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.sat(src_pk=src_pk, src_hashdiff=src_hashdiff,
                   src_payload=src_payload, src_eff=src_eff,
                   src_ldts=src_ldts, src_source=src_source,
                   source_model=source_model) }}
