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

/*
				echo("<p>Animal name is: $aname");
				echo("<p>Vat is: $vat");
				echo("<p>Date is: $date");*/

				$neutrophils= $_REQUEST['neutrophils'];
				$lymphocits	= $_REQUEST['lymphocits'];
				$monocytes	=	$_REQUEST['monocytes'];
				$white_blood_cells	=	$_REQUEST['white_blood_cell'];
				$VAT_assistant	=	$_REQUEST['VAT_assistant'];
				$num	=	$_REQUEST['num'];




				//---------------------------------
				try{
				$connection->beginTransaction();

				$add_participation = $connection->prepare("INSERT Into participation values (:aname, :vat, :datee, :VAT_assistant)");
				
				$add_participation->bindParam(':aname', $aname, PDO::PARAM_STR);
				$add_participation->bindParam(':vat', $vat, PDO::PARAM_STR);
				$add_participation->bindParam(':datee', $date, PDO::PARAM_STR);
				$add_participation->bindParam(':VAT_assistant', $VAT_assistant, PDO::PARAM_STR);

				$add_participation->execute();
				
				//--

				$add_procedure = $connection->prepare("INSERT into procedure_ values (:aname, :vat,:datee, :num, 'Blood test')");

				$add_procedure->bindParam(':aname', $aname, PDO::PARAM_STR);
				$add_procedure->bindParam(':vat', $vat, PDO::PARAM_STR);
				$add_procedure->bindParam(':datee', $date, PDO::PARAM_STR);
				$add_procedure->bindParam(':num', $num, PDO::PARAM_INT);

				$add_procedure->execute();

				//--
				

				$add_performed = $connection->prepare("INSERT into performed values (:aname, :vat,:datee, :num, :VAT_assistant)");

				$add_performed->bindParam(':aname', $aname, PDO::PARAM_STR);
				$add_performed->bindParam(':vat', $vat, PDO::PARAM_STR);
				$add_performed->bindParam(':datee', $date, PDO::PARAM_STR);
				$add_performed->bindParam(':num', $num, PDO::PARAM_INT);
				$add_performed->bindParam(':VAT_assistant', $VAT_assistant, PDO::PARAM_STR);

				$add_performed->execute();
				
				//--

				$add_testprocedure = $connection->prepare("INSERT into test_procedure values (:aname, :vat,:datee, :num, 'Blood')");

				$add_testprocedure->bindParam(':aname', $aname, PDO::PARAM_STR);
				$add_testprocedure->bindParam(':vat', $vat, PDO::PARAM_STR);
				$add_testprocedure->bindParam(':datee', $date, PDO::PARAM_STR);
				$add_testprocedure->bindParam(':num', $num, PDO::PARAM_INT);
				$add_testprocedure->bindParam(':VAT_assistant', $VAT_assistant, PDO::PARAM_STR);

				$add_testprocedure->execute();

				//--

				$add_neutrophils = $connection->prepare("INSERT into produced_indicator values (:aname, :vat,:datee, :num,'neutrophil',:neutrophils)");

				$add_neutrophils->bindParam(':aname', $aname, PDO::PARAM_STR);
				$add_neutrophils->bindParam(':vat', $vat, PDO::PARAM_STR);
				$add_neutrophils->bindParam(':datee', $date, PDO::PARAM_STR);
				$add_neutrophils->bindParam(':num', $num, PDO::PARAM_INT);
				$add_neutrophils->bindParam(':neutrophils', $neutrophils, PDO::PARAM_STR);

				$add_neutrophils->execute();

				//--

				$add_lymphocits = $connection->prepare("INSERT into produced_indicator values (:aname, :vat,:datee, :num,'lymphocit',:lymphocits)");

				$add_lymphocits->bindParam(':aname', $aname, PDO::PARAM_STR);
				$add_lymphocits->bindParam(':vat', $vat, PDO::PARAM_STR);
				$add_lymphocits->bindParam(':datee', $date, PDO::PARAM_STR);
				$add_lymphocits->bindParam(':num', $num, PDO::PARAM_INT);
				$add_lymphocits->bindParam(':lymphocits', $lymphocits, PDO::PARAM_STR);

				$add_lymphocits->execute();

				//--

				$add_monocytes = $connection->prepare("INSERT into produced_indicator values (:aname, :vat,:datee, :num,'monocyt',:monocytes)");

				$add_monocytes->bindParam(':aname', $aname, PDO::PARAM_STR);
				$add_monocytes->bindParam(':vat', $vat, PDO::PARAM_STR);
				$add_monocytes->bindParam(':datee', $date, PDO::PARAM_STR);
				$add_monocytes->bindParam(':num', $num, PDO::PARAM_INT);
				$add_monocytes->bindParam(':monocytes', $monocytes, PDO::PARAM_STR);

				$add_monocytes->execute();

				//--

				$add_white_blood_cells = $connection->prepare("INSERT into produced_indicator values (:aname, :vat,:datee, :num,'white blood cell',:white_blood_cells)");

				$add_white_blood_cells->bindParam(':aname', $aname, PDO::PARAM_STR);
				$add_white_blood_cells->bindParam(':vat', $vat, PDO::PARAM_STR);
				$add_white_blood_cells->bindParam(':datee', $date, PDO::PARAM_STR);
				$add_white_blood_cells->bindParam(':num', $num, PDO::PARAM_INT);
				$add_white_blood_cells->bindParam(':white_blood_cells', $white_blood_cells, PDO::PARAM_STR);

				$add_white_blood_cells->execute();

				$connection->commit();

				echo("<h3>Results entered successfully!</h3>");
			} catch(Exception $e){
				echo $e->getMessage();
				$connection->rollBack();
			}

				echo("<h3>Check the consults</h3>");
				echo("<form	action='check_consults.php?aname=$aname&vat=$vat'	method='post'>\n  </p>\n <p><input	type='submit'	value='Check consults'/></p>\n </form>");

				echo("<h3>Check the existence of another animal</h3>");
				echo("<form	action='checkanimal.php'	method='post'>\n  </p>\n <p><input	type='submit'	value='Go to homepage'/></p>\n </form>");	
				$connection	=	null;
				?>
		</body>
</html>
