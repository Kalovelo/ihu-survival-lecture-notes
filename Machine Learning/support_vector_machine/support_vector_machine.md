# Support Vector Machine

|                         Διανύσματα υποστήριξης                         |                                  Υπόλοιπα                                  |
| :--------------------------------------------------------------------: | :------------------------------------------------------------------------: |
|                    γνωστά και ως **Οριακά πρότυπα**                    |                       γνωστά και ως **καλά πρότυπα**                       |
| Πρότυπα x για τα οποία ισχύει<br/> <img src="./images/support_vector.JPG"/> | Πρότυπα x για τα οποία ισχύει:<br/> <img src="./images/svm_simple_vectors.JPG"> |
|                       βρίσκονται πάνω στο margin                       |                         βρίσκονται πέρα από margin                         |
|            <img src="./images/svm_support_vectors_map.JPG">            |              <img src="./images/svm_simple_vectors_map.JPG">               |
|                                  λ>0                                   |                                    λ=0                                     |

<br/>
<br/>

## Δυικό Πρόβλημα

Υπολογίζουμε τα βάρη **w** με βάση:  

<img src="./images/dual_problem_weights.jpg">

όπου στην ουσία ψάχνουμε το **λ** το οποίο βρίσκεται από τον τύπο 

<img src="./images/minimum_lamda.jpg">

<br/>
<br/>

| Σύμβολο |                            Επεξήγηση                            |
| :-----: | :-------------------------------------------------------------: |
|    Q    | Εσωτερικό γινόμενο διανυσμάτων<br/> <img src="./images/Q.JPG"/> |
|    g    |                    Διάνυσμα με τιμές **-1**                     |
|    λ    |                       Lagrange Multiplier                       |

<br/>
<br/>
<br/>


### Πόλωση

|                                                                                                                  |                                       |
| :--------------------------------------------------------------------------------------------------------------: | :-----------------------------------: |
|                                          Για τη βέλτιστη πόλωση ισχύει:                                          | <img src="./images/optimal_bias.JPG"> |
| Αλλά, για λόγους αριθμητικής ακρίβειας ισχύει όπου έχουμε το **μέσο όρο** για όλα τα **διανύσματα υποστήριξης**. |  <img src="./images/mean_bias.JPG">   |



### Μη γραμμικά διαχωρίσιμα προβλήματα

Εισαγωγή σε κάθε πρότυπο μια μεταβλητή χαραλότητας **ξ** (slack variable)

<img src="./images/insert_slack_variable.jpg">

και ισχυέι ότι το άθροισμα των ξ > πλήθος λάθος ταξινομημένων προτύπων

Το ξ πρακτικά μας δείχνει **πόσο** το πρότυπο έχει **παραβιάσει το margin**.

#### Θέση του ξ

<img src="./images/ksi.JPG">

#### Νέα συνάρτηση Κόστους

<img src="./images/new_cost_function.JPG">

όπου η C είναι μια σταθερά κόστους για την οποία ισχύει:  
Όσο μικρότερη, τόσο αγνοώ τις μεταβλητές χαλαρότητας, άρα το σύστημα δεν πιέζεται για τη βελτιστοποίηση της ταξινόμησης.

Και σκοπός είναι να ικανοποιούνται οι ανισότητες :  

<img src="./images/new_cost_function2.JPG">

#### Τιμές του λ

- Αν x κάτω από το margin τότε C=λ (κακό πρότυπο)
- Αν x πάνω στο margin τότε C>λ>0 (οριακό πρότυπο)
- Αν x πάνω από margin τότε λ=0 (καλό πρότυπο)

<img src="./images/value_of_lamda.JPG">



### Δυικό πρόβλημα vs Νέο Δυικό Πρόβλημα

|                                                     Δυικό                                                     |                                                Νέο Δυικό                                                 |
| :-----------------------------------------------------------------------------------------------------------: | :------------------------------------------------------------------------------------------------------: |
|   καλό πρότυπο <span style="color:green">(κοινό)</span> <br/> <img src="./images/svm_simple_vectors.JPG"/>    | καλό πρότυπο <span style="color:green">(κοινό)</span> <br/> <img src="./images/svm_simple_vectors.JPG"/> |
|     οριακό πρότυπο <span style="color:green">(κοινό)</span><br/><img src="./images/support_vector.JPG"/>      |  οριακό πρότυπο <span style="color:green">(κοινό)</span><br/> <img src="./images/support_vector.JPG"/>   |
|                                                       -                                                       |                            κακό πρότυπο <br/> <img src="./images/bad_vectors.JPG"/>                            |
| βέλτιστο διάνυσμα <span style="color:green">(κοινό)</span><br/> <img src="./images/dual_problem_weights.jpg"> | βέλτιστο διάνυσμα <span style="color:green">(κοινό)</span> <br/><img src="./images/dual_problem_weights.jpg"> |
|      βέλτιστη πόλωση <span style="color:green">(κοινό)</span> <br/><img src="./images/optimal_bias.jpg">      |  βέλτιστη πόλωση  <span style="color:green">(κοινό)</span> <br/> <img src="./images/optimal_bias.jpg">   |
|      Ελάχιστο συνάρτησης <span style="color:green">(κοινό)</span> <br/><img src="./images/minimum_lamda.jpg">      |  Ελάχιστο συνάρτησης  <span style="color:green">(κοινό)</span> <br/> <img src="./images/minimum_lamda.jpg">   |
|      Τιμή του λ <span style="color:red">!!!</span> <br/> <img src="./images/dual_lamda_limitations.jpg">      | Τιμή του λ <span style="color:red">!!!</span> <br/> <img src="./images/new_dual_lamda_limitations.jpg">  |