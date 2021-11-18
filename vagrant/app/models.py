from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()


class ItemsModel(db.Model):
    """
    Defines the items model
    """

    __tablename__ = "items"

    id = db.Column("id", db.Integer, primary_key=True)
    name = db.Column("name", db.String)
    price = db.Column("price", db.Integer)

    def __init__(self, id, name, price):
        self.id = id
        self.name = name
        self.price = price

    def __repr__(self):
        return f"<Item {self.name}>"

    @property
    def serialize(self):
        """
        Return item in serializeable format
        """
        return {"id": self.id, "name": self.name, "price": self.price}
