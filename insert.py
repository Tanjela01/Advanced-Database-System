from pathlib import Path

sql_command = """CREATE TABLE Persons (
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);"""


def execute_sql(sql_command):

    sql_command = sql_command.strip()
    tokens = sql_command.split()

    if tokens[0] == 'CREATE':

        table_name = tokens[2]
        columns = [
            f"{tokens[i]} {tokens[i+1]}" for i in range(3, len(tokens), 2)
        ]

        table_path = f"F:\\Documents\\Desktop\\dbms\\ {table_name}.txt"

        if Path(table_path).is_file():
            print(f"Table '{table_name}' already exists")
        else:

            with open(table_path, "x"):
                pass

            with open(f"F:\\Documents\\Desktop\\dbms\\{table_name}Info.txt", "w") as f2:
                f2.write("\n".join(columns))
            print(f"Table '{table_name}' created successfully")

    elif tokens[0] == 'INSERT':

        table_name = tokens[2]
        values_start = sql_command.find("VALUES") + 6
        values = sql_command[values_start:].strip()

        table_path = f"F:\\Documents\\Desktop\\dbms\\{table_name}.txt"

        if Path(table_path).is_file():

            with open(table_path, "a") as table_file:
                table_file.write(values + '\n')
            print(f"Data inserted into table '{table_name}'")
        else:
            print(f"Table '{table_name}' does not exist")

    else:

        print("Unsupported SQL command")


sql_command_with_insert = """INSERT INTO Persons (PersonID, LastName, FirstName, Address, City) VALUES
(1, 'zila' 'tan', '345 tani ML', 'Berlin'),
(2, 'si', 'amles', '683 sim', 'Denmark');"""


execute_sql(sql_command_with_insert)