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
				$date	=	$_GET['date'];


				echo("<p>Animal name is: $aname");
				echo("<p>Vat is: $vat");
				echo("<p>Date is: $date");

				$neutrophils= $_REQUEST['neutrophils'];
				$lymphocits	= $_REQUEST['lymphocits'];
				$monocytes	=	$_REQUEST['monocytes'];
				$white_blood_cells	=	$_REQUEST['white_blood_cells'];
				$VAT_assistant	=	$_REQUEST['VAT_assistant'];
				$num	=	$_REQUEST['num'];


				//Insert produced indicator VER DAQUI PARA BAIXO

				$add_participation = "INSERT Into participation values ('$aname', '$vat','$date', '$VAT_assistant');";

				$add_procedure = "INSERT into procedure_ values ('$aname', '$vat','$date', '$num', 'Blood test');";

				$add_performed = "INSERT into performed values ('$aname', '$vat','$date', '$num', '$VAT_assistant');";

				$add_testprocedure = "INSERT into test_procedure values ('$aname', '$vat','$date', '$num', 'Blood');";

				$add_neutrophils = "INSERT into produced_indicator values ('$aname', '$vat','$date', '$num','neutrophil','$neutrophils');";

				$add_lymphocits = "INSERT into produced_indicator values ('$aname', '$vat','$date', '$num','lymphocit','$lymphocits');";

				$add_monocytes = "INSERT into produced_indicator values ('$aname', '$vat','$date', '$num','monocyt','$monocytes');";

				$add_white_blood_cells = "INSERT into produced_indicator values ('$aname', '$vat','$date', '$num','white_blood_cell','$white_blood_cells');";

				$connection->beginTransaction();
				echo("<p> $add_participation</p>\n");
				$connection->exec($add_participation);

				echo("<p> $add_procedure</p>\n");
				$connection->exec($add_procedure);

				echo("<p> $add_performed</p>\n");
				$connection->exec($add_performed);

				echo("<p> $add_testprocedure</p>\n");
				$connection->exec($add_testprocedure);

				echo("<p> $add_neutrophils</p>\n");
				$connection->exec($add_neutrophils);

				echo("<p> $add_lymphocits</p>\n");
				$connection->exec($add_lymphocits);

				echo("<p> $add_monocytes</p>\n");
				$connection->exec($add_monocytes);

				echo("<p> $add_white_blood_cells</p>\n");
				$connection->exec($add_white_blood_cells);


				$connection->commit();
				echo("<p>Results entered successfully!</p>");


								
				$connection	=	null;
				?>
		</body>
</html>
