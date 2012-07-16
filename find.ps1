#----------------------------------------------------------------
# Find.ps1
#----------------------------------------------------------------
param
(
  [string]$start = ".", # directory to start search in
  [int]$maxdepth = -1, # decend at most "n" levels below starting line
  [int]$mindepth = -1, # don't process levels less than mindepth
  [int]$amin = -1, # file was last accessed "n" minutes ago
  [int]$atime = -1, # file was last accessed "n"*24 hours ago
  [bool]$empty = $false, # file is empty and is a file or directory.
  [string]$name = "", # base of file name matches pattern.
  [string]$path = "", # filename/path matches pattern.
  [string]$exec = "" # Execute command on the matched files
);

$script:CURRENT_DEPTH = 0;

#----------------------------------------------------------------
# function Get-IsMatch
#----------------------------------------------------------------
function Get-IsMatch()
{
  param
  (
    $info = $null,
    $context = $null
  );
  [bool]$bIsMatch = $true;
  
  if ( Is-InDepthRange -context $context )
  {
    if ( $context["name"].Length -gt 0 )
    {
      $bIsMatch = $info.Name -like $context["name"];
    }
    elseif ( $context["path"].Length -gt 0 )
    {
      $bIsMatch = $info.FullName -like $context["path"];
    }
    
    if ( $bIsMatch -and ($context["amin"] -ne -1) )
    {
      $ts = [DateTime]::Now - $info.LastAccessTime;
      if ( $ts.TotalMinutes -gt $context["amin"] )
      {
        $bIsMatch = $false;
      }
    }

    if ( $bIsMatch -and ($context["atime"] -ne -1) )
    {
      $ts = [DateTime]::Now - $info.LastAccessTime;
      if ( $ts.TotalHours -gt (24 * $context["atime"]) )
      {
        $bIsMatch = $false;
      }
    }

    $bIsEmpty = $false;
    if ( $info -is [System.IO.FileInfo] )
    {
      $bIsEmpty = $info.Length -eq 0;
    }
    elseif ( $info -is [System.IO.DirectoryInfo] )
    {
      $bIsEmpty = ( $info.GetFiles().Length -eq 0 );
    }
    if ( $context["empty"] ) { $bIsMatch = $bIsEmpty; }
  }
  else
  {
    $bIsMatch = $false;
  }
  
  $bIsMatch;
}

#----------------------------------------------------------------
# function Is-InDepthRange
#----------------------------------------------------------------
function Is-InDepthRange()
{
  param($context = $null);
  
  $bInRange = $true;
  if ( $context )
  {
    if ( -1 -ne $context["mindepth"] )
    {
      if ( $script:CURRENT_DEPTH -lt $context["mindepth"] )
      {
        $bInRange = $false;
      }
    }
    if ( -1 -ne $context["maxdepth"] )
    {
      if ( $script:CURRENT_DEPTH -gt $context["maxdepth"] )
      {
        $bInRange = $false;
      }
    }
  }
  
  $bInRange;
}

#----------------------------------------------------------------
# function Do-FindAction
#----------------------------------------------------------------
function Do-FindAction()
{
  param
  (
    $info = $null,
    $context = $null
  );
  
  if ( $context["exec"].Length -gt 0 )
  {
    $cmd = $context["exec"];
    $expr = $cmd.Replace("{}", "`$info");
    Invoke-Expression $expr;
  }
  else
  {
    $info.FullName;
  }
}

#----------------------------------------------------------------
# function Find-InDirectory
#----------------------------------------------------------------
function Find-InDirectory()
{
  param
  (
    [string]$location = ".", # directory to start search in
    $context = $null
  );
  
  $cis = @(Get-ChildItem -Path $location);
  foreach ($ci in $cis)
  {
    if ( $ci.PSIsContainer )
    {
      if ( Get-IsMatch $ci -context $context )
      {
        Do-FindAction -info $ci -context $context;
      }
      
      # Stop recursion if maxdepth is reached
      if ( (-1 -ne $context["maxdepth"]) -and
        (($script:CURRENT_DEPTH + 1) -gt $context["maxdepth"]) )
      {
        break;
      }

      # Recurse through directories
      $script:CURRENT_DEPTH++;
      Find-InDirectory -location $ci.FullName -context $context;
      $script:CURRENT_DEPTH--;
    }
    else
    {
      if ( Get-IsMatch $ci -context $context )
      {
        Do-FindAction -info $ci -context $context;
      }
    }
  }
  
}

#----------------------------------------------------------------
# function Do-Find
#----------------------------------------------------------------
function Do-Find()
{
  param
  (
    [string]$start = ".",
    [int]$maxdepth = -1,
    [int]$mindepth = -1,
    [int]$amin = -1,
    [int]$atime = -1,
    [bool]$empty = $false,
    [string]$name = "",
    [string]$path = "",
    [string]$exec = ""
  );
  
  $context = @{
    "maxdepth" = $maxdepth; "mindepth" = $mindepth;
    "amin" = $amin; "atime" = $atime;
    "empty" = $empty; "name" = $name;
    "path" = $path; "exec" = $exec};

  Find-InDirectory -location $start -context $context;
}

Do-Find -start $start -maxdepth $maxdepth -mindepth $mindepth -amin $amin `
  -atime $atime -empty $empty -name $name -path $path -exec $exec;