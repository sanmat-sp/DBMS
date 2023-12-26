import datetime

import pandas as pd
import streamlit as st
from database import view_all_data, view_only_train_numbers, get_train, edit_train_data


def update():
    result = view_all_data()
    # st.write(result)
    df = pd.DataFrame(
        result,
        columns=[
            "Train_No",
            "Name",
            "Train_Type",
            "Source",
            "Destination",
            "Availability",
        ],
    )
    with st.expander("Current Data"):
        st.dataframe(df)
    list_of_trains = [i[0] for i in view_only_train_numbers()]
    selected_train = st.selectbox("Select Train to Edit", list_of_trains)
    selected_result = get_train(selected_train)
    # st.write(selected_result)
    if selected_result:
        Train_No = selected_result[0][0]
        Name = selected_result[0][1]
        Train_Type = selected_result[0][2]
        Source = selected_result[0][3]
        Destination = selected_result[0][4]
        Availability = selected_result[0][5]

        # Layout of Create
        train_types = ["Mail", "Fast", "Superfast"]
        cities = ["Bengaluru", "Chennai", "Mangaluru", "Mysuru"]
        availabilities = ["Yes", "No"]
        col1, col2 = st.columns(2)
        with col1:
            new_Train_No = st.text_input("Train_No:", Train_No)
            new_Name = st.text_input("Name:", Name)
            new_Train_Type = st.selectbox("Train_Type", train_types, index = train_types.index(Train_Type))
        with col2:
            new_Source = st.selectbox(
                "Source", cities, index = cities.index(Source)
            )
            new_Destination = st.selectbox(
                "Destination", cities, index = cities.index(Destination)
            )
            new_Availability = st.selectbox("Availability", availabilities, index = availabilities.index(Availability))
        if st.button("Update Train"):
            edit_train_data(
                new_Train_No,
                new_Name,
                new_Train_Type,
                new_Source,
                new_Destination,
                new_Availability,
                Train_No,
                Name,
                Train_Type,
                Source,
                Destination,
                Availability,
            )
            st.success(
                "Successfully updated Availability of Train {} :: {} to {}".format(
                    Train_No, Availability, new_Availability
                )
            )

    result2 = view_all_data()
    df2 = pd.DataFrame(
        result2,
        columns=[
            "Train_No",
            "Name",
            "Train_Type",
            "Source",
            "Destination",
            "Availability",
        ],
    )
    with st.expander("Updated data"):
        st.dataframe(df2)
