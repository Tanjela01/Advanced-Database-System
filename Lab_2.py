import re
from pathlib import Path


def executeCommand(token):
    if token[0] == 'CREATE':
        token = [re.sub('[()]', "", word) for word in token]
        temp = token[3]
        token = [word for word in token if word != temp]

        filename = token[2]
        path = "F:\\Documents\\Desktop\\dbms\\" +filename + ".txt"
        path2 ="F:\\Documents\\Desktop\\dbms\\" + filename + "Info.txt"
        address = Path(path)

        if address.is_file():
            print("File Already Exists")
        else:
            f = open(path, "x")
            f.close()
            f2 = open(path2, "w")

            for i in range(3, len(token), 2):
                temp = token[i] + " " + token[i+1] + "\n"
                f2.write(temp)
            
            f2.close()
            print("CREATE Successful")

    elif token[0] == 'INSERT':
        token = [re.sub('[()]', "", word) for word in token]
        temp = token[3]
        attr = []
        ValuesInd = -1
        token = [word for word in token if word != temp]
        
        for i in range(3, len(token)):
            if token[i] == "VALUES":
                ValuesInd = i
                break
            if token[i] != " ":
                attr.append(token[i])

        attr = [item.replace(',', '') for item in attr]

        filename = token[2]
        path = "F:\\Documents\\Desktop\\dbms\\" + filename + ".txt"
        path2 = "F:\\Documents\\Desktop\\dbms\\" + filename + "Info.txt"

        all_attr = []

        with open(path2, 'r') as file:
            for line in file:
                words = line.split()

                first_word = words[0]
                all_attr.append(first_word)

        token = [item.replace("'", '') for item in token]
        token = [item.replace(';', '') for item in token]
        token = [item.replace(',', '') for item in token]

        all_present = all(elem in all_attr for elem in attr)
        vals = ""

        if all_present:
            temp_list = []
            
            for i in range(ValuesInd+1, len(token)):
                if token[i] != "":
                    vals = vals + token[i] + "#"

            with open(path, 'a') as file:
                file.write(vals + '\n')

            print("INSERT Succesfull")
        
        else:
            print("Attribute Not Found!")

    elif token[0] == 'SELECT':
        print(token)
        # return
        if token[1] == '*' and token[4] == 'WHERE':
            pass
        elif token[1] == '*':
            token = [item.replace(';', '') for item in token]
            filename = token[3]
            path = filename + ".txt"
            path2 = filename + "Info.txt"

            all_attr = []

            with open(path2, 'r') as file:
                for line in file:
                    words = line.split()
                    first_word = words[0]
                    all_attr.append(first_word)

            col_width = 12
            no_of_attr = len(all_attr)

            header = ' | '.join([f'{attr:<{col_width}}' for attr in all_attr])
            print(header)

            separator = '-+-'.join(['-' * col_width] * no_of_attr)

            print(separator)

            with open(path, 'r') as file:
                for line in file:
                    all_values = []
                    words = line.split('#')
                    words.pop()

                    for word in words:
                        all_values.append(word)
                    
                    values = ' | '.join(
                        f'{value:<{col_width}}' for value in all_values)
                    
                    print(values)
            
            print(separator)

        else:
            print("Not Supported Yet")


####### Call #######

sqlCommand1 = """CREATE TABLE Persons (
  PersonID int,
  LastName varchar(255),
  FirstName varchar(255),
  Address varchar(255),
  City varchar(255),
  Salary int
);"""

sqlCommand2 = """INSERT INTO Persons (
  PersonID, LastName, FirstName, Address, City
  )
VALUES (
  '104', 'Anam', 'Ifti', 'Banasree', 'Dhaka', '90'
  );
);"""

sqlCommand3 = """SELECT * FROM Persons;"""

sqlCommand4 = """SELECT * FROM Persons WHERE Salary > 100;"""

sqlCommand = re.sub("\n", "", sqlCommand3)
token = sqlCommand.split()

executeCommand(token)
