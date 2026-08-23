# Supply Chain Performance & Demurrage Losses Analysis (China – Belarus Corridor)

## Project Overview
This project presents an executive BI solution designed to audit logistics contractor efficiency and discover hidden operational drains in the China–Belarus rail container corridor (terminating at Kolyadichi station, Minsk). By shifting flat transactional log data into an interactive analytics dashboard, this report provides the Commercial Director with immediate data-driven leverage to eliminate supplier-induced losses.

## Business Case & Financial Impact
The company incurred a severe penalty of **$42,600 in demurrage claims** due to containers overstaying at the rail terminal past the standard 7 free days. While operations blamed terminal congestion, this data audit revealed that the root cause was systemic transit delays by a single state-owned contractor, **Sinotrans Heavy**.

## Data Architecture (Star Schema)
The underlying MySQL database modeling 500 shipments utilizes a strict Star Schema architecture:
* `shipments` (Fact table capturing planned vs. actual delivery dates).
* `carriers` & `routes` (Dimension tables for granular filtering).
* `demurrage_claims` (Financial dimension calculating penalties at $50/day post-free-time).

## Key Logistics Metrics (DAX)
* **OTIF % (On-Time In-Full Rate):** Evaluates carrier reliability by tracking deliveries made on or before the planned target date.
* **Total Demurrage Losses (USD):** Aggregates financial penalties directly correlated with carrier performance.

## Analytical Insights
* **The Culprit Found:** While *RZD Logistics* and *Eurasia Rail Express* maintained excellent reliability (OTIF ~90-95%) with zero demurrage losses, **Sinotrans Heavy plummeted to an OTIF of just 19%**.
* **Actionable Outcome:** The dashboard provides clear evidence to cut volumes or renegotiate SLA terms with Sinotrans Heavy, preserving $42,600+ in corporate liquidity annually.

---
---

# Анализ эффективности перевозчиков и убытков от демереджа (Коридор Китай – Беларусь)

## Обзор проекта
Этот проект представляет собой BI-решение для проверки эффективности логистических подрядчиков и выявления скрытых операционных потерь в контейнерном коридоре Китай–Беларусь (терминал — станция Колядичи, Минск). После преобразования плоских логов транзакций в интерактивный дашборд этот отчёт даёт коммерческому директору возможность принимать решения на основе данных, чтобы устранять убытки, вызванные поставщиками.

## Бизнес-кейс и финансовое влияние
Компания понесла серьёзный ущерб в размере **$42 600 в виде штрафов за демередж** из-за превышения контейнерами срока бесплатного хранения на терминале (7 дней). Хотя операционный отдел винил в этом загруженность терминала, анализ данных выявил, что коренной причиной стали системные задержки в пути, вызванные одним государственным перевозчиком — **Sinotrans Heavy**.

## Архитектура данных (Схема «Звезда»)
База данных MySQL, моделирующая 500 поставок, построена по строгой схеме «Звезда»:
* `shipments` (таблица фактов: плановые и фактические даты доставки).
* `carriers` и `routes` (таблицы измерений для детальной фильтрации).
* `demurrage_claims` (финансовое измерение, рассчитывающее штрафы по ставке $50/день после окончания бесплатного срока).

## Ключевые логистические метрики (DAX)
* **OTIF % (On-Time In-Full Rate):** Показатель надёжности перевозчика, отслеживающий доставки, выполненные в срок или раньше плана.
* **Общие потери от демереджа (USD):** Агрегирует финансовые штрафы, напрямую связанные с эффективностью перевозчика.

## Аналитические выводы
* **Виновный найден:** В то время как *RZD Logistics* и *Eurasia Rail Express* показали отличную надёжность (OTIF ~90-95%) с нулевыми потерями от демереджа, **показатель Sinotrans Heavy упал до 19%**.
* **Практический результат:** Дашборд даёт чёткие доказательства для сокращения объёмов или пересмотра условий SLA с Sinotrans Heavy, что позволит сохранять $42,600+ в год в виде корпоративной ликвидности.
