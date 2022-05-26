; (deffacts fapte
; (PNP Y) (RLF N) (PIU Y)
; )

(defrule reading
=>
(printout t "Printer does not print?" crlf)
(assert (PNP (read)))
(printout t "A red light is flashing?" crlf)
(assert (RLF (read)))
(printout t "Printer is unrecognised?" crlf)
(assert (PIU (read)))
)



(defrule first_answer
(or (and (PNP Y) (RLF Y) (PIU N))
(and (PNP N) (RLF N) (PIU N))
)
=>
(printout t "Check the power cable" crlf)
)

(defrule second_answer
(PIU Y)
=>
(printout t "Check the printer-computer cable" crlf)
)

(defrule third_answer
(or (and (PNP Y) (RLF N) (PIU Y))
(and (PNP N) (RLF Y) (PIU N))
)
=>
(printout t "Ensure printer software is installed" crlf)
)

(defrule fourth_answer
(or (and (PNP Y) (RLF Y) (PIU Y))
(and (PNP Y) (RLF Y) (PIU N))
(and (PNP N) (RLF Y))
(and (PNP N) (RLF N) (PIU Y))
)
=>
(printout t "Check/replace ink" crlf)
)

(defrule fifth_answer
(or (and (PNP Y) (PIU N))
(and (PNP N) (PIU N))
)
=>
(printout t "Check for paper jam" crlf)
)

