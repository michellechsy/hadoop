def split_show_channel(line):
    line = line.strip()
    show_channel = line.split(",")
    return (show_channel[0], show_channel[1])
