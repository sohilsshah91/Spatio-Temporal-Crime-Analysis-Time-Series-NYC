import json
import os
import sys

import matplotlib.pyplot as plt
import pandas as pd

from collections import defaultdict
from scipy.stats.stats import pearsonr


def get_crime_stats(nypd_fp, normalize=True):
    """
    Get crime frequency per borough per year
    """
    # Read data CSV
    df = pd.read_csv(nypd_fp)
    # Drop rows without x- or y-coordinates, borough name, or report date
    df.dropna(subset=['X_COORD_CD', 'Y_COORD_CD', 'BORO_NM', 'RPT_DT'], inplace=True)
    # Drop irrelevant/redundant columns
    df.drop([
        'CMPLNT_NUM',
        'OFNS_DESC',  # correlated with 'KY_CD'
        'PD_DESC',  # correlated with 'PD_CD'
        'CRM_ATPT_CPTD_CD',  # crime completion rate not relevant
        'Latitude',  # using 'Y_COORD_CD' instead
        'Longitude',  # using 'X_COORD_CD' instead
    ], axis=1, inplace=True)

    # # Write outfile CSV
    # df.to_csv('nypd_preprocessed.csv', encoding='utf-8', index=False)

    # Crime frequency counts per year per borough
    stats = defaultdict(lambda: defaultdict(int))

    for idx, row in df.iterrows():

        # Borough name
        boro = row['BORO_NM']
        # Year (last four digits of report date)
        year = row['RPT_DT'][-4:]
        # Increment count
        stats[year][boro] += 1

        if idx % 50000 == 0:
            print(idx)

    # Normalize crime frequency
    if normalize:
        for year in stats:
            total = sum(stats[year].values())
            for boro in stats[year]:
                stats[year][boro] = stats[year][boro] / total

    # Write statistics to JSON
    with open('nypd_crime_freqs.json', 'w') as out:
        json.dump(stats, out, sort_keys=True)

    return stats


def get_correlation(stats, indicator_fp):
    """
    Get correlation between crime stats and indicator data
    """
    # Read data CSV
    df = pd.read_csv(indicator_fp)
    df.set_index('Borough', inplace=True)

    # List of boroughs
    boros = ['Bronx', 'Brooklyn', 'Manhattan', 'Queens', 'Staten Island']
    # List of years
    years = sorted(set(df.columns.values).intersection(list(stats.keys())))

    for boro in boros:
        # print(boro)

        nypd = []  # Append crime stats data
        core = []  # Append demographics data

        for year in years:
            nypd.append(stats[year][boro.upper()])
            core.append(df.loc[boro][year])

        assert(len(nypd) == len(core))

        print(nypd)
        print(core)

        plt.figure(1)

        plt.subplot(211)
        plt.title(boro)
        plt.ylabel('Number of crimes')
        plt.plot(years, nypd, 'b-', label='NYPD')  # NYPD in blue
        plt.legend(loc='upper right')

        plt.subplot(212)
        plt.ylabel('Racial diversity index')
        plt.plot(years, core, 'g-', label='CoreData')  # CoreData in green
        plt.legend(loc='upper right')

        plt.show()

        # Print Pearson correlation
        score, pscore = pearsonr(nypd, core)
        print("{0}, {1}".format(round(score, 6), round(pscore, 6)))

    return None


def main(nypd_fp, corenyc_fp):
    """
    main()
    """
    # Get frequency counts from NYPD data
    if os.path.isfile('nypd_crime_freqs.json'):
        crime_stats = json.load(open('nypd_crime_freqs.json'))
    else:
        crime_stats = get_crime_stats(nypd_fp)

    # Get Pearson correlation
    get_correlation(crime_stats, corenyc_fp)


if __name__ == '__main__':
    if len(sys.argv) != 3:
        print('USAGE: python racial_diversity_index.py <NYPD CSV> <CoreData CSV>')
        sys.exit(1)
    main(sys.argv[1], sys.argv[2])
