director video_api_director_prd random {
  {
    .backend = F_www_fe;
    .weight  = 75;
  }{
    .backend = F_video_api;
    .weight  = 25;
  }
}

director nyt5_article_director_prd random {
  {
    .backend = F_www_fe;
    .weight  = 50;
  }{
    .backend = F_article_fe;
    .weight  = 50;
  }
}

director video_library_director_prd random {
  {
    .backend = F_www_fe;
    .weight  = 95;
  }{
    .backend = F_video_library;
    .weight  = 5;
  }
}
