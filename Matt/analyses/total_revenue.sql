with payments as 
(select * from {{ref('stg_stripe__payment')}})




select sum(payment_amount) from payments
group by all