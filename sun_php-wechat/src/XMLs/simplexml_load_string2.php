<?php
// data
$music_database = <<<_MUSIC_
<?xml version="1.0" encoding="utf-8" ?>
    <music>
        <album id="1">
            <name>Revolver</name>
            <artist>The Beatles</artist>
        </album>
        <!-- 941 more albums here -->
        <album id="943">
            <name>Miles And Coltrane</name>
            <artist>Miles Davis</artist>
            <artist>John Coltrane</artist>
        </album>
    </music>
_MUSIC_;
// load data
$s = simplexml_load_string($music_database);
#print_r($s);
#echo "=============="."\n";
// query data
$artist = addslashes($_GET['artist']);  ###$_GET['artist']  
$query = "/music/album[artist = '$artist']";
#print_r($query);
$albums = $s->xpath($query);
print_r($albums);
// display query results as XML

print "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n";

print "<music>\n\t";
foreach ($albums as $a) {
    print $a->asXML();
}
print "\n</music>";




######=>   SimpleXMLElement Object
######=>   (
######=>       [album] => Array
######=>           (
######=>               [0] => SimpleXMLElement Object
######=>                   (
######=>                       [@attributes] => Array
######=>                           (
######=>                               [id] => 1
######=>                           )
######=>   
######=>                       [name] => Revolver
######=>                       [artist] => The Beatles
######=>                   )
######=>   
######=>               [1] => SimpleXMLElement Object
######=>                   (
######=>                       [@attributes] => Array
######=>                           (
######=>                               [id] => 943
######=>                           )
######=>   
######=>                       [name] => Miles And Coltrane
######=>                       [artist] => Array
######=>                           (
######=>                               [0] => Miles Davis
######=>                               [1] => John Coltrane
######=>                           )
######=>   
######=>                   )
######=>   
######=>           )
######=>   
######=>       [comment] => SimpleXMLElement Object
######=>           (
######=>           )
######=>   
######=>   )


?>
