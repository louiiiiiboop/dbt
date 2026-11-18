{# {%- set foods = ['radish','cucumber', 'chicken nugget' ,' avocado' ] -%}
{%- for food in foods -%}
   {%- if food == 'chicken nugget' -%}
        {%- set food_type='snack' -%}
    {%- else -%}
        {%- set food_type='vegtable'  -%}
   {%- endif -%} 
   The delecious {{food}} is my favour {{food_type}}

{% endfor %} #}

{#
{% set matts_dictionary = { 
    'word':'data',
    'part_of_speech':'noun',
    'definition': 'the building block of life'
    } %}

    {{matts_dictionary['word']}} ({{matts_dictionary['part_of_speech']}}): defined as {{matts_dictionary['definition']}}

#}
with payments as 

(select * 
    from {{- ref('stg_stripe__payment')-}}
where payment_status ='success'),

pivoted as
(
    select order_id,
    {%- set payment_methods=['bank_transfer','coupon','credit_card','gift_card','bitcoin' ] -%}

    {%- for payment_method in payment_methods -%}
      sum(case when '{{ payment_method }}'=payment_method then payment_amount else 0 end) as {{payment_method}}_amount {% if not loop.last %},{% endif %}
    {% endfor %}
    from payments
    group by 1
)

select * from pivoted


