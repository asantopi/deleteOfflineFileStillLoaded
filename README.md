2021-11-30

test

[OPE 5.1 Publish offline issue - publish effettuata con Catalog Client]

Durante la fase di publish "OFFLINE" del catalogo Prodotti sull'OPE si è verificato un errore di connessione interrompendo la publish a metà.
Siamo quindi in una condizione instabile che può essere risolta in due modi:
1) Rifacciamo la publish on-line di tutti i prodotti
2) Cancelliamo i file già pubblicati sul Database e rieseguiamo la publish solo di quelli ancora non elaborati.

Siccome la publish è molto lenta ed abbiamo circa 50000 prodotti da elaborare la scelta numero 2 è obbligatoria.

Durante la fase di publish il catalog client che si occupa della pubblicazione dei prodotti su HTTP genera un file di log, che contiene tutti i file pubblicati sia in SUCCESS che in Exception
Usando i seguenti script possiamo cancellare tutti i file elaborati correttamente e risottomettere alla publish solo quelli in exception o non elaborati a causa dell'interruzione dell'esecuzione del Catalog Client.

=======================
Uso

Recuperare i log del catalog client. Per esempio:

- catalog-client.log
- catalog-client_2021-11-26.0.log
- catalog-client_2021-11-26.1.log

eseguire su ogni file di log lo script di recupero file elaborati "extractFileName.sh".

- ./extractFileName.sh catalog-client.log
- ./extractFileName.sh catalog-client_2021-11-26.0.log
- ./extractFileName.sh catalog-client_2021-11-26.1.log

Verrà generato nella stessa cartella un file contenete tutti i nomi degli XML che potranno essere cancellati ---> filenameToDelete.txt

A questo punto posizionarsi nella cartella dove sono presenti i file xml dei prodotti da caricare e copiare sia il file filenameToDelete.txt che lo script sh deleteFileNameFromList.sh

eseguire quindi il comando di cancellazione dei file superflui 

./deleteFileNameFromList.sh filenameToDelete.txt


ed infine eseguire nuovamente la procedura della publish con i rimanenti files
