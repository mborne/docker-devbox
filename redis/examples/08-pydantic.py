from db import r

from pydantic import BaseModel, Field
from typing import Optional, List

class User(BaseModel):
    id: str
    name: str
    age: int
    email: Optional[str] = None
    tags: List[str] = Field(default_factory=list)

def save_user(user: User):
    """Sauvegarde un utilisateur en JSON."""
    r.execute_command("JSON.SET", f"user:{user.id}", "$", user.model_dump_json())

def get_user(user_id: str) -> User:
    """Récupère un utilisateur et le reconstruit en objet Pydantic."""
    json_str = r.execute_command("JSON.GET", f"user:{user_id}")
    return User.model_validate_json(json_str)

def update_age(user_id: str, new_age: int):
    """Met à jour un champ spécifique dans le JSON."""
    r.execute_command("JSON.SET", f"user:{user_id}", "$.age", new_age)

def delete_user(user_id: str):
    """Supprime la clé."""
    r.delete(f"user:{user_id}")


alice = User(id="1", name="Alice", age=30, email="alice@example.com", tags=["admin", "beta"])
save_user(alice)
print("✅ Utilisateur 1 enregistré")

robert = User.model_validate_json('{"id":"2","name":"Robert","age":40,"email":"robert@example.com","tags":["alpha"]}')
save_user(robert)
print("✅ Utilisateur 2 enregistré")

u1 = get_user("1")
print("👤 Rechargé depuis Redis :", u1)
print("Nom :", u1.name, "| Âge :", u1.age)

u2 = get_user("2")
print("👤 Rechargé depuis Redis :", u2)
print("Nom :", u2.name, "| Âge :", u2.age)

update_age("1", 31)
print("🧓 Âge mis à jour :", get_user("1").age)

delete_user("1")
print("🚮 Existe encore ?", r.exists("user:1"))

