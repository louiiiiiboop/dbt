{% for j in range(20) %}
    select {{ j }} as number 
        {% if not loop.last %} 
            union all 
        {% endif %}
{% endfor %}