#!/usr/bin/env python
# coding: utf-8

# In[3]:


sqlCommand = """CREATE TABLE Persons (
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);"""

print(sqlCommand)


# In[4]:


import re
from pathlib import Path


# In[5]:


sqlCommand = re.sub("\n", "", sqlCommand)
token = sqlCommand.split()
for i in range(len(token)):
    print(token[i])


# In[32]:


def executionCommand(token):
    if token[0] == 'CREATE':
        token = [re.sub('[()]',"", word) for word in token]
        temp = token[3]
        token = [word for word in token if word != temp]
        for i in range(len(token)):
            if token[i] != " ":
                print(token[i])
        

        
        filename = token[2]
        path = "F:\\Documents\\Desktop\\dbms\\" + filename + ".txt"
        path2 = "F:\\Documents\\Desktop\\dbms\\" + filename + "Info.txt"
        address = Path(path)
        
        if address.is_file():
            print("file already Exist")
        else:
            f = open(path, "x")
            f.close()
            f2 = open(path2, "w")
            for i in range(3, len(token), 2):
                temp = token[i] + " " + token[i+1] + "\n"
                f2.write(temp)
            f2.close()
            print("Successfully created")
        


# In[33]:


executionCommand(token)


# In[ ]:
