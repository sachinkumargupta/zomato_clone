## Seed File
In case of **Google API query limit exceed error**, seed file need to be run again. 
Please run - **$ rake db:reset**
Geocoder gem has been used to generate latitude and longitude from Address of the restaurant. During seeding due to large number of request being sent to google api in a very short duration of time, this error might occur. In that case either ** rake db:reset ** can be run again OR after completion of seeding, address of restaurants with latitude and longitude column nil should be changed. Upon submission geocoder will run again and fix generate the latitude and longitude.

## Geocoder gem 
1. At times Geocoder gem return unexpected data, to deal with it **begin** and **rescue** has been used in Restaurant controller filter action 
2. For geocoder to work, addresses needed to be gunuine so school addresses has been used in seed file as it was readily available.


## Nearby Locations
All the address given in the seed file are of kolkata and nearby places. 


## UI in firefox
1. html5 attribute **datetime** input field has been used in views/book_tables/form.html.erb, but **firefox** does not support it. To input datetime, this format can be used - **dd/mm/yyyy hh:mm** . Firefox can interprete other formats too.
2. form-inline class not effective in views/orders/form.html.erb page.
3. Above mentioned problems do not occur in Google Chrome which was used during the development of this application


## Login info
After running seed file this credentials can be used to login
####Admin
email id: sachin1@gmail.com
password: sachin
####User
email id: sachin2@gmail.com
password: password