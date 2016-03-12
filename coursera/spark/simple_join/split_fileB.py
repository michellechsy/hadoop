def split_fileB(line):
    line = line.strip()
    date_word_count = line.split(",")
    date_word = date_word_count[0].split()
    return (date_word[1], date_word[0] + " " + date_word_count[1])
