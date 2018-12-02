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
		//echo("<p>a$animal_name</p>\n");
		$animal_vat	=	$_REQUEST['animal_vat'];
		//echo("<p>$animal_vat</p>\n");
		$owner_name	=	$_REQUEST['owner_name'];
		//echo("<p>$owner_name</p>\n");

		$check_client = $connection->prepare("SELECT * FROM client WHERE client.VAT = :vat");

		//$check_client->debugDumpParams(); 

		$check_client->bindParam(':vat', $animal_vat, PDO::PARAM_STR);
		$check_client->execute();
		$num_c = $check_client->rowCount();

		//echo("<p>$num_c clients retrieved:</p>\n");


		$check_animal_query = $connection->prepare("SELECT a.name as aname, p.name as pname, p.VAT as vat, a.species_name as specie, a.gender as gd, a.age as ag FROM animal a, client c, person p WHERE a.VAT = c.VAT and c.VAT = p.VAT and a.name = :animal_name and a.VAT = :animal_vat and p.name like :owner_name and exists (SELECT * FROM consult c WHERE c.VAT_client = :vat and c.name = a.name and c.VAT_owner = p.VAT) ");

		//$check_animal_query->debugDumpParams();

		/**/

		$check_animal_query->bindValue(':animal_name', $animal_name);
		$check_animal_query->bindValue(':animal_vat', $animal_vat);
		$check_animal_query->bindValue(':owner_name', "%{$owner_name}%");
		$check_animal_query->bindValue(':vat', $animal_vat);
		$check_animal_query->execute();

		$num = $check_animal_query->rowCount();

		//echo("<p>$num animals retrieved:</p>\n");

		//if $num >= 1
		if($num >= 1){
			echo("<table border=\"1\">\n");
			echo("<tr><td>animal</td><td>person</td><td>vat</td><td>specie</td><td>gender</td><td>age</td></tr>\n");
			foreach($check_animal_query as $row)
			{
				echo("<tr><td>");
				echo($row["aname"]);
				echo("</td><td>");
				echo($row["pname"]);
				echo("</td><td>");
				echo($row["vat"]);
				echo("</td><td>");
				echo($row["specie"]);
				echo("</td><td>");
				echo($row["gd"]);
				echo("</td><td>");
				echo($row["ag"]);
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
		if($num == 0){
			echo("<form	action='addanimal.php?vat=$animal_vat&aname=$animal_name'	method='post'>\n <h3>No animal found. You can insert $animal_name.</h3>");
			echo("<p>Animal name: $animal_name</p>");
			echo("<p>Owner VAT: $animal_vat</p>");
			echo("<p>specie:	<input	type='text'	name='species_name'/></p>\n <p>colour:	<input	type='text'	name='colour'/></p>\n<p>gender(M/F):	<input	type='text'	\nname='gender'/></p><p>birth year:	<input	type='text'	name='birth_year'/></p>\n<p>age:	<input	type='text'	name='age'/></p><p><input	type='submit'	value='Add new animal'/></p>\n  </form>");
		}

		//Option to go back to check the animals
		echo("<h3>Check the existence of another animal</h3>");
		echo("<form	action='checkanimal.php'	method='post'>\n  </p>\n <p><input	type='submit'	value='Check another animal'/></p>\n </form>");



		$connection	=	null;
		?>
	</body>
</html>
