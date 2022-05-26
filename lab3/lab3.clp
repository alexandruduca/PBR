(deffacts fapte_initiale
        (meniu)
)
    
(defrule afiseaza_meniu
        ?a <- (meniu)
        =>
        (retract ?a)
        (printout t "" crlf)
        (printout t "1. Citeste o lista cu valori numerice" crlf)
        (printout t "2. Afiseaza lista sortata crescator cu BubbleSort." crlf)
        (printout t "3. Adauga un element intr-o lista." crlf)
        (printout t "4. Verifica daca lista este palindrom." crlf)
        (printout t "5. Afiseaza cel mai mic si cel mai mare element dintr-o lista." crlf)
        (printout t "6. Afiseaza elementele care apar o singura data intr-o lista." crlf)
        (printout t "7. Iesire." crlf)
        (printout t "Dati optiunea: ")
        (assert (optiune(read)))
)

(defrule citire_lista
        ?a <- (optiune 1)
        =>
        (printout t "Dati lista:")
        (assert (lista (explode$ (readline))))
        (retract ?a)
        (assert (meniu))
)

(defrule BubbleSort
        ?a <- (optiune 2)
        ?lista_curenta <- (lista $?valori)
        =>
        (bind ?lungime_for1 (length$ ?valori))
        (bind ?lungime_for2 (- ?lungime_for1 1))
        (retract ?lista_curenta)
        (loop-for-count (?i 1 ?lungime_for1) do
            (loop-for-count (?j 1 ?lungime_for2) do
                (bind ?valoare_1 (nth$ ?j $?valori))
                (bind ?valoare_2 (nth$ (+ ?j 1) $?valori))
                (if (> ?valoare_1 ?valoare_2) then
                    (bind $?valori (replace$ $?valori ?j ?j ?valoare_2))
                    (bind $?valori (replace$ $?valori (+ ?j 1) (+ ?j 1) ?valoare_1))
                )
                (printout t "Schimbare: " $?valori crlf)
            )
        )
        (assert (lista $?valori))
        (printout t "Lista sortata: " $?valori crlf)
        (retract ?a)
        (assert (meniu))
)

(defrule adauga_element
        ?a <- (optiune 3)
        ?lista_curenta <- (lista $?valori)
        =>
        (retract ?lista_curenta)
        (printout t "Introduceti elementul: ")
        (bind ?element (read))
        (assert (lista $?valori ?element))
        (retract ?a)
        (assert (meniu))
)

(defrule verifica_palindrom
        ?a <- (optiune 4)
        ?lista_curenta <- (lista $?valori)
        =>
        (bind ?lungime (length$ ?valori))
        (bind ?lungime_1 (+ ?lungime 1))
        (bind ?lista_inversa (create$))
        (loop-for-count (?i 1 ?lungime) do
            (bind ?element (nth$ (- ?lungime_1 ?i) $?valori))
            (bind $?lista_inversa (insert$ $?lista_inversa (+ (length$ $?lista_inversa) 1) ?element))
        )
        (bind ?flag (length$ ?valori))
        (loop-for-count (?i 1 ?lungime) do
            (bind ?valoare_lista_curenta (nth$ ?i $?valori))
            (bind ?valoare_lista_inversa (nth$ ?i $?lista_inversa))
            (if (neq ?valoare_lista_curenta ?valoare_lista_inversa) then
                (printout t "Nu este palindrom" crlf)
                (bind ?flag ?i)
                (break)
            )
        )
        (if (eq ?flag ?lungime) then
            (printout t "Palindrom" crlf)
        )
        (retract ?a)
        (assert (meniu))
)

(defrule mini_maxi
    ?a <- (optiune 5)
    ?lista_curenta <- (lista $?valori)
    =>
    (bind ?lungime (length$ ?valori))
    (bind ?mini (nth$ 1 $?valori))
    (bind ?maxi (nth$ ?lungime $?valori))
    (printout t "Elementul cel mai mic: " $?mini crlf)
    (printout t "Elementul cel mai mare: " $?maxi crlf)
    (retract ?a)
    (assert (meniu))
)

(defrule elemente_unice
    ?a <- (optiune 6)
    ?lista_curenta <- (lista $?valori)
    =>
    (bind ?lungime_1 (length$ ?valori))
    (bind ?lungime (- ?lungime_1 1))
    (bind ?lista_elemente_unice (create$))
    (printout t "Elementele unice din lista sunt: ")
    (bind ?primul_element (nth$ 1 $?valori))
    (bind ?al_doilea_element (nth$ 2 $?valori))
    (if (neq ?primul_element ?al_doilea_element) then
        (printout t " " $?primul_element)
    )

    (loop-for-count (?i 2 ?lungime) do
        (bind ?valoare_1 (nth$ (- ?i 1) $?valori))
        (bind ?valoare_2 (nth$ ?i $?valori))
        (bind ?valoare_3 (nth$ (+ ?i 1) $?valori))
        
        (if (neq ?valoare_1 ?valoare_2) then
            (if (neq ?valoare_2 ?valoare_3) then
                (printout t " " $?valoare_2)
            )
        )
    )
    (bind ?ultimul_element (nth$ ?lungime_1 $?valori))
    (bind ?penultimul_element (nth$ ?lungime $?valori))
    (if (neq ?ultimul_element ?penultimul_element) then
        (printout t " " $?ultimul_element)
    )
    (printout t "" crlf)
    (retract ?a)
    (assert (meniu))
)

(defrule iesire
        ?a <- (optiune 7)
        =>
        (retract ?a)
        (assert (optiune))
)