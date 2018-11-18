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
			$check_animal_query = $connection->prepare("SELECT a.name as aname, p.name as pname, p.VAT as vat FROM animal a, client c, person p WHERE a.VAT = c.VAT and c.VAT = p.VAT and a.name = :animal_name and a.VAT = :animal_vat and p.name like :owner_name");
			
			$check_animal_query->bindParam(':animal_name', $animal_name, PDO::PARAM_STR);
			$check_animal_query->bindParam(':animal_vat', $animal_vat, PDO::PARAM_STR);
			$check_animal_query->bindValue(':owner_name', "%{$owner_name}%");
			$check_animal_query->execute();

			//echo("<p>Query: " . $check_animal_query . "</p>\n");
			
			$num = $check_animal_query->rowCount();

			echo("<p>$num animals retrieved:</p>\n");
			
			//if $num >= 1
			if($num >= 1){
				echo("<table border=\"1\">\n");
				echo("<tr><td>animal</td><td>person</td><td>vat</td></tr>\n");
				foreach($check_animal_query as $row)
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
			} 
				
			//Option to add an animal
			echo("<form	action='addanimal.php'	method='post'>\n <h2>Add a new animal to the database</h2>");
			echo("<p>vat:	<input	type='text'	name='animal_vat'/></p>\n<p>name:	<input	type='text'	name='animal_name'/></p> <p>specie:	<input	type='text'	name='species_name'/></p>\n <p>colour:	<input	type='text'	name='colour'/></p>\n<p>gender(M/F):	<input	type='text'	\nname='gender'/></p><p>birth year:	<input	type='text'	name='birth_year'/></p>\n<p>age:	<input	type='text'	name='age'/></p><p><input	type='submit'	value='Add new animal'/></p>\n  </form>");
			//Option to go back to check the animals
			echo("<form	action='checkanimal.php'	method='post'>\n  </p>\n <p><input	type='submit'	value='Go back'/></p>\n </form>");
			
			
				
			$connection	=	null;
			?>
		</body>
</html>
