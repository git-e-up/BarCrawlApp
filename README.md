Bar Crawl App

![alt tag](http://git-e-up.github.io/img/BarCrawlApp.png)

**Technologies used:**
Ruby 2.1.2p95,
Rails 4.2.1,
psql (PostgreSQL) 9.4.1
JQuery,
Skeleton
Yelp gem,
Google Maps api

**Live Application:**
<a href="https://linusdisaster.herokuapp.com/" target="_blank">Choose Your Own Disaster</a>




Requirements:
- register for an api key from yelp:
https://www.yelp.com/developers/manage_api_keys

- Skeleton CSS framework (recommended)
http://getskeleton.com/
(download and insert both the normalize.css and skeleton.css into your vendor/assets/stylesheets directory)
******************************
**INFORMATION BELOW WAS PART OF THE INITIAL APPLICATION, BUT MOST OF THE COMPLEX RUBY METHODS WERR REDACTED/COMMENTED-OUT TO EXPEDITE A VERSION 1.0. SOME SCREENSHOTS REFLECT A DEPRECATED UI. **


Bar/Tavern information:
https://data.cityofchicago.org/Community-Economic-Development/Business-Licenses-Current-Liquor-and-Public-Places/nrmj-3kcf
- Filter information
- Download information as CSV
- Drop the CSV into your rails db directory.


Remember to incorporate changes to the gemfile and bundle.


Testing the app:
from within the app's directory in command line:
```
  rails s
```

Database tables (our db is called " bar_crawl_development " ):
```
  List of relations
  Schema |       Name        | Type  |  Owner  
  --------+-------------------+-------+---------
  public | bar_distances     | table | Matthew
  public | bars              | table | Matthew
  public | chats             | table | Matthew
  public | crawls            | table | Matthew
  public | drinkers          | table | Matthew
  public | schema_migrations | table | Matthew
```



This app accepts either a user's current location or a manually entered location and renders options for a bar crawl. The bar options are those that are geographically closest to one another.

The bars are based on a fixed dataset from a list of licensed taverns in Chicago. The Haversine Formula is used to calculate distances between each bar based on latitude and longitude.


```
  def self.search_bars(lat, long, num_bars=1)
    dtor = Math::PI/180
    r = 3959

    rlat1 = lat * dtor
    rlong1 = long * dtor

    bars = self.all  # Find all the bars

    bar_distances = bars.map do |bar| # For each bar in the database
      rlat2 = bar.lat* dtor
      rlong2 = bar.long * dtor

      dlon = rlong1 - rlong2
      dlat = rlat1 - rlat2

      a = (Math::sin(dlat/2) ** 2) + Math::cos(rlat1) * Math::cos(rlat2) * (Math::sin(dlon/2) ** 2)
      c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
      d = r * c

      {
        distance: d,
        id: bar.id
      }
    end

    bar_distances.sort! { |x,y| x[:distance] <=> y[:distance] }

    closest_bars_hashes = bar_distances.slice(0..(num_bars-1))

    closest_bars_hashes.map {|bar_data|  self.find( bar_data[:id] ) }
  end

```
A user's current latitude and longitude is determined through a navigator.geolocation function, while manually entered latitude and longitudes are obtained with the yelp gem. This allows the user to enter not only addresses, but landmarks and more general search terms.

![Screen Shot](/location.png)

Admins can be manually created in the console by adding a "drinker"
```
  Drinker.create({name: 'Roger', password: 'password1', is_admin: true})
```


Admin has ability to remove bars from the database, by going to the /admin page:
![Screen Shot](/admin.png)

<!--== README-->

<!--This README would normally document whatever steps are necessary to get the-->
<!--application up and running.-->

<!--Things you may want to cover:-->

<!--* Ruby version-->
<!--Ruby 2.1.2p95-->
<!--Rails 4.2.1-->
<!--* System dependencies-->
<!--? yelp gem?-->
<!--* Configuration-->
<!--?-->
<!--* Database creation-->
<!--rake db:create-->
<!--* Database initialization-->
<!--rake db:migrate-->
<!--rake db:seed-->
<!--* How to run the test suite-->

<!--* Services (job queues, cache servers, search engines, etc.)-->

<!--* Deployment instructions-->

<!--* ...-->


<!--Please feel free to use a different markup language if you do not plan to run-->
<!--<tt>rake doc:app</tt>.-->
