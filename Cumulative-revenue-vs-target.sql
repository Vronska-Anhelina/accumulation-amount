   SELECT DISTINCT date,predict_sum_date,price_sum_date, price_sum_date/predict_sum_date*100 AS percent_price_from_predict
FROM(
SELECT date,SUM(predict_sum) OVER (ORDER BY date) AS predict_sum_date,SUM(price_sum) OVER (ORDER BY date) AS price_sum_date
FROM(
SELECT date,predict_sum,price_sum
FROM(
SELECT date, SUM(predict) AS predict_sum,0 AS price_sum
FROM `DA.revenue_predict`  rp
GROUP BY date
UNION ALL
SELECT ss.date,0 AS predict_sum,SUM(price) AS price_sum
FROM `DA.product` pr
JOIN `DA.order` o
ON pr.item_id=o.item_id
JOIN `DA.session` ss
ON o.ga_session_id=ss.ga_session_id
GROUP BY ss.date) sum_all) sum_from_date)percent;


