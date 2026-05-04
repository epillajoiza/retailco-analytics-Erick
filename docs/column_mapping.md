# Mapeo de Columnas: Unificación de Ventas

Este documento explica cómo unimos las ventas de tienda física, catálogo y web en `int_unified_sales`.

### Ubicación (location_sk)
Cada origen tiene su propia columna para decir dónde se hizo la venta. Lo mapeamos a `location_sk` para usar un solo campo:
- Store Sales: `store_sk` -> `location_sk`
- Catalog Sales: `call_center_sk` -> `location_sk`
- Web Sales: `web_site_sk` -> `location_sk`

### Cliente (customer_sk)
En tienda solo hay `customer_sk`. Pero en catálogo y web hay un cliente que paga (`bill`) y uno que recibe (`ship`). 
- Decisión: Usamos `bill_customer_sk` y lo llamamos `customer_sk` en todos lados, porque nos importa quién pagó para el cálculo financiero.

### Identificador de orden (order_id)
Para cruzar ventas y devoluciones, necesitamos el ticket u orden:
- Store Sales: `ticket_number` -> `order_id`
- Catalog/Web: `order_number` -> `order_id`

Para cruzar una venta con su devolución usamos la clave compuesta `order_id` + `item_sk`.