# GET /nearby


## Parameters

| Parameter |  Required?  |   |   |   |
|-----------|-----------  |---|---|---|
| lat       | yes         |   |   |   |
| lng       | yes         |   |   |   |
| category  | optional    |   |   |   |



# 1) Nearby Coffee shops around Friedrichstraße 129

```
GET /nearby
    ?lat=52.5213982
    &lng=13.4328949
```

# 2) Nearby Restaurants around Friedrichstraße 129

```
GET /nearby
    ?lat=52.5213982
    &lng=13.4328949
    &category=restaurants
```
