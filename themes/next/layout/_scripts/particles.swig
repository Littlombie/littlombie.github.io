{%
  set particles_scripts = [
    'src/ccc.js'
  ]
%}

{% for bs in particles_scripts %}
  <script type="text/javascript" src="{{ url_for(theme.js) }}/{{ bs }}?v={{ version }}"></script>
{% endfor %}