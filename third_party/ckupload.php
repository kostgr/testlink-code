<?php

/* Inspiriert durch: https://www.paulfp.uk/blog/2010/10/how-to-add-and-upload-an-image-using-ckeditor/ */

require_once('../config.inc.php');

/* Nimmt die durch den Editor hochgeladenen Bilddateien entgegen und speichert sie im Dateisystem. 
    Dank an: https://www.paulfp.uk/blog/2010/10/how-to-add-and-upload-an-image-using-ckeditor/
	SL 16.05.2017
    */

$filename = time()."_".$_FILES['upload']['name'];

/* Leider muss hier mit absoluten Pfaden (innerhalb des "htdocs") gearbeitet werden, da das aktuelle Arbeitsverzeichnis sich 
    zwischen Firefox und IE, Chrome zu unterscheiden scheint. In erstem befinden wir uns bereits innerhalb des "testlink"-Verzeichnis
	und könnten das darin befindliche "upload" auch als "upload/" ansprechen. Bei letzteren beiden Browsern befinden wir uns zwei 
	Ebenen tiefer und müssten somit "../../upload/" verwenden.
	SL 16.05.2017 */
//$url = '/var/testlinktest/upload_area/'.time()."_".$_FILES['upload']['name'];
$url = '/testlink-code/upload_area/'. $filename;


 //extensive suitability check before doing anything with the file…
    if (($_FILES['upload'] == "none") OR (empty($_FILES['upload']['name'])) )
    {
       $message = "No file uploaded.";
    }
    else if ($_FILES['upload']["size"] == 0)
    {
       $message = "The file is of zero length.";
    }
    else if (($_FILES['upload']["type"] != "image/pjpeg") AND ($_FILES['upload']["type"] != "image/jpeg") AND ($_FILES['upload']["type"] != "image/png"))
    {
       $message = "The image must be in either JPG or PNG format. Please upload a JPG or PNG instead.";
    }
    else if (!is_uploaded_file($_FILES['upload']["tmp_name"]))
    {
       $message = "You may be attempting to hack our server. We're on to you; expect a knock on the door sometime soon.";
    }
    else {
      $message = "";
      $move = @ move_uploaded_file($_FILES['upload']['tmp_name'], $g_repositoryPath . $filename);
      if(!$move)
      {
         $message = "Error moving uploaded file. Check the script is granted Read/Write/Modify permissions.";
      }
    }
$funcNum = $_GET['CKEditorFuncNum'] ;
echo "<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction($funcNum, '$url','$message');</script>";


?>
