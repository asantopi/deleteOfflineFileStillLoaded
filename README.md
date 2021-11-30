2021-11-30

## [OPE 5.1 Publish offline interrupted or in error]

During the "OFFLINE" publish phase of the Products catalog on the OPE a connection error occurred, stopping the publish halfway.
We are therefore in an unstable condition that can be resolved in two ways:
1) We redo the online publish of all products
2) We delete the files already published on the Database and re-publish only those not yet processed.

Since the publish is very slow and we have about 50,000 products to process, choice number 2 is mandatory.

During the publish phase, the catalog client that takes care of publishing the products on HTTP generates a log file, which contains all the files published both in SUCCESS and in Exception

Using the following scripts we can delete all files processed correctly and resubmit to publish only those in exception or not processed due to the interruption of the execution of the Catalog Client. 


Usage

Grub the catalog-client.log, for example:

- catalog-client.log
- catalog-client_2021-11-26.0.log
- catalog-client_2021-11-26.1.log

execute the "extractFileName.sh" on each log file:
```
./extractFileName.sh catalog-client.log
./extractFileName.sh catalog-client_2021-11-26.0.log
./extractFileName.sh catalog-client_2021-11-26.1.log
```

A file containing all the XML names that can be deleted will be generated in the same folder where you executed the script ---> filenameToDelete.txt
At this point it is possible to run the script to delete the files correctly processed previously.
Then execute the command to delete file still processed:

```
./deleteFileNameFromList.sh filenameToDelete.txt pathToFolderOFXmlFileToDelete/
```
Now you can run again the Offline Publish using the Catalog Client.
