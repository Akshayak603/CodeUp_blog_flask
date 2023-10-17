# flask framework
from flask import Flask, render_template, request, session, redirect, flash
# basically Flask is a class in flask module
from flask_sqlalchemy import SQLAlchemy
# we have a backend also if we dont pas date here it will automatically takes current timestamp in db
# but as we trying to do these things through frontend so we are using datetime here
from datetime import datetime
from werkzeug.utils import secure_filename
import os
import json
import math
# to implement mail functionality
from flask_mail import Mail

with open('config.json', 'r') as c:
    # it will be global
    params = json.load(c)["params"]

local_server = params["local_server"]

app = Flask(__name__)  # creating instance of this class
app.secret_key = 'my-secret-key'  # needed for sessions in flask
# configuring our app to use variables 
# single configuration
app.config['UPLOAD_FOLDER'] = params['upload_path']  # for uploading file
# multi configuration we can access these via app.cofig['MAIL_SERVER]
app.config.update(
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT='465',
    MAIL_USE_SSL=True,
    MAIL_USERNAME=params["gmail-username"],
    MAIL_PASSWORD=params["gmail-password"]
)
# creating mail instance
mail = Mail(app)

# Creating db connection 
if local_server:
    app.config["SQLALCHEMY_DATABASE_URI"] = params["local_uri"]
else:
    app.config["SQLALCHEMY_DATABASE_URI"] = params["prod_uri"]
# creating instance need python-sql-connector mysqlclient
db = SQLAlchemy(app)
# contact model


class Contacts(db.Model):
    '''sno,name,phone_num,msg,date,email'''
    '''by default nullable=True which means user can define null value'''
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    phone_num = db.Column(db.String(12), nullable=False)
    msg = db.Column(db.String(120), nullable=False)
    email = db.Column(db.String(20), nullable=False)
    date = db.Column(db.String(12), nullable=True)

# post model

class Posts(db.Model):
    '''sno,title,slug,subheading,content,date,img_file'''
    '''by default nullable=True which means user can define null value'''
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=False)
    slug = db.Column(db.String(25), nullable=False)
    subheading = db.Column(db.String(50), nullable=False)
    content = db.Column(db.String(500), nullable=False)
    date = db.Column(db.String(12), nullable=True)
    img_file = db.Column(db.String(50), nullable=True)

# HOME
# crating endpoint
# here @ is a decorator which is passing our below fuction to some function


@app.route('/')
def home():
    # PAGINATION
    posts = Posts.query.filter_by().all()
    last = math.ceil(len(posts)/params["no_of_posts"])  # as we want 5.6~6
    # [0:params["no_of_posts"]

    # query params
    # here we are fetching page from query as at first it will be on first page and there is a chance page might be None
    page = request.args.get('page')
    # print(type(page))

    # so to handle this we use this and set page =1
    if not str(page).isnumeric():
        page = 1
    page = int(page)
    # to show posts on each page
    posts = posts[(page-1)*int(params["no_of_posts"]):(page-1)
                  * int(params["no_of_posts"])+int(params["no_of_posts"])]

    # First page means prev=# next=page+1
    if page == 1:
        prev = "#"
        # setting query as our function will fetch the page number from query so this is the to pass query to the URL "/?urf="
        next = "/?page="+str(page+1)
    # middle prev=page-1 next=page+1
    elif page == last:
        prev = "/?page="+str(page-1)
        next = "#"
    # last prev=page-1 next=#
    else:
        prev = "/?page="+str(page-1)
        next = "/?page="+str(page+1)

    # posts= Posts.query.filter_by().all()[:params["no_of_posts"]]
    # print(type(posts[0]))
    # print(type(posts))
    # to use template we use render_template under the hood we are using JINJA2
    return render_template('Views/index.html', params=params, posts=posts, prev=prev, next=next)

# ABOUT


@app.route('/about')
def about():
    # to use template we use render_template under the hood we are using JINJA2
    return render_template('Views/about.html', params=params)

# CONTACT


@app.route('/contact', methods=['GET', 'POST'])
def contact():
    if request.method== 'GET':
        return render_template('Views/contact.html',params=params)
    
    if request.method == 'POST':
        '''Add entry to the db'''
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        msg = request.form.get('msg')
        entry = Contacts(name=name, phone_num=phone, msg=msg,
                         date=datetime.now(), email=email)
        # here db.session is used to execute db command
        db.session.add(entry)
        db.session.commit()
        mail.send_message("New messsage from " + name,
                          sender=email,
                          recipients=[params["gmail-username"]],
                          body=msg + "\n" + phone)
        flash('Message sent! Thanks for your interest in our blog. We will get back to you soon.', category='success')
    # to use template we use render_template under the hood we are using JINJA2
    return redirect('/')

# Render Blog
# if youre pssing string in your url then you need to pass that as a parameter in that function as it is a rule


@app.route('/<string:post_slug>/<string:sno>', methods=['GET'])
def post_route(post_slug, sno):
    # fetching data from db
    post = Posts.query.filter_by(sno=sno).first()
    # print(type(post))
    # to use template we use render_template under the hood we are using JINJA2
    return render_template('Views/post.html', params=params, post=post)

# CRUD

# READ with login functionality


@app.route('/dashboard', methods=["GET", "POST"])
def dashboard():
    if 'user' in session and session['user'] == params['admin_user']:
        # reading
        posts = Posts.query.all()
        return render_template('Views/dashboard.html', params=params, posts=posts)
    if request.method == 'POST':
        username = request.form.get('uname')
        userpass = request.form.get('password')
        if (username == params["admin_user"] and userpass == params["admin_password"]):
            # set the session
            session['user'] = username
            posts = Posts.query.all()
            flash("You have been logged in successfully!")
            return render_template('Views/dashboard.html', params=params, posts=posts)

    return render_template('Views/login.html', params=params)

# logout thr user by default it takes get method


@app.route('/logout')
def logout():
    session.pop('user')
    flash('You have been logged out succesfully!')
    return redirect("/dashboard")


# add (CREATE)
@app.route('/add', methods=["GET", "POST"])
def add():
    if 'user' in session and session['user'] == params['admin_user']:
        if request.method == "GET":
            # for creating
            return render_template('Views/addBlog.html', params=params)
        # CREATE
        if request.method == 'POST':
            '''sno,title,slug,subheading,content,date,img_file'''
            title = request.form.get('title')
            slug = request.form.get('slug')
            subheading = request.form.get('subheading')
            content = request.form.get('content')
            img_file = request.form.get('img_file')
            date = datetime.now()

            new_blog = Posts(title=title, slug=slug, subheading=subheading,
                             content=content, img_file=img_file, date=date)
            db.session.add(new_blog)
            db.session.commit()
            flash("Your blog has been added successfully!")

    return redirect('/dashboard')


# EDIT (put by post)
@app.route('/edit/<string:sno>', methods=["GET", "POST"])
def edit(sno):
    if 'user' in session and session['user'] == params['admin_user']:
        # For editing template
        if Posts.query.filter_by(sno=sno).first() and request.method == 'GET':
            # print(request.method)
            post = Posts.query.filter_by(sno=sno).first()
            # print(pst)
            return render_template('Views/editBlog.html', params=params, post=post, sno=sno)

        # edit
        elif request.method == 'POST':
            '''sno,title,slug,subheading,content,date,img_file'''
            title = request.form.get('title')
            slug = request.form.get('slug')
            subheading = request.form.get('subheading')
            content = request.form.get('content')
            img_file = request.form.get('img_file')
            date = datetime.now()

            edit_blog = Posts.query.filter_by(sno=sno).first()
            edit_blog.title = title
            edit_blog.slug = slug
            edit_blog.subheading = subheading
            edit_blog.content = content
            edit_blog.image = img_file
            edit_blog.date = date
            db.session.commit()
            flash("Your blog has been edited successfully!")

    return redirect('/dashboard')

# DELETE


@app.route('/delete/<string:sno>')
def delete(sno):
    if 'user' in session and session['user'] == params["admin_user"]:
        del_blog = Posts.query.filter_by(sno=sno).first()
        db.session.delete(del_blog)
        db.session.commit()
        flash("Your blog has been deleted successfully!")
        return redirect("/dashboard")

# upload your file for backgrounds


@app.route('/upload', methods=["POST"])
def upload():
    if 'user' in session and session['user'] == params['admin_user']:
        if request.method == 'POST':
            f = request.files['upload']
            # securing file
            f.save(os.path.join(
                app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))
            flash("Your file has been uploaded successfully!")
    return redirect('/dashboard')


app.run(debug=True)
# if we provide debug=True we just need to relaod we dont need to run app again n again
