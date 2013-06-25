from dbapi.user import User
import template

def user(response, username):
	user = User.get('username', username)

	if response.get_secure_cookie('username') is not None:
		current_user = User.get('username', str(response.get_secure_cookie('username'), 'utf-8'))
	else:
		current_user = None

	context = {
	  	'user':user,
	    'current_user': current_user,
	    'requested_user': username
	}

	html = template.render_file('templates/profile.html', context)
	response.write(html)

def profiles(response):
	users = User.get('all')

	for user in users:
		response.write('<a href="/user/{}">{}</a><br />'.format(user.username, user.username))