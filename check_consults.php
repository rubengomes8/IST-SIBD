<html>
				<body>
<?php
$host	=	"db.ist.utl.pt";
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
$vat	=	$_GET['vat'];
//echo("<p>Aname is: $aname</p>");
//echo("<p>VAT is: $vat</p>");

$show_animal_consults_query = $connection->prepare("SELECT c.name as aname, c.VAT_owner as vatt, c.date_timestamp as date FROM animal a, consult c WHERE a.VAT = c.VAT_owner and a.name = c.name and a.name =:aname and a.VAT = :vat");

	$show_animal_consults_query->bindParam(':aname', $aname, PDO::PARAM_STR);

	$show_animal_consults_query->bindParam(':vat', $vat, PDO::PARAM_STR);

	$show_animal_consults_query->execute();

	$num = $show_animal_consults_query->rowCount();


	//echo("<p>$num records retrieved:</p>\n");
	if($num >= 1){
		echo("<table border=\"1\">\n");
		echo("<tr><td>animal</td><td>vat</td><td>date</td></tr>\n");
		foreach($show_animal_consults_query as $row)
		{
			echo("<tr><td>");
			echo($row["aname"]);
			echo("</td><td>");
			echo($row["vatt"]);
			echo("</td><td>");
			echo($row["date"]);
			//add link href
			echo("<td> <a	href=\"consult_info.php?aname=");
			echo($row['aname']);
			echo("&vat=");
			echo($row['vatt']);
			echo("&date=");
			echo($row['date']);
			echo("\">Consult info</a></td>\n");
			echo("<td> <a	href=\"enter_results.php?aname=");
			echo($row['aname']);
			echo("&vat=");
			echo($row['vatt']);
			echo("&date=");
			echo($row['date']);
			echo("\">enter results</a></td>\n");
			echo("</tr>\n");
		}
		echo("</table>\n");
	}

	$sql = "SELECT VAT from veterinary;";
	$result = $connection->query($sql);

	echo("<h3>Check the existence of another animal</h3>");
	echo("<form	action='checkanimal.php'	method='post'>\n  </p>\n <p><input	type='submit'	value='Go to homepage'/></p>\n </form>");
	echo("<form	action='addconsult.php?aname=$aname&vat=$vat'	method='post'>\n <h3>Add a new consult to the database for ($aname, $vat)</h3> <h3>Consult information</h3>\n<p>date(YYYY-MM-DD hh:mm:ss):	<input	type='text'	name='date'/></p> <p>s:	<input	type='text'	name='s'/></p>\n <p>o:	<input	type='text'	name='o'/></p>\n<p>a:	<input	type='text'	name='aa'/></p><p>p:	<input	type='text'	name='p'/></p> ");
	echo("\n<p>veterinary VET:	<select	name='VAT_vet'>"); 

	foreach($result	as	$row)
	{
		$VAT_vet	=	$row['VAT'];
		echo("<option	value=\"$VAT_vet\">$VAT_vet</option>");
	}

	echo("</select></p>\n <p>weight:	<input	type='text'	name='weight'/></p>\n<p>diagnostic code:	<input	type='text'	name='code'/></p><p><input	type='submit'	value='Add new consult'/></p>\n  </form>");


$connection	=	null;
?>
</body>
</html>

