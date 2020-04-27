<?php
$host="127.0.0.1";
$username="root";
$password="123456";
$connect=mysqli_connect($host,$username,$password,"information_schema");
// $data_tables_examples=[
//     "dbname_1"=>[
//         "table_1"=>"description",
//         "table_2"=>"",//for no description
//     ],
// ];
$data_tables=[];
$sql="SELECT
COLUMN_NAME,
DATA_TYPE,
COLUMN_TYPE,
COLUMN_COMMENT
FROM
information_schema.COLUMNS 
WHERE
table_name = ':table_name' 
AND table_schema = ':db_name'";

$tables=[];
$html="
<html>
<head>
    <title>Table Description</title>
</head>
<body>
";
foreach($data_tables as $db_name=>$db_tables){
    $html.="<h1>".$db_name."</h1>";
    foreach($db_tables as $data_table=>$table_name){
        $sql_current=str_replace(":table_name",$data_table,$sql);
        $sql_current=str_replace(":db_name",$db_name,$sql_current);
        $query=mysqli_query($connect,$sql_current);
        $tables[]=build_table(mysqli_fetch_all($query,MYSQLI_ASSOC),$data_table,$table_name);
    }
    $html.=implode("<hr />",$tables);
    $tables=[];
}


$html.="
<style>
td,th{
    border:1px solid black;
    padding: 0px 10px;
}
</style>
</body>
</html>
";
file_put_contents(dirname(__FILE__).'/table_description.html',$html);
mysqli_close($connect);

function build_table($data,$table_name,$table_comment=""){

    $html="<h2>{$table_name}".(empty($table_comment)?"":":{$table_comment}")."</h2>";
    $html.="<table>";
    $html.="<tr><th>字段名</th><th>数据类型</th><th>字段类型</th><th>备注</th></tr>";
    foreach($data as $row){
        $html.="<tr>";
        $html.="<td>".$row['COLUMN_NAME']."</td><td>".$row['DATA_TYPE']."</td><td>".$row['COLUMN_TYPE']."</td><td>".$row['COLUMN_COMMENT']."</td>";
        $html.="</tr>";
    }

    $html.="</table>";
    return $html;
}