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
				//Information about the owner
				$owner_name	=	$_REQUEST['owner_name'];
				$animal_vat	=	$_REQUEST['animal_vat'];
				$city	=	$_REQUEST['city'];
				$street	=	$_REQUEST['street'];
				$zip	=	$_REQUEST['zip'];
				//Information about the animal
				$animal_name	=	$_REQUEST['animal_name'];
				$species_name	=	$_REQUEST['species_name'];
				$colour	=	$_REQUEST['colour'];
				$gender	=	$_REQUEST['gender'];
				$birth_year	=	$_REQUEST['birth_year'];
				$age	=	$_REQUEST['age'];//should convert this into another integer variable?




				//Check if person exists. If not Add a new Person, a new Client and a new animal.
				$check_person = "SELECT * from person WHERE VAT = '$animal_vat';";
				$add_person = "INSERT into person(VAT, name) values ('$animal_vat', '$owner_name');";
				$add_client = "INSERT into client values ('$animal_vat');";
				$add_animal = "INSERT into animal values ('$animal_name','$animal_vat', '$species_name', '$colour', '$gender', '$birth_year', '$age');";
				echo("<p>Query: " . $check_person . "</p>\n");
				echo("<p>Query: " . $add_person . "</p>\n");
				echo("<p>Query: " . $add_client . "</p>\n");
				echo("<p>Query: " . $add_animal . "</p>\n");

				$result = $connection->query($check_person);

				$num_p = $result->rowCount();

				echo("<p>$num_p person retrieved:</p>\n");
				if($num_p == 0){
					$result = $connection->query($add_person);
					$result = $connection->query($add_client);
					$result = $connection->query($add_animal);
				} else {
					//If exists in person check if exists in client. If not add a client and new animal

					$check_client = "SELECT * from client WHERE VAT = '$animal_vat';";
					echo("<p>Query: " . $check_client . "</p>\n");

					$result = $connection->query($check_client);

					$num_c = $result->rowCount();

					echo("<p>$num_c client retrieved:</p>\n");
					if($num_c == 0 ){
						$result = $connection->query($add_client);
						$result = $connection->query($add_animal);	
					} else {
						//If exists in client add a new animal
						$check_animal = "SELECT * from animal WHERE VAT = '$animal_vat' and name = '$animal_name';";
						echo("<p>Query: " . $check_animal . "</p>\n");

						$result = $connection->query($check_animal);

						$num_a = $result->rowCount();
						if($num_a == 0 ){
							$result = $connection->query($add_animal);	
						}
					}
				}


				if ($num_p == 0)
					echo("<h3> New person added to the database\n</h3>");
				if ($num_c == 0)
					echo("<h3> New client added to the database\n</h3>");
				if ($num_a == 0)
					echo("<h3> New animal added to the database\n</h3>");

				echo("<form	action='checkanimal.php'	method='post'>\n  </p>\n <p><input	type='submit'	value='Go to homepage'/></p>\n </form>");
				
				$connection	=	null;
		?>
		</body>
</html>
