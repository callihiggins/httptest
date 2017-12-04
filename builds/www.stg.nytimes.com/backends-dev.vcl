director video_api_director_dev random {
  {
    .backend = F_www_fe;
    .weight  = 95;
  }{
    .backend = F_video_api;
    .weight  = 5;
  }
}

director nyt5_article_director_dev random {
  {
    .backend = F_article_fe;
    .weight  = 100;
  }
}
