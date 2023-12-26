import streamlit as st
from database import add_data


def create():
    col1, col2 = st.columns(2)
    with col1:
        Train_No = st.text_input("Train_No:")
        Name = st.text_input("Name:")
        Train_Type = st.selectbox("Train Type", ["Mail", "Fast", "Superfast"])
    with col2:
        Source = st.selectbox("Source", ["Bengaluru", "Chennai", "Mangaluru", "Mysuru"])
        Destination = st.selectbox(
            "Destination", ["Bengaluru", "Chennai", "Mangaluru", "Mysuru"]
        )
        Availability = st.selectbox("Availability", ["Yes", "No"])
    if st.button("Add Train"):
        add_data(Train_No, Name, Train_Type, Source, Destination, Availability)
        st.success("Successfully added Train: {}".format(Name))
