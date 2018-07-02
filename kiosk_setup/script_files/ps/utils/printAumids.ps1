# generate a file containing all the AUMIDS

# source for listAumids function
. "C:\Users\Administrator\Desktop\kiosk_setup\script_files\ps\utils\listAumids.ps1"

$aumids_list = listAumids

New-Item -ItemType file aumids_list.txt

foreach($x in $aumids_list)
{
    $x >> aumids_list.txt
}
