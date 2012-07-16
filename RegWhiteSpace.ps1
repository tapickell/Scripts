$strText = "a nice line of text. We will search for an expression"
$Pattern = "/s"
$matches = [regex]::match($strText, $pattern)

"Result of using the match method, we get the following:"
$matches

$strReplace = [regex]::replace($strText, $pattern,  "_")
"Now we will replace, using the same pattern. We will use
an underscore to replace the space between words:"

$strReplace