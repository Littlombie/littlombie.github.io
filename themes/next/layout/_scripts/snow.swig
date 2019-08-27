{%
  set snow_scripts = [
    'src/snow.js'
  ]
%}

{% for bs in snow_scripts %}
  <script type="text/javascript" src="{{ url_for(theme.js) }}/{{ bs }}?v={{ version }}"></script>
{% endfor %}