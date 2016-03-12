def split_show_views(line):
    line = line.strip()
    show_views = line.split(",")
    return (show_views[0], show_views[1])
