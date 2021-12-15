## jq

For this one, i've used [WeatherAPI](https://www.weatherapi.com). Bellow you will see how I created the `json` files in this folder. 

### JSON Beautifier

`curl http://api.weatherapi.com/v1/current.json --data "key=(api_key)&q=Paris" | jq . > Paris-Weather.json`

### Accessing values from JSON

`curl http://api.weatherapi.com/v1/current.json --data "key=(api_key)&q=Paris" | jq '.location' > Location.json`

`curl http://api.weatherapi.com/v1/current.json --data "key=(api_key)&q=Paris" | jq '.location.country' > Country.json`

`curl http://api.weatherapi.com/v1/current.json --data "key=(api_key)&q=Paris" | jq '.location.lat,.location.lon' > LatLong.json`

### Extract as an array ( for this, i've used a random JSON file with arrays )

`jq '.[0:2]' arrays.json > FirstTwoArrays.json` -- this will get us the first two arrays from our JSON file
