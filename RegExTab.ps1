$strPattern = "/t"
$regex = [regex]$strPattern

$text = ${c:\users\dad\documents\PipeGrepMore.txt}

$mc = $regex.matches($text)
$mc.count
