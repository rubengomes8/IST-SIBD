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
				//Request parameters about new consult
				$aname	=	$_GET['aname'];
				$vat	=	$_GET['vat'];


				echo("<p>Animal name is: $aname");
				echo("<p>Vat is: $vat");

				$date	=	$_REQUEST['date'];
				$s	=	$_REQUEST['s'];
				$o	=	$_REQUEST['o'];
				$aa	=	$_REQUEST['aa'];
				$p	=	$_REQUEST['p'];
				$VAT_client	=	$_REQUEST['VAT_client'];
				$VAT_vet	=	$_REQUEST['VAT_vet'];
				$weight	=	$_REQUEST['weight'];
				$code	=	$_REQUEST['code'];

				//Insert consult to the database
				$add_consult = "INSERT into consult values ('$aname','$vat', '$date', '$s', '$o', '$aa', '$p', '$VAT_client', '$VAT_vet', '$weight');";

				echo("<p>Query: " . $add_consult . "</p>\n");

				$result = $connection->query($add_consult);

				//Check if diagnosis code exists in the database (diagnosis_code table).
				$check_code = "SELECT * from diagnosis_code where code = '$code';";
				$result = $connection->query($check_code);
					
				$num = $result->rowCount();

				echo("<p>$num records retrieved:</p>\n");

				//If not insert into diagnosis_code and consult_diagnosis
				if($num == 0){
					$add_code_dc = "INSERT into diagnosis_code(code) values ('$code');";

					echo("<p>Query: " . $add_code_dc . "</p>\n");

					$result = $connection->query($add_code_dc);

					$add_cd = "INSERT into consult_diagnosis values('$code', '$aname', '$vat', '$date');";

					echo("<p>Query: " . $add_cd . "</p>\n");

					$result = $connection->query($add_cd);

				} else {//If yes insert into consult_diagnosis
					$add_cd = "INSERT into consult_diagnosis values('$code', '$aname', '$vat', '$date');";

					echo("<p>Query: " . $add_cd . "</p>\n");

					$result = $connection->query($add_cd);
				}

				echo("<h2> New consult added to the database</h2>");
				echo("<form	action='checkanimal.php'	method='post'>\n  </p>\n <p><input	type='submit'	value='Go to homepage'/></p>\n </form>");
				
				$connection	=	null;
				?>
		</body>
</html>
