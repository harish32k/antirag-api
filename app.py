from flask import Flask, jsonify
from flask_restful import Api
from flask_jwt_extended import JWTManager

from resources.admin_login import AdminLogin
from resources.student_login import StudentLogin
from resources.add_student import AddStudent
from resources.admin_details import AdminDetails
from resources.student_details import StudentDetails
from resources.admin_students import AdminStudents


app = Flask(__name__)

#set config for jwt
app.config['PROPAGATE_EXCEPTIONS']=True
app.config['JWT_SECRET_KEY'] = 'hacktober'

#initialize api
api = Api(app)

api.add_resource(AdminLogin, '/admin-login')
api.add_resource(StudentLogin, '/student-login')
api.add_resource(AddStudent, '/add-student')
api.add_resource(AdminDetails, '/admin-details')
api.add_resource(StudentDetails, '/student-details')
api.add_resource(AdminStudents, '/admin-students')

jwt=JWTManager(app)

#return an error response if JWT is missing
@jwt.unauthorized_loader
def missing_token_callback(error):
    return jsonify({
        'error': 'authorization_required',
        "description": "Request does not contain an access token."
    }), 401

#return an error response if JWT is invalid
@jwt.invalid_token_loader
def invalid_token_callback(error):
    return jsonify({
        'error': 'invalid_token',
        'message': 'Signature verification failed.'
    }), 401


@app.route('/')
def home():
    return("<h1 style='font-family: sans-serif;'>This is an API for CBIT anti ragging utility.</h1>")

if __name__ == '__main__':
    app.run(debug=True)
