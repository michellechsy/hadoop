def split_fileA(line):
    # split the input line in word and count on the comma
    line = line.strip()
    split_lines = line.split(",")

    # turn the count to an integer  
    
    return (split_lines[0], int(split_lines[1]))
