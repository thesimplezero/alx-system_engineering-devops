#!/usr/bin/python3
"""Query Reddit for top ten posts"""

import requests


def top_ten(subreddit):
    """Query Reddit and print titles of the first 10 hot posts"""

    # Reddit API endpoint for getting the top posts
    url = f"https://www.reddit.com/r/{subreddit}/hot.json"

    # Set a custom User-Agent to avoid too many requests error
    headers = {'User-Agent': 'My User Agent 1.0'}

    try:
        # Send a GET request to the Reddit API
        response = requests.get(url, headers=headers, allow_redirects=False)

        if response.status_code == 200:
            data = response.json().get('data', {}).get('children', [])

            # Print titles of the first 10 hot posts
            for child in data[:10]:
                post_data = child.get('data', {})
                print(post_data.get('title'))
        else:
            print("None")
    except requests.RequestException as e:
        print("None")


if __name__ == "__main__":
    subreddit = input("Enter the subreddit: ")
    top_ten(subreddit)
