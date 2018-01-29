director video_api_director_prd random {
  {
    .backend = F_www_fe;
    .weight  = 50;
  }{
    .backend = F_video_api;
    .weight  = 50;
  }
}

director video_library_director_prd random {
  {
    .backend = F_www_fe;
    .weight  = 75;
  }{
    .backend = F_video_library;
    .weight  = 25;
  }
}
