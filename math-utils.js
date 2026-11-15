// math-utils.js
// Portable JS port of the T_d methods from Keto_Cta.MathUtils.cs
// for reuse across models (overdose projections, energy/GDP, population dynamics, etc.)
// Core formula from the T_d vs Half-Life image:
//   For growth (v2 > v1): T_d = dt * ln(2) / ln(v2/v1)
//   For regression: negative T_d representing half-life

window.MathUtils = {
    /**
     * Time to double (positive Td) or half-life (negative Td).
     * dt = interval (e.g. 1 year). Matches C# MathUtils.Td exactly.
     */
    Td(v1, v2, dt = 1.0) {
        if (Math.abs(v1 - v2) < 1e-8) return { td: 0.0, isInfinite: true };
        if (v1 <= 0 || v2 <= 0) return { td: NaN, isInfinite: false };
        const ratio = v2 / v1;
        let result;
        if (ratio > 1) {
            result = dt * Math.log(2) / Math.log(ratio);
        } else {
            result = -(dt * Math.log(2) / Math.log(1 / ratio));
        }
        return { td: result, isInfinite: false };
    },

    /**
     * Predict future value using a Td result object.
     * Matches C# MathUtils.DblPredict.
     */
    DblPredict(tdObj, baseline, years = 1) {
        if (isNaN(tdObj.td)) return NaN;
        if (tdObj.td === 0) return baseline;
        let r;
        if (tdObj.td > 0) {
            r = Math.log(2) / tdObj.td;
        } else {
            r = Math.log(0.5) / -tdObj.td;
        }
        return baseline * Math.exp(years * r);
    }
};
