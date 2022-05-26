client('Andrei', ['Zumba', 'FullBody', 'Abs', 'Pilates','Yoga', 'Capoeira']).
client('Alex', ['FullBody', 'Cycling', 'Functional Training','Yoga', 'Pilates']).
client('Vlad', ['FullBody', 'Functional Training', 'Abs', 'Yoga']).
client('Cosmin', [ 'Abs', 'FullBody', 'Capoeira', 'Yoga']).
                                       
available_slots(['luni-10:00', 'luni-16:00','marti-12:00', 'miercuri:14:00',
                  'joi-12:00', 'joi-16:00', 'vineri-18:00', 'vineri-20:00']).

gym_capacity('Sala Aerobic', 2).
gym_capacity('Sala Fitness', 3).
gym_capacity('Sala Zumba', 4).

%Lista cu toti clientii
all_clients(ClientList):-
	findall(Name,client(Name,_),ClientList).

%Lista cu toate antrenamentele fara duplicate
all_trainings(TrainingList):-
	findall(Trainings,client(_,Trainings),NestedList),
	flatten(NestedList,FlattenedList),
	sort(FlattenedList,TrainingList).

client_count(TrainingId,ClientCount):-
	findall(Training,client(_,Training),TrainingLists),
	course_attendance(TrainingLists,TrainingId,ClientCount).

%Calculam recursiv cati clienti participa la un anumit antrenament
course_attendance([Tlist|TrainingLists],TrainingId,Count):-
	course_attendance(TrainingLists,TrainingId,Temp),
	member(TrainingId,Tlist),
	Count is Temp+1.

%Cazul in care un anumit curs nu se regaseste in lista clientului
course_attendance([_|TrainingLists],TrainingId,Count):-
	course_attendance(TrainingLists,TrainingId,Temp),
	Count is Temp.

course_attendance([],_,0).

%Afisam o solutie (daca exista)
schedule(FinalSchedule):- 
	(all_trainings(TrainingLists),
	compute_solution(TrainingLists,FinalSchedule,_) -> true 
    ;   
    writeln("Nu este nicio sala disponibila pentru activitatea de mai sus."), false).

%Procedura care calculeaza o solutie
compute_solution([Training|TrainingLists],[Slot|FinalSchedule],[RoomTime|RoomTimeList]):-
	compute_solution(TrainingLists,FinalSchedule,RoomTimeList),
	slot_validation(Training,Slot,RoomTime),
	%Verificam daca combinatia sala si slot timp a mai fost
	not(member(RoomTime,RoomTimeList)),
	isNoConflict(Slot,FinalSchedule).

compute_solution([],[],[]).
	
%Verificam conflictele
isNoConflict(Plan,[Compare|FinalSchedule]):-
	isNoConflict(Plan,FinalSchedule),
	%Comparam 2 sloturi
	compare(Plan,Compare).

isNoConflict(_,[]).

compare(Plan,Compare):-
	last(Plan,X),
	last(Compare,Y),
	X\==Y.

slot_validation(Course,[Course|Slot],Slot):-
	slot_validation([Course|Slot]).

slot_validation([Training|Rest]):-
	time_validation(Rest),
	all_trainings(TrainingList),
	member(Training,TrainingList),
	enough_space(Training,Rest).

%Verificam daca avem destul loc pentru curs
enough_space(Training,[Room|_]):-
	(client_count(Training,Count),!,
	gym_capacity(Room,Size),
	%Verificam daca avem loc in sala
	Size >= Count -> 
    format("Antrenamentul ~w se va desfasura in sala ~w\n", [Training, Room]),
	flush_output, true
    ;   client_count(Training,Count),!,
		gym_capacity(Room,Size),
        format("Antrenamentul ~w cu ~w membri si capacitatea maxima pentru ~w este ~w\n", [Training, Count, Room, Size]),
		flush_output, false).

time_validation([Room|[Slot]]):-
	findall(RoomName,gym_capacity(RoomName,_),Roomlist),
	%Verificam daca sala noastra este valida
	member(Room,Roomlist),
	available_slots(Slots),
	member(Slot,Slots).
    %format("~w la ~w\n", [Room, Slot]),
	%flush_output.

errors_for_plan(FinalSchedule,ErrorCount):-
	calculate_errors(FinalSchedule,ErrorCount).

calculate_errors([CourseSlot|FinalSchedule],ErrorCount):-
	calculate_errors(FinalSchedule,Temp),
	excess_clients(CourseSlot,Excess),
	check_conflict(CourseSlot,FinalSchedule,Conflict),
	ErrorCount is Temp + Excess + Conflict.

calculate_errors([],0).

%Cautam excesul de clienti dintr-un anumit slot
excess_clients(Slot,ExcessClients):-
	nth0(1,Slot,Room),
	nth0(0,Slot,Training),
	gym_capacity(Room,Capacity),
	client_count(Training,Clients),
	%Returnam numarul de clienti ce depasesc limita
	Clients>Capacity,
	ExcessClients is Clients-Capacity,!.

excess_clients(_,0).

check_conflict(_,[],0).

check_conflict(Slot,[Slot2|Rest],ConflictCount):-
	check_conflict(Slot,Rest,Temp),
	nth0(2,Slot,Time),
	nth0(2,Slot2,Time2),
	Time \== Time2,
	ConflictCount is Temp.
