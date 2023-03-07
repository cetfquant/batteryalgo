# batteryalgo
CETF is a hedge fund trading in clean energy (cet.fund).
- Aim is to develop an automated algorithm for the optimal operation of a battery.
- Optimal operation means maximisation of profits over a 12-month period.
- Trading will comprise energy-only trading (i.e., the difference between energy prices incurred when charging versus prices earned when discharging).
- Algo does not need to be generalised. It can switch between different regimes (e.e., peak/off-peak, night/day, week/weekend, etc.)

Prize to best algo:
- We offer a cash prize of $500 and an internship with our trading and quantitative development team.

Battery specifications as follows:
- Size: 5.00 MW
- Power: 4 hour
- Max ramp rate: 0.417 MW/5 minutes (discharge and recharge)
- Maximum DOD: 1.00
- Minimum DOD: 0.00
- Maximum cycles per day: 1.75 cycles (1 cycle equals 4 hours of discharge and 4 hours of discharge)
- Cycles: Can switch every five minutes to charge, discharge, idle.
- Prices: NEM wholesale prices charged when charging from the NEM, and NEM prices are earned when discharging to the NEM.

Data Files - the following data files are provided:
 - NSW price data 2022. This is the settled wholesale NEM price data for all assets supplying power to, or drawing power from NSW.
 - Pre-dispatch prices 2022. These values are published up to 48 hours prior to the current time. These prices reflect expected bidding behaviour of generators in the market taking into account expected demand, temperatures, network constraints, etc.
 - Forecast operational demand 2022. This is provided at the POE10, 50, and 90 levels. These values are published several days in advance of the current time. This may help the trading algorithm.
 - Actual operational demand 2022. This value is only known after the demand has occurred and settled prices are published. May be good for explanatory measures but not useful for forecasting.

For out of sample testing the following files are also available for the first couple of months of 2023.
 - NSW price data 2023.
 - Pre-dispatch prices 2023.
 - Forecast operational demand 2023.
 - Actual operational demand 2023.

Any questions please email me at jason.west@cet.fund
