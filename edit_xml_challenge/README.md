# Editing XML Files Challenge
### For Ken Warner, Director of Engineering, Kaplan Test Prep

A short summary of my approach to this problem:

After reviewing the instructions and documents for this challenge, I realized I would have to parse the CSV file, extract the information, and then use that information to add attributes to the particular node in the specified XML file. I used Ruby since it is the programming language I am most familiar with. In addition, it has a number of great built-in libraries as well as community authored gems that provide a lot of functionality.

My first step was to create two Ruby classes, which I called “Mappings” and “MappingsParser”. The “MappingsParser” class is initialized with the CSV file as an argument, and contains a “mappings” method that uses Ruby’s built in CSV class to parse the file and create objects from the “Mapping” class. Each row of the CSV file is turned into a Ruby object that contains the data from that row.

After that, I wrote a stand alone method called “update_xml” that is passed a single “mapping” object as an argument. It then uses the embedded data to open the corresponding XML file and turn it into a Nokogiri Ruby object (Nokogiri is a Ruby gem that you can use to manipulate XML files). Next, I find the node in that object that contains the assignment id that we want to add the difficulty level to, and then create a new “DifficultyLevel” attribute that we assign the value to. Finally, we write the changes back to the XML file.

To execute the code, I instantiate a new “MappingsParser” object and then assign to a “mappings” variable the array of mapping objects created. The final step is to iterate through this array and call the “update_xml” method on each object.






