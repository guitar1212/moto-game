<?php


//echo "123";
$density = $_POST['density'];
$polynum = $_POST['cnt'] + 1;
$coord = $_POST['coord'];
//$markers = $_POST['markers'];
//$A_m = $_POST['area_meter'];
//$A_km = $_POST['area_kmeter'];

$file = fopen("images/test.txt","w");
for($i=0 ; $i<$polynum ; $i++){
	fprintf($file,"Density : %u\n",$density[$i]);
	fprintf($file,"Coord. : %s\n",$coord[$i]);
}
//fprintf($file,"Coord.:\n%s",$markers);
//fprintf($file,"Area:\n%s %s",$A_m,$A_km);
//	print $markers;
//print_r($coord);
//echo $coord;
?>
