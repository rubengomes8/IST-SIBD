<html>
				<body>
<?php
$host	=	"db.ist.utl.pt";
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
$aname	=	$_GET['aname'];
$vat	=	$_GET['vat'];
$date	=	$_GET['date'];

$sqll = $connection->prepare("SELECT c.name as name, c.VAT_owner as vatt, c.date_timestamp as datee, c.VAT_client as vc, c.VAT_vet as vv, c.s as s, c.o as o, c.aa as aa, c.p as p, c.weight as wg, a.gender as gd, a.age as ag from animal a left outer join consult c on a.VAT = c.VAT_owner and a.name = c.name left outer join consult_diagnosis cd on c.name = cd.name and c.VAT_owner = cd.VAT_owner and c.date_timestamp = cd.date_timestamp left outer join prescription p on p.code = cd.code and p.name = cd.name and p.VAT_owner = cd.VAT_owner and p.date_timestamp = cd.date_timestamp where c.name = :aname and c.VAT_owner = :vat and c.date_timestamp = :date");


// -------- 

$sqll->bindParam(':aname', $aname, PDO::PARAM_STR);

$sqll->bindParam(':vat', $vat, PDO::PARAM_STR);

$sqll->bindParam(':date', $date, PDO::PARAM_STR);

$sqll->execute();

$num = $sqll->rowCount();


	//echo("<p>$num records retrieved:</p>\n");
	if($num >= 1){
		echo("<h3>Consult information</h3>");
		echo("<table border=\"1\">\n");
		echo("<tr><td>animal</td><td>vat</td><td>date</td><td>client</td><td>vet</td><td>weight</td><td>gender</td><td>age</td></tr>\n");
		
		foreach($sqll as $row)
		{
			echo("<tr><td>");
			echo($row["name"]);
			echo("</td><td>");
			echo($row["vatt"]);
			echo("</td><td>");
			echo($row["datee"]);
			echo("</td><td>");
			echo($row["vc"]);
			echo("</td><td>");
			echo($row["vv"]);
			echo("</td><td>");
			echo($row["wg"]);
			echo("</td><td>");
			echo($row["gd"]);
			echo("</td><td>");
			echo($row["ag"]);
			echo("</td>");
			echo("</tr>\n");

			
		}
		echo("</table>\n");
		$sqll->execute();
		echo("<h3>SOAP notes</h3>");
		echo("<table border=\"1\">\n");
		echo("<tr><td>subjective obs</td><td>objective obs</td><td>assessment</td><td>plan</td></tr>\n");
		foreach($sqll as $row){
			echo("<tr><td>");
			echo($row["s"]);
			echo("</td><td>");
			echo($row["o"]);
			echo("</td><td>");
			echo($row["aa"]);
			echo("</td><td>");
			echo($row["p"]);
			echo("</td>");
			echo("</tr>\n");
		}
		echo("</table>\n");

		//
		$sqlll = $connection->prepare("SELECT cd.code as cde , p.name_med as nm, p.lab as lb, p.dosage as dsg from consult_diagnosis cd, prescription p where cd.code = p.code and cd.name = p.name and cd.VAT_owner = p.VAT_owner and cd.date_timestamp = p.date_timestamp and cd.name = :aname and cd.VAT_owner = :vat and cd.date_timestamp = :date");

		$sqlll->bindParam(':aname', $aname, PDO::PARAM_STR);

		$sqlll->bindParam(':vat', $vat, PDO::PARAM_STR);

		$sqlll->bindParam(':date', $date, PDO::PARAM_STR);

		$sqlll->execute();

		$num_d = $sqlll->rowCount();
		//echo("num_diagnosiss: $num_d");

		if($num_d >= 1){

			$sqlll->bindParam(':aname', $aname, PDO::PARAM_STR);

			$sqlll->bindParam(':vat', $vat, PDO::PARAM_STR);

			$sqlll->bindParam(':date', $date, PDO::PARAM_STR);

			$sqlll->execute();

			echo("<h3>Diagnosis</h3>");
			echo("<table border=\"1\">\n");
			echo("<tr><td>diagnosis</td><td>medication</td><td>lab</td><td>dosage</td></tr>\n");
			foreach($sqlll as $row){
				echo("<tr><td>");
				echo($row["cde"]);
				echo("</td><td>");
				echo($row["nm"]);
				echo("</td><td>");
				echo($row["lb"]);
				echo("</td><td>");
				echo($row["dsg"]);
				echo("</td>");
				echo("</tr>\n");
			}
			echo("</table>\n");
		
		}
		if($num_p >= 1){
			$sql_results = $connection->prepare("SELECT indicator_name, value from produced_indicator where name = :aname and VAT_owner = :vat and date_timestamp = :date and num = :num");

			$sql_results->bindParam(':aname', $aname, PDO::PARAM_STR);

			$sql_results->bindParam(':vat', $vat, PDO::PARAM_STR);

			$sql_results->bindParam(':date', $date, PDO::PARAM_STR);

			$sql_results->bindParam(':num', $numm, PDO::PARAM_STR);

			$sql_results->execute();

			echo("<h3>Blood test results of procedure with num = $numm</h3>");

			echo("<table border=\"1\">\n");
			echo("<tr><td>indicator</td><td>indicator count</td></tr>\n");
			foreach($sql_results as $row){
				echo("<tr><td>");
				echo($row["indicator_name"]);
				echo("</td><td>");
				echo($row["value"]);				
				echo("</td>");
				echo("</tr>\n");
			}
			echo("</table>\n");

		}
		

	} else {
		echo("<h3> This animal does not have any consult registered. </h3>\n");
	}

	/*echo("<h3>Check the existence of another animal</h3>");
	echo("<form	action='checkanimal.php'	method='post'>\n  </p>\n <p><input	type='submit'	value='Go to homepage'/></p>\n </form>");*/

	echo("<h3>Check again the consults</h3>");
	echo("<form	action='check_consults.php?aname=$aname&vat=$vat'	method='post'>\n  </p>\n <p><input	type='submit'	value='Check consults'/></p>\n </form>");
	



$connection	=	null;
?>
				</body>
</html>
