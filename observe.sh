./bulldozer.rb > bulldozer.scad
while inotifywait -r --exclude *.scad -e close_write assemblies/ bulldozer.rb; do ./bulldozer.rb; done
