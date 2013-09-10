./bulldozer.rb > bulldozer.scad
while inotifywait -r -e close_write .; do ./bulldozer.rb > bulldozer.scad; done
