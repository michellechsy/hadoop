def extract_channel_views(show_views_channel):
    show, (channel, views) = show_views_channel
    check_point = [(channel, views)]
    allBatViews = [abv[1] for abv in check_point if abv[0] == 'BAT']
    return allBatViews
