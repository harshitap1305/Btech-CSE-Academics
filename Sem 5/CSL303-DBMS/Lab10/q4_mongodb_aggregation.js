db.articles.aggregate([
  { $match: { views: { $gt: 1000 } } },
  { $unwind: "$tags" },
  {
    $group: {
      _id: "$tags",
      avgComments: { $avg: { $size: "$comments" } },
      avgLikes: { $avg: { $avg: "$comments.likes" } }
    }
  },
  { $sort: { avgLikes: -1 } }
]);

