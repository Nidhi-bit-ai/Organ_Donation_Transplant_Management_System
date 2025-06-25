from flask import Flask, render_template, session, request, redirect, url_for
import mysql.connector

# MySQL database connection
mydb = mysql.connector.connect(
    host='localhost',
    user='root',
    password='Nidhi#11',
    database='organ_transplant_system'
)
mycursor = mydb.cursor(buffered=True)

app = Flask(__name__)
app.secret_key = 'your_secret_key'

# ------------------------- HOME & LOGIN -----------------------------

@app.route('/')
def index():
    return redirect(url_for('login'))

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        mycursor.execute("SELECT * FROM login WHERE username = %s", (username,))
        user = mycursor.fetchone()
        if user and user[1] == password:
            session['admin'] = True
            return redirect(url_for('dashboard'))
        else:
            return render_template('login.html', error='Invalid credentials')
    return render_template('login.html')

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('login'))

# ------------------------- DASHBOARD -----------------------------

@app.route('/dashboard')
def dashboard():
    if not session.get('admin'):
        return redirect(url_for('login'))
    return render_template('dashboard.html')

# ---------------------- REGISTER ROUTES --------------------------

@app.route('/register_recipient', methods=['GET', 'POST'])
def register_recipient():
    if request.method == 'POST':
        data = [request.form.get(f) for f in [
            'Recipient_ID', 'Name', 'Date_of_Birth', 'Medical_insurance',
            'Medical_history', 'Street', 'City', 'State'
        ]]
        db_cursor.execute("INSERT INTO Recipient VALUES (%s,%s,%s,%s,%s,%s,%s,%s)", data)
        db_connection.commit()
        return redirect(url_for('dashboard'))
    return render_template('register_recipient.html')


@app.route('/register_contributor', methods=['GET', 'POST'])
def register_contributor():
    if request.method == 'POST':
        data = [request.form.get(f) for f in [
            'Contributor_ID', 'donated_organ', 'reason_of_donation', 'Institution_ID', 'Recipient_ID'
        ]]
        db_cursor.execute("INSERT INTO Contributor VALUES (%s, %s, %s, %s, %s)", data)
        db_connection.commit()
        return redirect(url_for('dashboard'))
    return render_template('register_contributor.html')

@app.route('/register_receiver', methods=['GET', 'POST'])
def register_receiver():
    if request.method == 'POST':
        data = [request.form.get(f) for f in [
            'Receiver_ID', 'required_organ', 'reason_of_procurement', 'Surgeon_ID', 'Recipient_ID'
        ]]
        db_cursor.execute("INSERT INTO Receiver VALUES (%s, %s, %s, %s, %s)", data)
        db_connection.commit()
        return redirect(url_for('dashboard'))
    return render_template('register_receiver.html')

# ---------------------- VIEW ROUTES --------------------------

@app.route('/view_recipients')
def view_recipients():
    if not session.get('admin'):
        return redirect(url_for('login'))
    mycursor.execute("SELECT * FROM Recipient")
    recipients = mycursor.fetchall()
    return render_template('view_recipients.html', recipients=recipients)

@app.route('/view_contributors')
def view_contributors():
    mycursor.execute("""
        SELECT 
            r.Name AS name,
            r.Date_of_Birth AS dob,
            r.Medical_history AS blood,
            c.donated_organ AS organ,
            p.phone_no AS phone,
            c.Contributor_ID AS id
        FROM Contributor c
        JOIN Recipient r ON c.Recipient_ID = r.Recipient_ID
        LEFT JOIN Recipient_phone_no p ON r.Recipient_ID = p.Recipient_ID
    """)
    rows = mycursor.fetchall()

    contributors = []
    for row in rows:
        contributors.append({
            'name': row[0],
            'dob': row[1],
            'blood': row[2],
            'organ': row[3],
            'phone': row[4],
            'id': row[5]
        })

    return render_template('view_contributors.html', contributors=contributors)


@app.route('/view_receivers')
def view_receivers():
    mycursor.execute("""
        SELECT 
            r.Name AS name,
            r.Date_of_Birth AS dob,
            r.Medical_history AS blood,
            rec.required_organ AS organ,
            r.State AS severity,
            rec.Receiver_ID AS id
        FROM Receiver rec
        JOIN Recipient r ON rec.Recipient_ID = r.Recipient_ID
    """)
    rows = mycursor.fetchall()

    receivers = []
    for row in rows:
        receivers.append({
            'name': row[0],
            'dob': row[1],
            'blood': row[2],
            'organ': row[3],
            'severity': row[4],
            'id': row[5]
        })

    return render_template('view_receivers.html', receivers=receivers)

# ---------------------- SEARCH ROUTES --------------------------

@app.route('/search_recipient', methods=['GET', 'POST'])
def search_recipient():
    if not session.get('admin'):
        return redirect(url_for('login'))
    if request.method == 'POST':
        rid = request.form['Recipient_ID']
        mycursor.execute("SELECT * FROM Recipient WHERE Recipient_ID = %s", (rid,))
        result = mycursor.fetchone()
        if result:
            return render_template('recipient_profile.html', recipient=result)
        return render_template('search_recipient.html', error='Recipient not found')
    return render_template('search_recipient.html')

@app.route('/search_contributor', methods=['GET', 'POST'])
def search_contributor():
    if not session.get('admin'):
        return redirect(url_for('login'))
    if request.method == 'POST':
        cid = request.form['Contributor_ID']
        mycursor.execute("SELECT * FROM Contributor WHERE Contributor_ID = %s", (cid,))
        result = mycursor.fetchone()
        if result:
            return render_template('contributor_profile.html', contributor=result)
        return render_template('search_contributor.html', error='Contributor not found')
    return render_template('search_contributor.html')

@app.route('/search_receiver', methods=['GET', 'POST'])
def search_receiver():
    if not session.get('admin'):
        return redirect(url_for('login'))
    if request.method == 'POST':
        rid = request.form['Receiver_ID']
        mycursor.execute("SELECT * FROM Receiver WHERE Receiver_ID = %s", (rid,))
        result = mycursor.fetchone()
        if result:
            return render_template('receiver_profile.html', receiver=result)
        return render_template('search_receiver.html', error='Receiver not found')
    return render_template('search_receiver.html')

if __name__ == '__main__':
    app.run(debug=True)
