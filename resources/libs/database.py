from robot.api.deco import keyword
from pymongo import MongoClient
import bcrypt

client = MongoClient('mongodb+srv://qa:qualidade@cluster0.zbzm1p3.mongodb.net/?retryWrites=true&w=majority')

db = client['markdb']

@keyword('Remove user from database')
def remove_user(email):
  users = db['users']
  users.delete_many({'email': email})
  print('Removing user by ' + email)

@keyword('Remove task from database')
def remove_task(email, task):
  users=db['users']
  tasks=db['tasks']
  user = users.find({'email': email})
  delete_task = tasks.find({'name':task})
  
  if delete_task and user:
    tasks.delete_one({'name': task})
  print('Removind task by ' + task)

@keyword('Insert user from database')
def insert_user(user):
  hash_pass = bcrypt.hashpw(user['password'].encode('utf-8'), bcrypt.gensalt(8))
  doc = {
    'name': user['name'],
    'email': user['email'],
    'password': hash_pass
  }
  
  users = db['users']
  users.insert_one(doc)
  #print(user)
  print(f'Insert user {user}')