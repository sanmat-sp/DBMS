import pandas as pd
import streamlit as st
from database import view_all_data, view_only_train_numbers, delete_data


def delete():
    result = view_all_data()
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
    with st.expander("Current data"):
        st.dataframe(df)

    list_of_trains = [i[0] for i in view_only_train_numbers()]
    selected_train = st.selectbox("Train to Delete", list_of_trains)
    if(selected_train):
        st.warning("Do you want to delete Train {}? This action cannot be reversed!".format(selected_train))
    if st.button("DELETE"):
        delete_data(selected_train)
        st.success("Train {} has been deleted successfully, see Updated data below.".format(selected_train))
    new_result = view_all_data()
    df2 = pd.DataFrame(
        new_result,
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
