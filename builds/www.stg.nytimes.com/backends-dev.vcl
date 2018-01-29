director video_api_director_dev random {
  {
    .backend = F_www_fe;
    .weight  = 95;
  }{
    .backend = F_video_api;
    .weight  = 5;
  }
}
