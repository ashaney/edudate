import pandas as pd
import json

# read in the Excel file
df = pd.read_excel('example.xlsx')

# loop through each row and generate JSON for each question
with open('example.json', 'w') as f:
    for index, row in df.iterrows():
        question = row['Question']
        option1 = row['A1']
        option2 = row['A2']
        option3 = row['A3']
        correct = row['Correct']
        json_data = '"Question": "{}", "1": {}, "2": {}, "3": {}, "correct": {}\n'.format(question, option1, option2, option3, correct)
        f.write(json_data)
