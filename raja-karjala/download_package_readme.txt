Raja-Karjalan korpus (8.12.2017)

Aineiston lisenssi on CLARIN RES ... (urn:nbn:fi:...)
Lisätietoa aineistosta: urn:nbn:fi...

Tämä kansio sisältää Raja-Karjalan korpuksen. Korpus käsittää haastatteluja
kuudelta eri pitäjältä, jotka kaikki ovat omissa erillissä alikansioissaan.
Jokainen näistä pitäjäkohtaisista alikansioista sisältää kolme erillistä
kansiota; *_textgrid (pitäjäkohtaiset lausumatason TextGrid-tiedostot
(UTF-8)), *_txt (pitäjäkohtaiset litteraatio–txt-tiedostot (UTF-8)) sekä
*_wav (pitäjäkohtaiset äänitiedostot).

TextGrid-tiedostojen tyyppi: UTF-8 Unicode C++ program text[, with very long lines]
Litteraatiotiedostojen tyyppi: UTF-8 Unicode (with BOM) text[, with very long lines], with CRLF line terminators
Äänitiedostojen tyyppi: RIFF (little-endian) data, WAVE audio, Microsoft PCM, 16 bit, mono 44100 Hz

Tiedostojen nimeämiskäytäntö:

{Pitäjä}/{pitäjä}_{wav|txt|textgrid}/{Pitäjä}_{TUNNISTE}_{SKNA}_{NAUHA}.{wav|txt|TextGrid}

{Pitäjä}: Keruupaikkakunnan nimi (ilman ääkkösiä), esim. Korpiselka
{pitäjä}: Keruupaikkakunnan nimi pienellä alkukirjaimella (ilman ääkkösiä), esim. korpiselka
{wav|txt|textgrid}: Hakemiston sisältämien tiedostojen tyyppi

{TUNNISTE}: Tiedoston tunniste, joka koostuu

	    - pitäjäkohtaisesta informantin tunnuksesta (numero)
	    - informantin sukupuolesta (m=mies, n=nainen)
	    - informanttikohtaisesta näytteen tunnuksesta (iso kirjain), jos samalta informantilta on useita näytteitä
	    
	    Jos tiedostossa on useampi informantti, heidät on erotettu alaviivalla.

	    Esim. "05mC":       pitäjän informantin 05 (mies) näyte C
	          "08nB_09nB":  pitäjän informantin 08 (nainen) näyte B sekä
		  		pitäjän informantin 09 (nainen) näyte B

{SKNA}: Suomen kielen nauhoitearkiston tunniste (signum), esim. "SKNA_7439"
{NAUHA}: Kelanauhan tunniste, esim. "2b"
{wav|txt|TextGrid}: Tiedoston tyyppi


Kielivara sisältää henkilötietoja.

https://www.kielipankki.fi
kielipankki@csc.fi

