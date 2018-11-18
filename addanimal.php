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

				//Information about the animal
				$animal_vat	=	$_REQUEST['animal_vat'];
				$animal_name	=	$_REQUEST['animal_name'];
				$species_name	=	$_REQUEST['species_name'];
				$colour	=	$_REQUEST['colour'];
				$gender	=	$_REQUEST['gender'];
				$birth_year	=	$_REQUEST['birth_year'];
				$age	=	$_REQUEST['age'];//should convert this into another integer variable?

				//Check if the animal exists
				$check_animal = $connection->prepare("SELECT * from animal WHERE VAT = :animal_vat and name = :animal_name");

				$check_animal->bindParam(':animal_name', $animal_name, PDO::PARAM_STR);

				$check_animal->bindParam(':animal_vat', $animal_vat, PDO::PARAM_STR);
				
				$check_animal->execute();

				$num_a = $check_animal->rowCount();



				$num_a = $check_animal->rowCount();
				echo("<p> $num_a retrieved.</p>");
				if($num_a == 0 ){
					//Add a new animal.
					$add_animal = $connection->prepare("INSERT into animal values (:animal_name, :animal_vat, :species_name, :colour, :gender, :birth_year, :age)");
					$add_animal->bindParam(':animal_name', $animal_name, PDO::PARAM_STR);
					$add_animal->bindParam(':animal_vat', $animal_vat, PDO::PARAM_STR);
					$add_animal->bindParam(':species_name', $species_name, PDO::PARAM_STR);
					$add_animal->bindParam(':colour', $colour, PDO::PARAM_STR);
					$add_animal->bindParam(':gender', $gender, PDO::PARAM_STR);
					$add_animal->bindParam(':birth_year', $birth_year, PDO::PARAM_STR);
					$add_animal->bindParam(':age', $age, PDO::PARAM_STR);
				
					$add_animal->execute();				
					
					echo("<h3> New animal added to the database\n</h3>");
				} else {
					echo("<h3> Already in the database\n</h3>");
				}

					

				echo("<form	action='checkanimal.php'	method='post'>\n  </p>\n <p><input	type='submit'	value='Go to homepage'/></p>\n </form>");
				
				$connection	=	null;
		?>
		</body>
</html>
