# Customer Churn Analysis Insights

## Dataset Overview

- **Total Customers:** 500
- **Churned:** 172 (34.4%)
- **Retained:** 328 (65.6%)
- **Service:** Telecom subscription (internet + add-ons)

---

## Key Findings

### Churn by Contract Type
- **Month-to-Month** customers churned at a rate of **50.0%** — by far the highest risk segment
- **One Year** contracts showed a 22.5% churn rate — significantly improved with commitment
- **Two Year** contracts had the lowest churn at just **15.2%**, confirming that longer commitments strongly anchor retention
- Migrating Month-to-Month customers to longer contracts is the single highest-impact retention lever

### Churn by Payment Method
- **Electronic Check** customers churned at nearly **48%** — almost double the rate of Credit Card users
- **Credit Card** and **Bank Transfer** customers showed the lowest churn (~27%), likely correlated with higher digital engagement and auto-pay reliability
- The Electronic Check pattern may indicate a less-engaged, price-sensitive customer profile

### Churn by Tenure Cohort
- Customers in their first **0–12 months** had the highest churn rate — early experience is critical
- Customers who survived past 24 months churned at significantly lower rates, suggesting a loyalty threshold
- Onboarding quality and early engagement are the most important retention investment

### Monthly Charges and Churn
- High-charge customers (>$70/month) churned at a disproportionately high rate
- This suggests that value perception does not keep up with pricing for a significant portion of the customer base
- Customers paying more but not using multiple services are the most at risk

### Tech Support Impact
- Customers **without tech support** churned at a noticeably higher rate than those with it
- Tech support likely acts as a stickiness mechanism — customers with unresolved issues leave; those with support stay
- Offering proactive tech support to high-risk segments could meaningfully reduce churn

### Revenue at Risk
- Month-to-Month customers with tenure under 12 months represent a concentrated pocket of annualised revenue risk
- Retaining even 30% of this group through targeted intervention would deliver significant revenue protection

---

## Recommendations

1. **Incentivise contract upgrades** — Offer a discount or added service to Month-to-Month customers who upgrade to a One Year plan. The churn differential (50% → 22.5%) justifies significant acquisition cost.

2. **Flag Electronic Check customers for proactive outreach** — Encourage migration to auto-pay methods (Credit Card, Bank Transfer). This reduces churn risk and improves cash flow predictability.

3. **Invest heavily in the first 12 months** — Assign a dedicated onboarding journey, check-in calls, and early-tenure offers. The 0–12 month cohort is where the battle for retention is won or lost.

4. **Bundle tech support into high-value plans** — Customers paying more than $70/month should receive tech support as standard. It drives satisfaction and reduces the price-sensitivity churn trigger.

5. **Build a real-time churn risk score** — The three factors (contract type, tenure, monthly charges) alone are highly predictive. A simple scoring model built on SQL outputs could automate early interventions.
