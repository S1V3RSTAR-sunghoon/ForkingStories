import template
from dbapi.user import User

def index(response):
    username = response.get_secure_cookie('username')
    if username is not None:
        context = {'current_user':User.find('username', str(username, 'utf-8'))[0]}
    else:
        context = {'current_user':None}

    html = template.render_file('templates/index.html', context)
    response.write(html)