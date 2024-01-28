#!/usr/bin/env bats

export PATH="$PATH:../../mediaproc/scripts/"

@test "extract_exif_date on file WITH DateTimeOriginal field" {
  result="$(../../mediaproc/scripts/extract_exif_date ./images/with_exif_date_time_original.jpg)"
  [ "$result" = "1970 01 01" ]
}

@test "extract_exif_date on file WITHOUT DateTimeOriginal field" {
  run ../../mediaproc/scripts/extract_exif_date ./images/white.jpg
  [ "$status" = "1" ]
  [ "$output" = "no date found in exif data of ./images/white.jpg" ]
}

@test "extract_filename_date on files WITH date in filename" {
  result="$(../../mediaproc/scripts/extract_filename_date ./images/2000-10-01.jpg)"
  [ "$result" = "2000 10 01" ]

  result="$(../../mediaproc/scripts/extract_filename_date ./images/2000:01:10.jpg)"
  [ "$result" = "2000 01 10" ]
}

@test "extract_filename_date on file WITHOUT date in filename" {
  run ../../mediaproc/scripts/extract_filename_date ./images/white.jpg
  [ "$status" = "1" ]
  [ "$output" = "no date found in filename ./images/white.jpg" ]
}

@test "extract_date on file with different DateTimeOriginal field and filename" {
  result="$(../../mediaproc/scripts/extract_date ./images/2000-01-10_with_exif_date_time_original.jpg)"
	echo "$result"
  [ "$result" = "1970 01 01" ]
}

@test "extract_date on file WITHOUT DateTimeOriginal field and filename" {
  run ../../mediaproc/scripts/extract_date ./images/white.jpg
  [ "$status" = "1" ]
  [ "$output" = "no date found in filename and exif data for ./images/white.jpg" ]
}
