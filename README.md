# Bookmeter Scraper サンプル

## 使いかた

```sh
$ bundle install
$ ruby bookmeter_scraper_sample.rb
Commands:
  bookmeter_scraper_sample.rb help [COMMAND]			   # Describe available commands or one specific ...
  bookmeter_scraper_sample.rb profile USER_ID			   # Fetch a specified user profile
  bookmeter_scraper_sample.rb read-books MAIL PASSWORD	   # Fetch read books
  bookmeter_scraper_sample.rb reading-books MAIL PASSWORD  # Fetch reading books
  bookmeter_scraper_sample.rb tsundoku MAIL PASSWORD	   # Fetch tsundoku books
  bookmeter_scraper_sample.rb wish-list MAIL PASSWORD	   # Fetch wish list
$ ruby bookmeter_scraper_sample.rb read-books <mail> <password> -y 2016 -m 1
読んだ本
book 1 title
読了日：2016年01月30日
book 2 title
読了日：2016年01月24日
book 3 title
読了日：2016年01月23日
...
```

## ライセンス

[MIT License](http://opensource.org/licenses/MIT)
