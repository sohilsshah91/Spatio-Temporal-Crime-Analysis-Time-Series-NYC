import csv
import sys

import pandas as pd

from operator import itemgetter


def main(data_fp):
    """
    Preprocessing and data exploration
    """
    # Read data CSV
    df = pd.read_csv(data_fp)
    # Drop rows without x- or y-coordinates
    df.dropna(subset=['X_COORD_CD', 'Y_COORD_CD'], inplace=True)
    # Drop irrelevant/redundant columns
    df.drop([
        'CMPLNT_NUM',
        'OFNS_DESC',  # correlated with 'KY_CD'
        'PD_DESC',  # correlated with 'PD_CD'
        'CRM_ATPT_CPTD_CD',  # crime completion rate not relevant
        'Latitude',  # using 'Y_COORD_CD' instead
        'Longitude',  # using 'X_COORD_CD' instead
    ], axis=1, inplace=True)

    # # Get 'KY_CD' code description
    # df.set_index('KY_CD', inplace=True)
    # for kycd in [341, 578, 344, 351, 109]:
    #     print(kycd, df.loc[kycd, 'OFNS_DESC'])
    #     continue

    # Get 5 most frequent, unique values per (interpretable) column
    stats = {}
    for col in [
        'KY_CD',
        'PD_CD',
        'LAW_CAT_CD',
        'JURIS_DESC',
        'BORO_NM',
        'LOC_OF_OCCUR_DESC',
        'PREM_TYP_DESC',
        'PARKS_NM',
        'HADEVELOPT',
    ]:
        stats[col] = df[col].value_counts().head(5).to_dict()
    # Sort by value
    for col in stats:
        stats[col] = sorted(
            stats[col].items(),
            key=itemgetter(1),
            reverse=True,
        )
    # Write to CSV
    with open('stats.csv', 'w') as csvfile:
        writer = csv.writer(csvfile)
        for col in sorted(stats):
            row = [col]
            row.extend(['{0}\n [{1}]'.format(x[0], x[1]) for x in stats[col]])
            writer.writerow(row)


if __name__ == '__main__':
    if len(sys.argv) != 2:
        print('USAGE: python explore_data.py <data CSV>')
        sys.exit(1)
    main(sys.argv[1])
