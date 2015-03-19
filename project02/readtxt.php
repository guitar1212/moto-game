<?php
$delimiter = "\n";

/*** 設定 counter 初始值 ***/
$i = 1;

/*** 開檔 ***/
$fp = fopen( 'images/test.txt', 'r' );

/*** 不斷 loop pointer ***/
while ( !feof ( $fp) )
{
	/*** 將資料讀入串流中 ***/
	$buffer = stream_get_line( $fp, 1024, $delimiter );
	
	/*** 印出該行的值 ***/
	echo $buffer;
	echo "\n";

	/*** 遞增 counter ***/
	$i++;
	
	/*** 清楚記憶體 ***/
	$buffer = '';
}



?>
