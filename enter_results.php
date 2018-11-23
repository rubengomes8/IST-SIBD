 <html>
		<body>
<?php
$host	=	"db.tecnico.ulisboa.pt";
$user	=	"ist425480";
$pass	=	"ipnr6905";
$dsn	=	"mysql:host=$host;dbname=$user";
try
{
	$connection	=	new	PDO($dsn,	$user,	$pass);
}
catch(PDOException	$exception)
{
	echo("<p>Error:	");
	echo($exception->getMessage());
	echo("</p>");
	exit();
}

$aname	=	$_GET['aname'];
//echo("<p> $aname</p>\n");
$vat	=	$_GET['vat'];
//echo("<p> $vat</p>\n");
$date	=	$_GET['date'];
//echo("<p> $date</p>\n");



//Enter results of a blood test 
//VAT_assistant, values of indicators: white blood cell count, number of neutrophils, number of lymphocites, number of monocytes
echo("<form	action='addresults.php?aname=$aname&vat=$vat&date=$date'	method='post'>\n <h2>Enter results</h2> \n<p>number of neutrophils:	<input	type='text'	name='neutrophils'/></p> <p>number of lymphocits:	<input	type='text'	name='lymphocits'/></p>\n <p>number of monocytes:	<input	type='text'	name='monocytes'/></p>\n<p>number of white blood cells:	<input	type='text'	name='white_blood_cell'/></p>\n<p>assistant VAT:	<input	type='text'	name='VAT_assistant'/></p>\n<p>num:	<input	type='text'	name='num'/></p>\n<p><input	type='submit'	value='Enter results'/></p>\n  </form>");

		
$connection	=	null;
?>
		</body>
</html>
