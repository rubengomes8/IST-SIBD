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

/*
				echo("<p>Animal name is: $aname");
				echo("<p>Vat is: $vat");*/

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
				$add_consult = $connection->prepare("INSERT into consult values (:aname,:vat, :datee, :s, :o, :aa, :p, :VAT_client, :VAT_vet, :weight)");

				$add_consult->bindParam(':aname', $aname, PDO::PARAM_STR);
				$add_consult->bindParam(':vat', $vat, PDO::PARAM_STR);
				$add_consult->bindParam(':datee', $date, PDO::PARAM_STR);
				$add_consult->bindParam(':s', $s, PDO::PARAM_STR);
				$add_consult->bindParam(':o', $o, PDO::PARAM_STR);
				$add_consult->bindParam(':aa', $aa, PDO::PARAM_STR);
				$add_consult->bindParam(':p', $p, PDO::PARAM_STR);
				$add_consult->bindParam(':VAT_client', $VAT_client, PDO::PARAM_STR);
				$add_consult->bindParam(':VAT_vet', $VAT_vet, PDO::PARAM_STR);
				$add_consult->bindParam(':weight', $weight, PDO::PARAM_STR);

				$add_consult->execute();	
				
/*
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
				}*/
				$add_cd = $connection->prepare("INSERT into consult_diagnosis values(:code, :aname, :vat, :datee)");
				$add_cd->bindParam(':code', $code, PDO::PARAM_STR);
				$add_cd->bindParam(':aname', $aname, PDO::PARAM_STR);
				$add_cd->bindParam(':vat', $vat, PDO::PARAM_STR);
				$add_cd->bindParam(':datee', $date, PDO::PARAM_STR);
				$add_cd->execute();
				s
				echo("<h2> New consult added to the database</h2>");
				echo("<form	action='checkanimal.php'	method='post'>\n  </p>\n <p><input	type='submit'	value='Go to homepage'/></p>\n </form>");
				
				$connection	=	null;
				?>
		</body>
</html>
