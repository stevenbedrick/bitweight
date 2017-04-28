# eBitWeight

This C++ header and accompanying Python module provide classes designed to make it easier to work with log-probabilites in NLP and ML applications. 

A BitWeight is a real-space value represented internally as a negative base-2 logarithm, similar to that used in the log probability semiring, and used to avoid underflow. 

eBitWeight is (c) 2017 by Shiran Dudy based on BitWeight code of Kyle Gorman and Steven Bedrick, and is released under the 3-clause BSD License. See `LICENSE.txt` for more details.

eBitWeight allows for negative log values to be inserted directly (instead of probability values) and enables the dispaly of values in that domain. 