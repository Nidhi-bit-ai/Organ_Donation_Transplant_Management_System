# 🏥 Organ Transplant Management - Admin Portal

A secure, web-based admin portal for managing contributors (donors), receivers (patients), surgeons, and institutions involved in organ transplantation. This project is built using **Flask (Python)**, **MySQL**, and **Bootstrap**, with a clean and responsive interface designed for administrative use in healthcare systems.

---

## 📌 Features

✅ Admin authentication system  
✅ Add, view, edit, and delete:
- Contributors (organ donors)
- Receivers (patients needing organs)
- Surgeons
- Institutions

✅ Fully dynamic views of contributor and receiver data from the database  
✅ Cascading deletes using MySQL foreign key constraints  
✅ Responsive, Bootstrap-based UI  

---

## 🛠️ Tech Stack

- **Frontend**: HTML, CSS, Bootstrap 5, Jinja2 Templates  
- **Backend**: Python (Flask)  
- **Database**: MySQL  
- **Other**: MySQL Connector (Python), Session-based routing

---

## 📂 Project Structure

```bash
organ-transplant-system/
├── app/
│   ├── static/
│   │   └── view.css
│   ├── templates/
│   │   ├── dashboard.html
│   │   ├── view_contributors.html
│   │   ├── view_receivers.html
│   │   └── (other pages...)
│   └── main.py
├── schema.sql
├── requirements.txt
└── README.md


![Login Page ](https://github.com/user-attachments/assets/5b15fc3a-f196-4c1d-9666-ad0495db8ef1)
![Home Page](https://github.com/user-attachments/assets/815f6da9-242a-4896-8a34-78ee677b1e0e)
![Register New Recipient page](https://github.com/user-attachments/assets/c07584b8-b9e7-4ed4-9264-9d914ec97f18)
![View Page](https://github.com/user-attachments/assets/2a2fda92-2a64-4b90-a54f-741e2f4620f9)





