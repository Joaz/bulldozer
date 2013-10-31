./bulldozer.rb > bulldozer.scad
while inotifywait -r --exclude *.scad -e close_write .; do ./bulldozer.rb; done
