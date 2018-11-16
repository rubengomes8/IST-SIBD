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
				echo("<form	action='addanimal.php'	method='post'>\n <h2>Add a new animal to the database</h2> <h3>Owner information</h3>\n<p>name:	<input	type='text'	name='owner_name'/></p> <p>VAT:	<input	type='text'	name='animal_vat'/></p>\n <p>city:	<input	type='text'	name='city'/></p>\n<p>street:	<input	type='text'	name='street'/></p><p>zip:	<input	type='text'	name='zip'/></p> ");
				echo("<h3>Animal information</h3>\n<p>name:	<input	type='text'	name='animal_name'/></p> <p>scpecie:	<input	type='text'	name='species_name'/></p>\n <p>colour:	<input	type='text'	name='colour'/></p>\n<p>gender(M/F):	<input	type='text'	\nname='gender'/></p><p>birth year:	<input	type='text'	name='birth_year'/></p>\n<p>age:	<input	type='text'	name='age'/></p><p><input	type='submit'	value='Add new animal'/></p>\n  </form>");
				//option to go back to checkanimal
				echo("<form	action='checkanimal.php'	method='post'>\n  </p>\n <p><input	type='submit'	value='Go back'/></p>\n </form>");
				
			}
				
			$connection	=	null;
			?>
		</body>
</html>
