# silent-water

***

`silent-water` aims to:

1. manage the data engineering lifecycle of open source data sets that I find interesting; and
2. serve as proof of concept for setting up an ETL project using the open data stack.

***

## Run the app

Build the image:
```cmd
docker build -f Dockerfile . -t silent-water
```

Run the container:
```cmd
docker run --name silent-water -p 3000:3000 silent-water
```

Create all assets by clicking on __Materialize All__.

***
