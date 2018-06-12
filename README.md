# Spatio-Temporal-Crime-Analysis-Time-Series-for-New-York-City
Authors: Sohil Shah, Melanie Tosik, Jason Chang, Yang, Jae Hyun

This project gives an overview of crime time analysis in New York City . We have created Python Jupyter notebooks for spatial analysis of different crime types in the city using Pandas, Numpy, Plotly and Leaflet packages. As a second part to this analysis, we worked on ARIMA model on R for predicting the crime counts across various localities in the city based on correlations of various demographics correlation in each locality. 

## Data
[NYPD Complaint Data Historic](https://data.cityofnewyork.us/Public-Safety/NYPD-Complaint-Data-Historic/qgea-i56i)

[CoreData.nyc](http://app.coredata.nyc/?mlb=false&ntii=&ntr=&mz=14&vtl=https%3A%2F%2Fthefurmancenter.carto.com%2Fu%2Fnyufc%2Fapi%2Fv2%2Fviz%2F691a2b7c-94d7-46ac-ac4d-9a589cb2c6ed%2Fviz.json&mln=false&mlp=true&mlat=40.718&ptsb=&nty=&mb=roadmap&pf=%7B%22subsidies%22%3Atrue%7D&md=map&mlv=false&mlng=-73.996&btl=Borough&atp=properties)

## Run
### Python scripts

```
virtualenv -p python3 env/
source env/bin/activate
pip install -r requirements.txt
```

## Jupyter notebooks
There are two Jupyter notebooks in the data_exploration/ folder, crime_analyses.ipynb and crime_data_prep.ipynb.

## Related work
S. H. Huddleston and D. E. Brown, "A Statistical Threat Assessment," in IEEE Transactions on Systems, Man, and Cybernetics - Part A: Systems and Humans, vol. 39, no. 6, pp. 1307-1315, Nov. 2009.

M. A. Tayebi, M. Ester, U. Glässer and P. L. Brantingham, "CRIMETRACER: Activity space based crime location prediction," 2014 IEEE/ACM International Conference on Advances in Social Networks Analysis and Mining (ASONAM 2014), Beijing, 2014, pp. 472-480.

E. Cesario, C. Catlett and D. Talia, "Forecasting Crimes Using Autoregressive Models," 2016 IEEE 14th Intl Conf on Dependable, Autonomic and Secure Computing, 14th Intl Conf on Pervasive Intelligence and Computing, 2nd Intl Conf on Big Data Intelligence and Computing and Cyber Science and Technology Congress(DASC/PiCom/DataCom/CyberSciTech), Auckland, 2016, pp. 795-802.

M. A. Tayebi, U. Gla¨sser and P. L. Brantingham, "Learning where to inspect: Location learning for crime prediction," 2015 IEEE International Conference on Intelligence and Security Informatics (ISI), Baltimore, MD, 2015, pp. 25-30.

Al Boni, Mohammad & Gerber, Matthew. (2016). Area-Specific Crime Prediction Models. 671-676. 10.1109/ICMLA.2016.0118.

Seth R. Flaxman, "A General Approach to Prediction and Forecasting Crime Rates with Gaussian Processes", 2014.

## Project repo
A preview of the project is available on GitHub
