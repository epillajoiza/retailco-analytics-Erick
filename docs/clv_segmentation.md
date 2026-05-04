# Segmentación CLV (Customer Lifetime Value)

Para sacar el `value_segment` en `mart_customer_lifetime_value`, decidí usar la función `NTILE(3)` sobre el revenue neto del cliente, en lugar de poner valores estáticos a mano (onda > $1000).

**Por qué hice esto:**
Al usar `NTILE(3)`, dbt divide a los clientes en tres grupos exactamente iguales basados en la distribución real de los datos:
- **Alto (1):** El top 33% de los que más gastan.
- **Medio (2):** El 33% del medio.
- **Bajo (3):** El 33% de los que menos gastan.

De esta forma los umbrales se ajustan solos si mañana entran más datos o si cambiamos la cantidad de registros en Snowflake.