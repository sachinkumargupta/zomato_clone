## Seed File
In case of **Google API query limit exceed error**, seed file need to be run again.
Please run - $ rake db:reset

## Geocoder gem 
1. At times Geocoder gem return unexpected data, so to deal with it **begin** and **rescue** has been used in Restaurant controller filter action 
