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
