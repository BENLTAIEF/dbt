{% macro learn_logging() %}
  {{ log("Hello world", info=True) }}
{% endmacro %}