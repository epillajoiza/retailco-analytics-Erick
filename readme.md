# RetailCo Analytics - Modelado Dimensional con dbt 🛒

## 📝 Descripción del Proyecto
Este proyecto implementa un Data Warehouse analítico completo utilizando dbt Core sobre un subset de datos TPC-DS alojado en Snowflake. El objetivo es responder a preguntas de negocio de un retailer multicanal (tienda física, catálogo y web), construyendo capas de transformación que alimentan un dashboard en Power BI.

## 🏗️ Arquitectura de Modelado
Se ha seguido la metodología estándar de dbt con tres capas principales:
1. **Staging (`stg_`):** Limpieza de datos crudos, renombrado de columnas crípticas, estandarización de tipos y cálculo de campos derivados (ej. edad del cliente y vigencia SCD Tipo 2).
2. **Intermediate (`int_`):** Unificación de canales de venta y devoluciones, y enriquecimiento de dimensiones (ej. consolidación de demografía de clientes).
3. **Marts (`mart_`):** Modelos analíticos finales orientados a negocio:
   - `mart_sales_by_channel`: Rendimiento de ventas y tasas de devolución.
   - `mart_customer_lifetime_value`: Segmentación de clientes (CLV).
   - `mart_inventory_health`: Control de roturas de stock.

## ⚙️ Instrucciones de Ejecución
1. Configurar conexión a Snowflake (`RAW` schema) en `profiles.yml`.
2. Instalar paquetes de dependencias (incluyendo `dbt_expectations`): `dbt deps`.
3. Ejecutar el proyecto completo: `dbt build` (compila, ejecuta y lanza los tests).
4. Generar documentación: `dbt docs generate` y `dbt docs serve`.# RetailCo Analytics - Modelado Dimensional con dbt 🛒

## 📝 Descripción del Proyecto
Este proyecto implementa un Data Warehouse analítico completo utilizando dbt Core sobre un subset de datos TPC-DS alojado en Snowflake. El objetivo es responder a preguntas de negocio de un retailer multicanal (tienda física, catálogo y web), construyendo capas de transformación que alimentan un dashboard en Power BI.

## 🏗️ Arquitectura de Modelado
Se ha seguido la metodología estándar de dbt con tres capas principales:
1. **Staging (`stg_`):** Limpieza de datos crudos, renombrado de columnas crípticas, estandarización de tipos y cálculo de campos derivados (ej. edad del cliente y vigencia SCD Tipo 2).
2. **Intermediate (`int_`):** Unificación de canales de venta y devoluciones, y enriquecimiento de dimensiones (ej. consolidación de demografía de clientes).
3. **Marts (`mart_`):** Modelos analíticos finales orientados a negocio:
   - `mart_sales_by_channel`: Rendimiento de ventas y tasas de devolución.
   - `mart_customer_lifetime_value`: Segmentación de clientes (CLV).
   - `mart_inventory_health`: Control de roturas de stock.

## ⚙️ Instrucciones de Ejecución
1. Configurar conexión a Snowflake (`RAW` schema) en `profiles.yml`.
2. Instalar paquetes de dependencias (incluyendo `dbt_expectations`): `dbt deps`.
3. Ejecutar el proyecto completo: `dbt build` (compila, ejecuta y lanza los tests).
4. Generar documentación: `dbt docs generate` y `dbt docs serve`.