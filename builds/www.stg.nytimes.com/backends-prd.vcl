director video_library_director_prd random {
  {
    .backend = F_www_fe;
    .weight  = 40;
  }{
    .backend = F_video_library;
    .weight  = 60;
  }
}
