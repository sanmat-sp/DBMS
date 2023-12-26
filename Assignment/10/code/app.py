import streamlit as st
import mysql.connector

from create import create
from database import create_table
from delete import delete
from read import read
from update import update

mydb = mysql.connector.connect(host="localhost", user="root", password="mysql")
c = mydb.cursor()

c.execute("CREATE DATABASE IF NOT EXISTS railway_reservation_390;")

def main():
    st.title("Railway Reservation Database - PES1UG20CS390")
    menu = ["Add", "View", "Edit", "Remove"]
    choice = st.sidebar.selectbox("Menu", menu)

    create_table()
    if choice == "Add":
        st.subheader("Enter Train Details:")
        create()

    elif choice == "View":
        st.subheader("View all Trains")
        read()

    elif choice == "Edit":
        st.subheader("Update train details:")
        update()

    elif choice == "Remove":
        st.subheader("Delete train details:")
        delete()

    else:
        st.subheader("About tasks")


if __name__ == "__main__":
    main()


#py -m streamlit run hello.py