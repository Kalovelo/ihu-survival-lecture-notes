# H Φάση με την XML 


## Λίγα λόγια

- Είναι υποσύνολο της SGML
- Γλώσσα περιγραφής δεδομένων
- Ανάγνωση από ανθρώπους & μηχανές

## Εφαρμογές

- Ανταλλαγή δεδομένων μεταξύ συμβατών συστημάτων
- Ηλεκτρονικό Εμπόριο 
- Web Browsers Internet (?)
- Δημιουργία νέων γλωσσών
- Διαμοιρασμός δεδομένων


## Δομή

- Χρήση \<tags attributes>\</tags>
- Case sensitive tags

## Document Type Defintion (DTD)

- Καθορίζει ένα πρότυπο για το περιεχόμενο εγγράφου XML
- Μη υποχρεωτικό
- Εσωτερικό ή εξωτερικό
- Προδιαγραφή έγγυρων tags/elements attributes

## Well-Formed vs Valid XML

Καλώς ορισμένο
- Σωστή σύνταξη

Έγκυρο
- Καλώς ορισμένο
- Συμμόρφωση με κανόνες DTD

## Παράδειγμα

\<!ELEMENT note (to, from, subject, body)>
\<!ELEMENT to (#CDATA)><!ELEMENT from (#CDATA)>
\<!ELEMENT subject (#CDATA)>
\<!ELEMENT body (#CDATA)>
\<!ELEMENT note(to+, from, subject, message*)>

|            Στοιχείο            |  Εμφανίσεις   |
| :----------------------------: | :-----------: |
|    \<!ELEMENT note (from)>     |       1       |
|     \<!ELEMENT note (to+)>     | τουλάχιστον 1 |
| \<!ELEMENT note (attachment*)> | 0 ή παραπάνω  |
| \<!ELEMENT note (attachment?)> |     0 ή 1     |

## Attributes

|    Όρισμα    |           Επεξήγηση           |                   Παράδειγμα                   |
| :----------: | :---------------------------: | :--------------------------------------------: |
|    #FIXED    |     Δήλωση σταθερής τιμής     | \<!ATTLIST organization CDATA #FIXED “IT IHU"> |
| (v1\|v2\|v3) | Επιλογή προκαθορισμένης τιμής |         \<!ATTLIST note priority (high         | standard | low) “standard"> |