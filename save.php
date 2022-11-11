<?php
  $name = filter_input(INPUT_GET, "name");
  $hometown = filter_input(INPUT_GET, "hometown");
  echo "Saving $name, $hometown";
  $fp = fopen("guestbook.csv", "a");
  fputcsv($fp, [$name, $hometown]);
  fclose($fp);