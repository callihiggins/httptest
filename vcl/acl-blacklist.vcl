acl blacklist {

  # this IP was attacking /store on 01/05/2017
  "209.107.195.164"/32;

  # this IP was attacking real-estate and video (and some others) on 05/19/2017
  "35.185.167.241"/32;

  # this is was aggressively crawling /indexes/... on 20170929
  "82.1.139.178"/32;

  # aggressively crawling multiple times, some invalid URLs - 20180129
  # Latin American and Caribbean IP address Regional Registry, no other info available
  "190.237.183.174"/32;

  # per request https://jira.nyt.net/browse/WF-25
  "109.226.37.37"/32;
  "109.226.37.38"/31;
  "109.226.37.40"/31;
  "212.150.211.160"/28;
  "212.150.211.176"/29;
  "212.150.211.184"/31;
  "62.90.131.202"/32;
  "82.166.195.64"/28;
}
