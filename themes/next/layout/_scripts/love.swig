{%
  set love_scripts = [
    'src/love.js'
  ]
%}

{% for bs in love_scripts %}
  <script type="text/javascript" src="{{ url_for(theme.js) }}/{{ bs }}?v={{ version }}"></script>
{% endfor %}