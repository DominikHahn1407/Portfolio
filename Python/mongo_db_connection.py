import pymongo
import certifi

USERNAME = "<username>"
PASSWORD = "<password>"


class MongoDB():
    def __init__(self):
        self.cluster = pymongo.MongoClient(
            f"mongodb+srv://{USERNAME}:{PASSWORD}@cluster0.ucpvim8.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0", tlsCAFile=certifi.where())
        self.db = self.cluster["UserData"]
        self.collection = self.db["python_mongo"]

    def get_data(self):
        cursor = self.collection.find({})
        data = []
        for document in cursor:
            data.append(document)
        return data

    def insert_data(self, data):
        self.collection.insert_one(data)

    def insert_data_multiple(self, list_data):
        self.collection.insert_many(list_data)

    def update_data(self, id_value, data):
        self.collection.find_one_and_update(
            {"_id": id_value}, {"$set": data})

    def delete_data(self, data):
        self.collection.delete_one(data)


mongo = MongoDB()
mongo.insert_data({"_id": 0, "user_name": "Peter"})
mongo.insert_data({"_id": 100, "user_name": "Dirk"})
mongo.delete_data({"_id": 0, "user_name": "Peter"})
mongo.delete_data({"_id": 100, "user_name": "Dirk"})
mongo.insert_data_multiple([{"_id": 0, "user_name": "Peter"}, {
                           "_id": 100, "user_name": "Dirk"}])
mongo.update_data(0, {"user_name": "Agathe"})
print(mongo.get_data())
