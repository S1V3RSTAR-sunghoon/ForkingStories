# import logging
import template
from dbapi import conn
from dbapi.story import Story
from dbapi.user import User
from collections import defaultdict
from search import search, create_table, load_index

create_table(conn, if_exists=False)

random = 'rnd'

# <div>
#     <form id="storysortbox">
#         <select name="sort">
#             <option>
#                 Title: A-Z
#             </option>
#             <option>
#                 Title: Z-A
#             </option>
#             <option>
#                 Most Likes
#             </option>
#             <option>
#                 Most Views
#             </option>
#         </select>
#         <input type="submit" value="Sort">
#     </form>
#     <form id="searchbox" method="POST">
#         <input type="search" name="storyquery" placeholder="Search">
#         <input type="submit" value="Search">
#     </form>
# </div>


def search_results(response):
    context = defaultdict()

    user = response.get_secure_cookie('username')
    stories = Story.find('all', '')

    try:
        context.update({
            'current_user': User.find('username', str(user, 'utf-8'))[0]})
    except TypeError:
        context.update({
            'current_user': None})

    cursor = conn.cursor()

    if response.get_arguments('storyquery') != []:
        query = response.get_argument('storyquery')
        results = search(cursor, conn, query)
        stories = []
        for result in results:
            stories.append(Story.find('id', int(result[0]))[0])

        context['stories'] = stories
        context['query'] = query
        context['story'] = ''

        assert 'query' in context
        print("QUERY", repr(query))
        html = template.render_file('templates/storylist.html', context)
        # html = template.render_file('templates/minimal.html', context)
        response.write(html)

    elif response.get_arguments('sort') != []:
        # filter logic here
        pass
    else:
        context['stories'] = stories
        context['story'] = None
        html = template.render_file('templates/storylist.html', context)
        response.write(html)


def debug(response):
    # query = response.get_argument('storyquery')
    query = 'gandalf'
    response.write('{}<br/>'.format(search(conn.cursor(), conn, query)))
    index = load_index(conn.cursor(), conn)
    for doc in index:
        response.write('{};<br/>'.format(doc))
        for word in index[doc]:
            response.write('<div style="margin-left:20px;">{}; {}</div>'.format(word, index[doc][word]))
        response.write('<br/>')
