./bulldozer.rb > bulldozer.scad
while inotifywait -r --exclude *.scad -e close_write lib/ bulldozer.rb; do ./bulldozer.rb; done
