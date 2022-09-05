json.array! @catches do |aCatch|
  json.(aCatch, :id, :species, :weight, :length, :created_at)

  json.bait aCatch.bait.name
  json.bait_image_url image_url(aCatch.bait.image)

  json.username aCatch.user.username
end

# Example
#  [
#    {
#      "id": 1,
#      "species": "Lake Trout",
#      "weight": "3.0",
#      "length": "21.5",
#      "created_at": "2018-09-24 23:07:54 UTC",
#      "bait": "Fat Rap",
#      "bait_image_url": "http://localhost:3000/assets/fat-rap.png",
#      "username": "nicole"
#    },
#    {
#      "id": 2,
#      "species": "Brown Trout",
#      "weight": "2.0",
#      "length": "18.0",
#      "created_at": "2018-10-07 23:06:35 UTC",
#      "bait": "Yummy Gummy",
#      "bait_image_url": "http://localhost:3000/assets/yummy-gummy.png",
#      "username": "mike"
#    }
#  ]