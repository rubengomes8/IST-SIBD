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
$animal_name	=	$_REQUEST['animal_name'];
$animal_vat	=	$_REQUEST['animal_vat'];
$owner_name	=	$_REQUEST['owner_name'];

//Check if person exists. If not Add a new Person, a new Client and a new animal.

//If exists in person check if exists in client. If not add a client and new animal

//If exists in client add a new animal

$check_animal_query = "SELECT a.name as aname, p.name as pname, p.VAT as vat FROM animal a, client c, person p WHERE a.VAT = c.VAT and c.VAT = p.VAT and a.name ='$animal_name' and a.VAT = '$animal_vat' and p.name like '%$owner_name%';";
	

	echo("<p>Query: " . $check_animal_query . "</p>\n");

	$result = $connection->query($check_animal_query);
	
	$num = $result->rowCount();

	echo("<p>$num records retrieved:</p>\n");
	
	//if $num >= 1
	if($num >= 1){
		echo("<table border=\"1\">\n");
		echo("<tr><td>animal</td><td>person</td><td>vat</td></tr>\n");
		foreach($result as $row)
		{
			echo("<tr><td>");
			echo($row["aname"]);
			echo("</td><td>");
			echo($row["pname"]);
			echo("</td><td>");
			echo($row["vat"]);
			echo("</td><td>");
			echo("<a	href=\"check_consults.php?aname=");
			echo($row['aname']);
			echo("&vat=");
			echo($row['vat']);
			echo("\">Check consults</a></td>\n");
			echo("</tr>\n");
		}
		echo("</table>\n");
	} else {
		//option to add an animal
		echo("<form	action='addanimal.php'	method='post'>\n <h3>Add a new animal to the database</h3>\n <p>Animal name:	<input	type='text'	name='animal_name'/></p>\n <p>VAT:	<input	type='text'	name='animal_vat'/></p>\n <p>Owner:	<input	type='text'	name='owner_name'/></p>\n <p><input	type='submit'	value='Add new animal'/></p>\n </form>");
	}
	
	
				
	$connection	=	null;
?>
		</body>
</html>
