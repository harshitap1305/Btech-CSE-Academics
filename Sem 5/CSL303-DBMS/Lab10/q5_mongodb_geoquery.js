// Create 2dsphere index
db.restaurants.createIndex({ location: "2dsphere" });

// Find restaurants in 5 km
db.restaurants.find({
  location: {
    $near: {
      $geometry: {
        type: "Point",
        coordinates: [-73.98, 40.77]
      },
      $maxDistance: 5000
    }
  }
});

