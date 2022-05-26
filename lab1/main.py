questions = {
    "Nivel de dificultate?": {"a": "Usor", "b": "Mediu", "c": "Greu"},
    "Limbaj de programare preferat?": {"a": "Python", "b": "C#", "c": "C/C++", "d": "Altele"},
    "Teme de laborator?": {"a": "Da", "b": "Nu"},
    "Lucru in echipa?": {"a": "Da", "b": "Nu"},
    "Examen final?": {"a": "Da", "b": "Nu"},
    "Prezenta obligatorie?": {"a": "Da", "b": "Nu"},
    "Evaluare pe parcurs?": {"a": "Da", "b": "Nu"}
}

package_1 = {
    "Programare bazată pe reguli": {"Nivel de dificultate?": "b",
                                    "Limbaj de programare preferat?": "d",
                                    "Teme de laborator?": "a",
                                    "Lucru in echipa?": "a",
                                    "Examen final?": "a",
                                    "Prezenta obligatorie?": "a",
                                    "Evaluare pe parcurs?": "a"},

    "Tehnici de programare pe platforma Android": {"Nivel de dificultate?": "c",
                                                   "Limbaj de programare preferat?": "c",
                                                   "Teme de laborator?": "a",
                                                   "Lucru in echipa?": "b",
                                                   "Examen final?": "a",
                                                   "Prezenta obligatorie?": "b",
                                                   "Evaluare pe parcurs?": "a"},

    "Aspecte computaţionale în teoria numerelor": {"Nivel de dificultate?": "b",
                                                   "Limbaj de programare preferat?": "c",
                                                   "Teme de laborator?": "a",
                                                   "Lucru in echipa?": "b",
                                                   "Examen final?": "a",
                                                   "Prezenta obligatorie?": "a",
                                                   "Evaluare pe parcurs?": "a"},

    "Proiectarea jocurilor": {"Nivel de dificultate?": "a",
                              "Limbaj de programare preferat?": "d",
                              "Teme de laborator?": "b",
                              "Lucru in echipa?": "a",
                              "Examen final?": "b",
                              "Prezenta obligatorie?": "a",
                              "Evaluare pe parcurs?": "b"}
}

package_2 = {
    "Psihologia comunicarii profesionale in domeniul IT-lui": {"Nivel de dificultate?": "b",
                                                               "Limbaj de programare preferat?": "d",
                                                               "Teme de laborator?": "a",
                                                               "Lucru in echipa?": "b",
                                                               "Examen final?": "a",
                                                               "Prezenta obligatorie?": "b",
                                                               "Evaluare pe parcurs?": "b"},

    "Cloud Computing": {"Nivel de dificultate?": "c",
                        "Limbaj de programare preferat?": "c",
                        "Teme de laborator?": "b",
                        "Lucru in echipa?": "b",
                        "Examen final?": "a",
                        "Prezenta obligatorie?": "a",
                        "Evaluare pe parcurs?": "b"},

    "Tehnici de ingineria limbajului natural": {"Nivel de dificultate?": "c",
                                                "Limbaj de programare preferat?": "a",
                                                "Teme de laborator?": "a",
                                                "Lucru in echipa?": "b",
                                                "Examen final?": "a",
                                                "Prezenta obligatorie?": "a",
                                                "Evaluare pe parcurs?": "a"},

    "Analiza retelelor media sociale ": {"Nivel de dificultate?": "a",
                                         "Limbaj de programare preferat?": "d",
                                         "Teme de laborator?": "b",
                                         "Lucru in echipa?": "a",
                                         "Examen final?": "b",
                                         "Prezenta obligatorie?": "b",
                                         "Evaluare pe parcurs?": "a"}
}

package_3 = {
    "Retele Petri si aplicatii": {"Nivel de dificultate?": "c",
                                  "Limbaj de programare preferat?": "d",
                                  "Teme de laborator?": "b",
                                  "Lucru in echipa?": "b",
                                  "Examen final?": "a",
                                  "Prezenta obligatorie?": "a",
                                  "Evaluare pe parcurs?": "a"},

    "Smart Card-uri şi Aplicatii": {"Nivel de dificultate?": "a",
                                    "Limbaj de programare preferat?": "d",
                                    "Teme de laborator?": "a",
                                    "Lucru in echipa?": "a",
                                    "Examen final?": "a",
                                    "Prezenta obligatorie?": "b",
                                    "Evaluare pe parcurs?": "a"},

    "Topici speciale de programare .NET": {"Nivel de dificultate?": "b",
                                           "Limbaj de programare preferat?": "b",
                                           "Teme de laborator?": "b",
                                           "Lucru in echipa?": "a",
                                           "Examen final?": "a",
                                           "Prezenta obligatorie?": "a",
                                           "Evaluare pe parcurs?": "a"}
}

user = {}


def get_user_answers():
    for question in questions:
        print(question)
        print(questions[question])
        user_answer = input("Introduceti optiunea: ")
        user[question] = user_answer
        print()


def package_option(package):
    max_score = 0
    optional_name = None
    for option in package:
        score = 0
        for value in package[option]:
            if user[value] == package[option][value]:
                score += 1
        if score > max_score:
            max_score = score
            optional_name = option
    percentage = max_score / 7 * 100
    return optional_name + " -> scorul " + str(max_score) + " (" + str(int(percentage)) + "%)"


def user_interaction():
    print("Raspundeti la urmatoarele intrebari pentru a va sugera optionalele:")
    get_user_answers()
    optional_package1 = package_option(package_1)
    optional_package2 = package_option(package_2)
    optional_package3 = package_option(package_3)
    print("Pachetul 1: " + optional_package1)
    print("Pachetul 2: " + optional_package2)
    print("Pachetul 3: " + optional_package3)


user_interaction()
