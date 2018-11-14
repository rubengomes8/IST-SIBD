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
echo("<p>Aname is: $aname</p>");
echo("<p>VAT is: $vat</p>");

$show_animal_consults_query = "SELECT c.name as aname, c.VAT_owner as vatt, c.date_timestamp as date FROM animal a, consult c WHERE a.VAT = c.VAT_owner and a.name = c.name and a.name ='$aname' and a.VAT = '$vat';";
	
echo("<p>Query: " . $show_animal_consults_query . "</p>\n");


	$result = $connection->query($show_animal_consults_query);
	
	$num = $result->rowCount();

	echo("<p>$num records retrieved:</p>\n");
	
	echo("<table border=\"1\">\n");
	echo("<tr><td>animal</td><td>vat</td><td>date</td></tr>\n");
	foreach($result as $row)
	{
		echo("<tr><td>");
		echo($row["name"]);
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
		echo("</tr>\n");
	}
	echo("</table>\n");
$connection	=	null;
?>
				</body>
</html>
