/*
Basic xml parser for the xml generated by the flickr api and will seach and repleace in a doc with the name of the images in flicker
Creates a file with the url to each image in the album, 
includes html lmg tags, and the original names of the 
images as alt info inside the tag.
How to use:
1. Upload images to an album/photosets on flickr/ or select an exiting one
2. Go to the apicall url page
3. Fill in the 3 first arguments values with the following
 - photoset_id= the album/photoset id, recent ones of your own are shown to the right under "Useful Values"
 - user:id= user id of the album owner, if its your own one then the id is listed to the right.
 - extras= "original_format" <-- This is needed if the images are png.files
4. Use the output "XML(REST)" and the sign call wont matter of the owner of the album has not chosen to hide the album.
5. Click "Call Method.." and the XML is generated in the window underneath
6.Select and copy everything in the photoset tag
7. Open the xml.xml file in the date folder of this sketch, paste the xml code into the file and save
8. In the data folder put whatever file you and to be seached and repleaced 
9. Update toLoad to the name of the file needed.
10. Run the sketch and look for the updated_ file in the same folder as the sketch
*/

XML xml;

PrintWriter output;
String toLoad=" "; // file name and format of the result 


String idExtra="07/09/2018";
void setup() {

  output = createWriter("updated_"+toLoad); 
  String[] lines = loadStrings(toLoad);

  xml = loadXML("xml.xml");
  XML[] children = xml.getChildren("photo");




   for (int y = 0; y < lines.length; y++) {
    for (int i = 0; i < children.length; i++) {
      String id = children[i].getString("id");
      String secret = children[i].getString("secret");
      String server = children[i].getString("server");
      String farm = children[i].getString("farm");
      String title = children[i].getString("title");

      String originalsecret = children[i].getString("originalsecret");
   //   println(id + ", " + secret + ", " + server+ ", " + farm);
      String originalformat = children[i].getString("originalformat");  
    


      if (lines[y].contains(title)) {
         //updates the existing  url with new ones
         //String[] m = match(lines[y], "img src=\"([^#][^\"]+)\" alt=\""+title+"\"");
         
        // replace the code in the text with the img url only 
        String[] m = match(lines[y], title);
        
         println(lines[y]+"_"+title);
         printArray(m);
      lines[y] = lines[y].replace(m[0], "[IMG:https://farm" + farm + ".staticflickr.com/" + server + "/" + id + "_" + originalsecret + "_o."+originalformat+"]");
        
         
      }
     
    }
     output.println(lines[y]);
  }

  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file

  exit(); // Stops the program
}
