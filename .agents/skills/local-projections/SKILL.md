---
name: local-projections
description: Use when implementing or interpreting the coursework's Jordà local projections for GDP, prices, and nominal GDP responses to precious-metals shocks.
---

# Local projections for the Palma coursework

## Specification

Follow Section 4.4 of `coursework_brief.pdf`. For each outcome and horizon h = 0,...,12, construct the cumulative change:

`y[i,t+h] - y[i,t-1]`

where `y` is one of `ln_real_gdp`, `ln_price`, or `ln_nominal_gdp`. Regress this outcome on `metals_prod_ship`, two lags of the dependent variable, and country fixed effects. The exercise permits this simplified specification without temperature, war, or trend controls. Restrict observations to years <= 1700 and cluster standard errors by country, as directed in the brief.

## Implementation checklist

1. Sort by country and year before creating leads, lags, or differences.
2. Create leads and lags within country so values never spill across country boundaries.
3. For each horizon, drop only rows missing variables needed by that horizon's regression.
4. Estimate OLS with country indicators and country-clustered standard errors.
5. Store the shock coefficient and its 95% confidence interval for every horizon.
6. Plot horizons 0–12 with connected estimates, shaded confidence bands, and a zero line.
7. Label each outcome and its units/interpretation; record the estimation sample.

## Interpretation

Describe the sign, size, timing, and uncertainty of each response. Check whether real GDP peaks around 6–9 years and whether prices respond later, but report what the estimated results actually show. Distinguish the coursework's simplified estimates from Palma's full specification. Country clustering with only six clusters may make conventional cluster-robust inference imprecise; state this limitation when relevant.
