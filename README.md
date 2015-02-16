# rach-elp

A swift app that uses the Yelp API to search for restaurants; filters based on category, sort-by preference, and deals; and displays restaurant details. The details page includes a map of the restaurant location and a link to call them. The user's location is determined using CLLocationManager.

Required Features:
- Search results page
- Table rows are a dynamic height according to the content height (in particular, adjusts appropriately for restaurant names that wrap onto a 2nd line)
- Custom cells have the proper Auto Layout constraints, so UI works for portrait and landscape modes (GIFs of both are included below)
- Search bar is in the navigation bar
- Filters page with 3 sections of filters: category, sort (best match, distance, highest rated), deals (on/off).
- Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings

Extra Features:
- Restaurant details page that includes a map showing the restaurant location
- User can click on the restaurant phone number and it will transfer to the phone app and make call (note that phone calls can not be tested in the iOS simulator, but I have downloaded the app to my actual phone and tested it there)
- App uses user location if they choose to turn on location services.  In the iOS simulator, I have set the location to Apple (in Cupertino).  I have tested this on my actual phone in Sausalito as well.

I spent around 18 hours on this app.

Portrait:

![alt tag](https://github.com/racheltho/RachELP/blob/master/Yelp-Clone/yelp-app.gif)


Landscape:

![alt tag](https://github.com/racheltho/RachELP/blob/master/Yelp-Clone/yelp-app-landscape.gif)
