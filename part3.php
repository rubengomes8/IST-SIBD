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
	$selected_animal_name = "";
	$selected_animal_vat = "";
	$selected_consult_name = "";
	$selected_consult_vatowner = "";
	$selected_consult_timestamp = "";
	
	
	//Queries in MySQL
	$check_animal_query = "SELECT a.name, p.name, p.VAT FROM animal a, client c, person p WHERE a.VAT = c.VAT and c.VAT = p.VAT and a.name =" . $name_animal . " and a.VAT = " . $selected_animal_vat . " and p.name like '%" . $name_owner_portion ."%';";
	$show_animal_consults_query = "SELECT * FROM animal, consult WHERE animal.VAT = consult.VAT_owner and animal.name = consult.name;";
	$show_consult_info_query = "SELECT * FROM animal a, consult c, consult_diagnosis cd, precription p WHERE a.VAT = c.VAT_owner and a.name = c.name and c.VAT_owner = cd.VAT_owner and c.name = cd.name and cd.date_timestamp = c.date_timestamp and c.VAT_owner = p.VAT_owner and c.name = p.name and p.date_timestamp = c.date_timestamp;" ;
	


	//echo("<p>Query: " . $check_animal_query . "</p>\n");

	$result = $connection->query($check_animal_query);
	
	$num = $result->rowCount();

	//echo("<p>$num records retrieved:</p>\n");

	echo("<table border=\"1\">\n");
	echo("<tr><td>account_number</td><td>branch_name</td><td>balance</td></tr>\n");
	foreach($result as $row)
	{
		echo("<tr><td>");
		echo($row["a.name"]);
		echo("</td><td>");
		echo($row["p.name"]);
		echo("</td><td>");
		echo($row["p.VAT"]);
		echo("</td></tr>\n");
	}
	echo("</table>\n");
		
        $connection = null;
	
	//echo("<p>Connection closed.</p>\n");

	//echo("<p>Test completed successfully. Now you know how to connect to your MySQL database.</p>\n");

?>
</body>
</html>
