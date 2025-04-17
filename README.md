# web-scraper-hosting by Mohit Soni (mohitsoniv)


This project demonstrates a multi-stage Docker application that scrapes a user-specified URL using Node.js with Puppeteer and serves the scraped content using a Python Flask web server.

## Project Structure

```
web-scraper-hosting
├── scraper
│   ├── scrape.js
│   ├── package.json
│   └── package-lock.json
├── server
│   ├── server.py
│   └── requirements.txt
├── Dockerfile
└── README.md
```

## Prerequisites

- Docker installed on your machine.

## Build the Docker Image

To build the Docker image, navigate to the project directory and run the following command:

```bash
docker build -t web-scraper-hosting .
```

## Run the Container

To run the container, use the following command, replacing `<URL_TO_SCRAPE>` with the URL you want to scrape:

```bash
docker run -e SCRAPE_URL=<URL_TO_SCRAPE> -p 5000:5000 web-scraper-hosting
```
## like :- 
```
docker run -d -p 5000:5000 -v C:\Users\s3verma\Documents\Assign_11\web-scraper-hosting\output:/output web-scraper-hosting
```

## Access the Scraped Data

Once the container is running, you can access the scraped data by navigating to the following URL in your web browser:

```
http://localhost:5000/
```

This will return the scraped content as JSON.

## Notes

- Ensure that the URL you provide is accessible and does not block automated requests.
- The scraped data will include the page title and the first heading of the specified URL.
