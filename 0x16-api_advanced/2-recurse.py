#!/usr/bin/python3
"""Recursive function that queries the Reddit API and returns
a list containing the titles of all hot articles for a given subreddit."""

import requests


def recurse(subreddit, hot_list=None, after=None, count=0):
    """Returns a list of titles of all hot posts on a given subreddit."""

    if hot_list is None:
        hot_list = []

    url = f"https://www.reddit.com/r/{subreddit}/hot/.json"
    headers = {
        "User-Agent": "linux:0x16.api.advanced:v1.0.0 (by /u/bdov_)"
    }
    params = {
        "after": after,
        "count": count,
        "limit": 100
    }

    try:
        response = requests.get(url, headers=headers, params=params, allow_redirects=False)
        response.raise_for_status()

        data = response.json().get("data", {})
        after = data.get("after")
        count += data.get("dist")

        for child in data.get("children", []):
            hot_list.append(child.get("data", {}).get("title"))

        if after is not None:
            return recurse(subreddit, hot_list, after, count)
        else:
            return hot_list
    except requests.exceptions.RequestException:
        return None


if __name__ == "__main__":
    subreddit = input("Enter the subreddit: ")
    result = recurse(subreddit)

    if result is not None:
        for title in result:
            print(title)
    else:
        print("Subreddit not found or an error occurred.")
