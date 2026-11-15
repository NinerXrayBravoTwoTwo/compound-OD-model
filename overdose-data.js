// overdose-data.js
// Washington State overdose deaths (Washington residents, statewide), by year and substance.
// Used for the observed data table and for selecting the base period for T_d / CAGR in the model.
//
// SOURCE (authoritative, first-party): Washington State Department of Health,
//   Opioid and Drug Use Data Dashboard -> "Overdose deaths (CSV)":
//   https://doh.wa.gov/sites/default/files/Data/Auto-Uploads/Opioids/Overdose_Downloadable_Deaths.csv
//   (dashboard page: https://doh.wa.gov/data-and-statistical-reports/washington-tracking-network-wtn/opioids/overdose-dashboard)
//   Rows used: Location = Statewide, Time Aggregation = "1 year rolling counts", Demographic = Overall/All.
//   File Date-Time Stamp: 2026-10-12T21:01:35Z (Oct 12, 2026, 2:01 PM PT). 2018-2024 annual rows
//   are unchanged from the earlier 2026-09-14T22:21:18Z file.
//   The 2024 values match DOH's "Confirmed Overdose Deaths among Washington Residents" table
//   (data as of March 16, 2026; total 3,145). 2024 is no longer preliminary there; 2025 is
//   still preliminary
//
// Column mapping (DOH drug category -> key):
//   total   = Any Drug              opiates = Any Opioid
//   heroin  = Heroin                fetty   = Synthetic Opioids (mostly fentanyl)
//   oxy     = Prescription Opioid (Rx opioids other than fentanyl, ICD-10 T40.2/T40.3)
//   meth    = Psychostimulants      cocaine = Cocaine
//   alcohol = Alcohol Poisoning (ICD-10 X45, X65, Y15; acute alcohol poisoning only, not
//             alcohol-related crashes, falls, or liver disease). Same CSV, data as of 2026-10-12:
//             2018-2024 from 1 year rolling counts (290, 302, 358, 425, 507, 530, 404); 2025
//             preliminary = sum of quarterly counts 2025.1-.4 (108+106+108+78 = 400).
//             DOH's Any Drug definition (X40-X44, X60-X64, X85, Y10-Y14) does not include these
//             codes, so alcohol poisoning deaths are not part of total.
// Categories overlap (one death can involve several drugs), so they don't sum to the total.
//
// Revision history:
//   2026-10: updated from the DOH dashboard CSV above. Changes vs. the earlier table (May 12, 2025,
//            2024 preliminary): 2024 all series (total 3,086 -> 3,145, opiates 2,440 -> 2,489,
//            heroin 34 -> 36, fetty 2,250 -> 2,295, oxy 348 -> 352, meth 1,818 -> 1,851; cocaine
//            unchanged at 480); small revisions in earlier years: 2018 total 1,181 -> 1,180,
//            opiates 744 -> 743, oxy 305 -> 304; 2019 opiates 827 -> 828, oxy 267 -> 268,
//            meth 540 -> 543; 2023 total 3,459 -> 3,458, meth 1,908 -> 1,907.
//   2026-11: 2025 preliminary row added from the 2026-09-14 CSV (total 2,916).
//   2026-11 (Oct-12 refresh): 2025 total 2,916 -> 2,932 from the DOH CSV data as of 2026-10-12
//            (Any Drug quarters 941/759/636/596); other 2025 series and all 2018-2024 rows unchanged.
//   2026-11: alcohol (Alcohol Poisoning) column added, 2018-2025, from the 2026-10-12 CSV.

window.OverdoseData = {
    // Data vintage (shown in the page's data-source note)
    source: {
        name: 'Washington State Department of Health, Opioid and Drug Use Data Dashboard (death certificates)',
        url: 'https://doh.wa.gov/data-and-statistical-reports/washington-tracking-network-wtn/opioids/overdose-dashboard',
        csv: 'https://doh.wa.gov/sites/default/files/Data/Auto-Uploads/Opioids/Overdose_Downloadable_Deaths.csv',
        asOf: '2026-10-12'
    },

    // Raw records
    records: [
        { year: 2018, total: 1180, opiates: 743, heroin: 329, fetty: 224, oxy: 304, meth: 473, cocaine: 129, alcohol: 290 },
        { year: 2019, total: 1259, opiates: 828, heroin: 347, fetty: 337, oxy: 268, meth: 543, cocaine: 132, alcohol: 302 },
        { year: 2020, total: 1731, opiates: 1194, heroin: 384, fetty: 672, oxy: 328, meth: 728, cocaine: 187, alcohol: 358 },
        { year: 2021, total: 2264, opiates: 1619, heroin: 344, fetty: 1214, oxy: 402, meth: 1142, cocaine: 232, alcohol: 425 },
        { year: 2022, total: 2703, opiates: 2048, heroin: 154, fetty: 1850, oxy: 303, meth: 1363, cocaine: 361, alcohol: 507 },
        { year: 2023, total: 3458, opiates: 2819, heroin: 67, fetty: 2642, oxy: 374, meth: 1907, cocaine: 594, alcohol: 530 },
        { year: 2024, total: 3145, opiates: 2489, heroin: 36, fetty: 2295, oxy: 352, meth: 1851, cocaine: 480, alcohol: 404 },
        //   2026-11: added 2025 preliminary row (sum of 2025 quarterly counts; heroin from Mar 2026 table).
        { year: 2025, total: 2932, opiates: 2291, heroin: 23, fetty: 2104, oxy: 328, meth: 1740, cocaine: 483, alcohol: 400 }
        // 2025 PRELIMINARY: sum of DOH Quarterly counts 2025.1-2025.4 (CSV data as of 2026-10-12);
        // heroin quarters suppressed (<10), so 23 is from DOH's Mar 16, 2026 table.
    ],

    // All available years (for UI etc.)
    getYears() {
        return this.records.map(r => r.year);
    },

    // Get a specific record by year
    getRecord(year) {
        return this.records.find(r => r.year === year) || null;
    },

    // Get array of values for a series over full range or specified
    getSeries(series /* 'total' | 'heroin' | 'fetty' | 'oxy' */, startYear = null, endYear = null) {
        let recs = this.records;
        if (startYear != null || endYear != null) {
            recs = recs.filter(r =>
                (startYear == null || r.year >= startYear) &&
                (endYear == null || r.year <= endYear)
            );
        }
        const key = (series === 'heroin') ? 'heroin' : series; // heroin is the column name
        return recs.map(r => r[key]);
    },

    // Get start and end values + dt for T_d / growth calculation on a series
    // Returns { v0, v1, dt, startYear, endYear }
    getGrowthParams(series /* 'total' | 'heroin' | 'fetty' | 'oxy' */, startYear, endYear) {
        const startRec = this.getRecord(startYear);
        const endRec = this.getRecord(endYear);
        if (!startRec || !endRec || startYear > endYear) return null;

        const key = (series === 'heroin') ? 'heroin' : series;
        return {
            v0: startRec[key],
            v1: endRec[key],
            dt: endYear - startYear,
            startYear,
            endYear
        };
    },

    // Convenience: get the two periods we care about, with total-od params
    getPeriodParams(periodKey /* '2019-2023' | '2018-2025' */) {
        if (periodKey === '2018-2025') {
            return this.getGrowthParams('total', 2018, 2025);
        }
        // default / original
        return this.getGrowthParams('total', 2019, 2023);
    },

    // For the observed data table (full or range)
    getTableData(startYear = null, endYear = null) {
        let recs = this.records;
        if (startYear != null || endYear != null) {
            recs = recs.filter(r =>
                (startYear == null || r.year >= startYear) &&
                (endYear == null || r.year <= endYear)
            );
        }
        return recs.map(r => ({
            year: r.year,
            total: r.total,
            opiates: r.opiates,
            heroin: r.heroin,
            fetty: r.fetty,
            oxy: r.oxy,
            meth: r.meth,
            cocaine: r.cocaine,
            alcohol: r.alcohol
        }));
    }
};
