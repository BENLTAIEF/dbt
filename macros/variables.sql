{% macro learn_variables() %}
  {% set myname = "world" %}
  {{ log("Hello " ~ myname , info=True) }}
  {{ log("Hello dbt user " ~ var("user_name", "NO USER IS SET !!") ~ " !", info=True) }}
{% endmacro %}