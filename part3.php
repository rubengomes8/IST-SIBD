<!-- IST MySQL Connection Test -- 2015.09.19 -->

<html>
<body>
<?php

	$host="db.ist.utl.pt";	// MySQL is hosted in this machine
	$user="ist425480";	// <== replace istxxx by your IST identity
	$password="ipnr6905";	// <== paste here the password assigned by mysql_reset
	$dbname = $user;	// Do nothing here, your database has the same name as your username.

 
	$connection = new PDO("mysql:host=" . $host. ";dbname=" . $dbname, $user, $password, array(PDO::ATTR_ERRMODE => PDO::ERRMODE_WARNING));

	//echo("<p>Connected to MySQL database $dbname on $host as user $user</p>\n");

		
	//Variables
	$vat_client = "CB 46 16 95 B";
	$name_owner_portion = "Jon Arbuckle";
	$name_animal = "Garfield";
	$selected_animal_name = "Garfield";
	$selected_animal_vat = "CB 46 16 95 B";
	$selected_consult_name = "Garfield";
	$selected_consult_vatowner = "CB 46 16 95 B";
	$selected_consult_timestamp = "2018-01-31 18:00:00";
	
	
	//Queries in MySQL
	$check_animal_query = "SELECT a.name as aname, p.name as pname, p.VAT as vat FROM animal a, client c, person p WHERE a.VAT = c.VAT and c.VAT = p.VAT and a.name ='" . $name_animal . "' and a.VAT = '" . $vat_client . "' and p.name like '%" . $name_owner_portion ."%';";
	$show_animal_consults_query = "SELECT c.name as name, c.date_timestamp as date FROM animal a, consult c WHERE a.VAT = c.VAT_owner and a.name = c.name and a.name ='" . $selected_animal_name . "' and a.VAT = '" . $selected_animal_vat . "';";
	$show_consult_info_query = "SELECT c.name as name, c.VAT_owner as vat, gender, age, weight, s, o, aa, p, cd.code, name_med, lab, dosage FROM animal a, consult c, consult_diagnosis cd, prescription p WHERE a.VAT = c.VAT_owner and a.name = c.name and c.VAT_owner = cd.VAT_owner and c.name = cd.name and cd.date_timestamp = c.date_timestamp and c.VAT_owner = p.VAT_owner and c.name = p.name and p.date_timestamp = c.date_timestamp and c.name = '" . $selected_consult_name. "' and c.VAT_owner = '" . $selected_consult_timestamp. "' and c.date_timestamp = '" . $selected_consult_timestamp . "';" ;
	$sql = "select a.name, a.VAT as avat, a.age from animal a;";


	echo("<p>Query: " . $check_animal_query . "</p>\n");


	$result = $connection->query($check_animal_query);
	
	$num = $result->rowCount();

	echo("<p>$num records retrieved:</p>\n");

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
		echo("</td></tr>\n");
	}
	echo("</table>\n");
	
	
	echo("<p>Query: " . $show_animal_consults_query . "</p>\n");


	$result = $connection->query($show_animal_consults_query);
	
	$num = $result->rowCount();

	echo("<p>$num records retrieved:</p>\n");
	
	echo("<table border=\"1\">\n");
	echo("<tr><td>animal</td><td>date</td></tr>\n");
	foreach($result as $row)
	{
		echo("<tr><td>");
		echo($row["name"]);
		echo("</td><td>");
		echo($row["date"]);
		echo("</td></tr>\n");
	}
	echo("</table>\n");
	
	echo("<p>Query: " . $show_consult_info_query . "</p>\n");
	
	$result = $connection->query($show_consult_info_query);
	
	$num = $result->rowCount();

	echo("<p>$num records retrieved:</p>\n");

	echo("<table border=\"1\">\n");
	echo("<tr><td>animal</td><td>vat</td><td>gender</td><td>age</td><td>weight</td>
	<td>s</td><td>o</td><td>a</td><td>p</td><td>code</td><td>medication</td>
	<td>lab</td><td>dosage</td></tr>\n");
	foreach($result as $row)
	{
		echo("<tr><td>");
		echo($row["name"]);
		echo("</td><td>");
		echo($row["vat"]);
		echo("</td><td>");
		echo($row["gender"]);
		echo("</td><td>");
		echo($row["age"]);
		echo("</td><td>");
		echo($row["weight"]);
		echo("</td><td>");
		echo($row["s"]);
		echo("</td><td>");
		echo($row["o"]);
		echo("</td><td>");
		echo($row["aa"]);
		echo("</td><td>");
		echo($row["p"]);
		echo("</td><td>");
		echo($row["code"]);
		echo("</td><td>");
		echo($row["name_med"]);
		echo("</td><td>");
		echo($row["lab"]);
		echo("</td><td>");
		echo($row["dosage"]);
		echo("</td></tr>\n");
	}
	echo("</table>\n");
		
        $connection = null;
	
	//echo("<p>Connection closed.</p>\n");

	//echo("<p>Test completed successfully. Now you know how to connect to your MySQL database.</p>\n");

?>
</body>
</html>
