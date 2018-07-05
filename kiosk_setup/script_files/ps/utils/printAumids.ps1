# generates a file containing all the AUMIDS
# must have script "listAumids.ps1" in same directory

# source for listAumids function
$cur_dir = pwd
$script = "\listAumids.ps1"
$src = -join($cur_dir,$script)
. $src

$out_file = "aumidsList.txt"

if(Test-Path $out_file)
{
    rm $out_file
}

New-Item -ItemType file $out_file

$aumids_list = listAumids

foreach($x in $aumids_list)
{
    $x >> $out_file
}
