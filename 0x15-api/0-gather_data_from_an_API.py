#!/usr/bin/python3
"""Gather data from a REST API."""

import requests
import sys


def fetch_user_info(user_id):
    """Fetch user information from the API."""
    url = f"https://jsonplaceholder.typicode.com/users/{user_id}"
    response = requests.get(url)
    user_data = response.json()
    return user_data


def fetch_completed_todos(user_id):
    """Fetch and filter completed TODOs for a user from the API."""
    url = "https://jsonplaceholder.typicode.com/todos"
    params = {"userId": user_id}
    response = requests.get(url, params=params)
    todos = response.json()
    completed = [todo["title"] for todo in todos if todo["completed"]]
    return completed


def main():
    if len(sys.argv) != 2:
        print("Usage: python script.py <user_id>")
        sys.exit(1)

    user_id = sys.argv[1]
    user_info = fetch_user_info(user_id)
    completed_todos = fetch_completed_todos(user_id)

    user_name = user_info["name"]
    total_todos = len(completed_todos)
    all_todos = len(user_info)

    summary = (f"Employee {user_name} is done with tasks "
               f"({total_todos}/{all_todos}):")
    print(summary)

    for task in completed_todos:
        indented_task = f"\t{task}"
        print(indented_task)


if __name__ == "__main__":
    main()
