json.(item, :id)
json.bait item.bait, partial: 'baits/bait', as: :bait

# Example:
#  {
#    "id": 1,
#    "bait": {
#      "id": 1,
#      "name": "Fat Rap",
#      "category": "Crankbait",
#      "image_url": "http://localhost:3000/assets/fat-rap.png"
#    }
#  }
