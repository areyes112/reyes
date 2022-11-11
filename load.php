<?php
  $entries = explode("\n",@file_get_contents("guestbook.csv"));
  echo str_replace("\\\"","",json_encode($entries));